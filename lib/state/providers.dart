import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/auth_repository.dart';
import '../data/room_repository.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (_) => FirebaseAuth.instance,
);

final firestoreProvider = Provider<FirebaseFirestore>(
  (_) => FirebaseFirestore.instance,
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.watch(firebaseAuthProvider)),
);

final roomRepositoryProvider = Provider<RoomRepository>(
  (ref) => RoomRepository(ref.watch(firestoreProvider)),
);

/// Player's chosen nickname, lives across Home → Lobby → Game for this device.
final nicknameProvider = StateProvider<String>((_) => '');

// ─── User Data from Firestore ─────────────────────────────────────────────────

/// User's coins/money balance - cached and only refetches on demand.
final userCoinsProvider = FutureProvider.autoDispose<int>((ref) async {
  final uid = await ref.watch(authRepositoryProvider).ensureSignedIn();
  final db = ref.watch(firestoreProvider);
  final doc = await db.collection('users').doc(uid).get();
  return (doc.data()?['coins'] as num?)?.toInt() ?? 0;
});

/// Keeps coins cached across the app life - won't reload unless invalidated.
final cachedCoinsProvider = StateProvider<int?>((ref) => null);

/// Updates cached coins when a purchase happens.
final updateCoinsProvider = FutureProvider.family<void, int>((ref, amount) async {
  final uid = await ref.watch(authRepositoryProvider).ensureSignedIn();
  final db = ref.watch(firestoreProvider);
  await db.collection('users').doc(uid).update({'coins': amount});
  ref.read(cachedCoinsProvider.notifier).state = amount;
});

/// Get user's owned card skin packs - list of pack names.
final userOwnedSkinsProvider = FutureProvider.autoDispose<Set<String>>((ref) async {
  final uid = await ref.watch(authRepositoryProvider).ensureSignedIn();
  final db = ref.watch(firestoreProvider);
  final doc = await db.collection('users').doc(uid).get();
  final skins = (doc.data()?['ownedSkins'] as List<dynamic>?)?.cast<String>() ?? [];
  return skins.toSet();
});

/// Add a skin to user's collection.
final addOwnedSkinProvider = FutureProvider.family<void, String>((ref, skinName) async {
  final uid = await ref.watch(authRepositoryProvider).ensureSignedIn();
  final db = ref.watch(firestoreProvider);
  await db.collection('users').doc(uid).update({
    'ownedSkins': FieldValue.arrayUnion([skinName]),
  });
  // Invalidate the owned skins provider to refetch
  ref.invalidate(userOwnedSkinsProvider);
});
