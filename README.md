# 4 Cartas - Real-Time Multiplayer Card Game

A production-grade Flutter application demonstrating advanced mobile development practices, built in **6 hours** during a hackathon by a collaborative team. Features real-time multiplayer gameplay, complex state management, custom design system, and comprehensive backend infrastructure.

**Live Repository:** https://github.com/ribkeeze/4-cartas-clean

---

## 🎯 Project Overview

4 Cartas is a competitive two-player card game with real-time synchronization, strategic gameplay mechanics, and a polished user experience. This project showcases full-stack mobile development capabilities including:

- **Real-time Multiplayer**: Firestore-driven game state synchronization
- **Complex State Management**: Riverpod providers for authentication, game state, and UI state
- **Game Engine**: Pure Dart business logic with comprehensive turn-based state machine
- **Custom Design System**: Semantic tokens, typography scales, and animation presets
- **Production Architecture**: Repository pattern, clean separation of concerns, scalable structure
- **Planned Features**: Image uploads, Google OAuth, chat, lives system, ad monetization, dynamic skin theming

---

## 🏗️ Technical Highlights

### State Management with Riverpod

- **Async Providers**: FutureProvider for Firebase data fetching with automatic caching
- **Family Providers**: Parametrized providers for room-specific game state
- **State Providers**: Local UI state management (coins, skins, player nicknames)
- **Provider Composition**: Complex state derived from multiple providers

```dart
// Example: Cached coins with auto-invalidation
final userCoinsProvider = FutureProvider.autoDispose<int>((ref) async {
  final uid = await ref.watch(authRepositoryProvider).ensureSignedIn();
  return await fetchCoinsFromFirestore(uid);
});

final addOwnedSkinProvider = FutureProvider.family<void, String>((ref, skinName) async {
  // Updates Firestore, auto-invalidates parent provider
});
```

### Game Engine Architecture

- **Pure Dart Business Logic**: No Flutter dependencies, 100% testable
- **State Reducer Pattern**: `GameState apply(GameState, GameAction) -> GameState`
- **Turn-Based State Machine**:
  - `peekInitial` → `turn` → `cardDrawn` → `power*` → `reveal`
- **Complex Power Resolution**: 7-10 card powers with unique mechanics
- **Mirror Mechanic**: Bluffing system with penalty calculation

### Real-Time Multiplayer

- **Firestore Streams**: Live game state synchronization across devices
- **Optimistic Updates**: Local state updates with sync confirmation
- **Conflict Resolution**: Turn-based design eliminates race conditions
- **Player Presence**: Room-based lobbies with seat assignment

### Firebase Integration

- **Authentication**: Email/password + anonymous auth
- **Firestore**: Denormalized game documents with subcollections
- **Security Rules**: Row-level security ensuring players can only access their games
- **Indexes**: Optimized for real-time stream queries

---

## 🎨 Design System & UI

### Custom Design Tokens (3-Layer Architecture)

```dart
// Primitive layer (raw colors)
static const Color _midnight900 = Color(0xFF111826);

// Semantic layer (roles and meaning)
static const Color bgBase = _midnight900;
static const Color primary = _gold500;

// Component layer (feature-specific)
static const Color cardFace = _paper50;
static const Color turnGlow = _electric500;
```

### Motion & Animation System

- **Motion Presets**: Named animation timings and curves for consistency
- **Interruptible Animations**: State-aware animation controllers
- **Component Animations**: 320ms route transitions, 480ms card reveals, 120ms press feedback

### Typography Scale

- **11 Responsive Styles**: From caption (12px) to hero (48px)
- **Semantic Naming**: `label`, `titleSmall`, `bodyStrong` for clarity
- **Letter Spacing**: Cyberpunk aesthetic with kerning hints

---

## 🎮 Game Features

### Gameplay Mechanics

- **4-Card Hand**: Each player manages 4 face-down cards
- **Turn System**: Draw, Swap, Discard, or Trigger Power
- **Card Powers**: 7/8 (peek own), 9/10 (peek opponent), J/Q (swap), K (decide swap), Joker (wildcard)
- **Mirror Mechanic**: Attempt to guess opponent's hand for score bonus/penalty
- **Cutting System**: Special rule to steal rounds with bluffing
- **Scoring**: A=1, 2-10=face, J=11, Q=12, K=13, Joker=-2

### User Features

- **Authentication**: Secure Firebase auth with display names
- **Shop System**: 10 card skin packs purchasable with in-game coins
- **Purchase History**: "Mis Compras" showing owned skins
- **Coins System**: Cached balance with real-time updates
- **Multiplayer Rooms**: 6-character room codes, max 2 players

---

## 🏛️ Architecture & Best Practices

### Clean Architecture Layers

```
lib/
├── core/                 # Design system (testable, reusable)
│   ├── design_tokens.dart    # Color, spacing, elevation tokens
│   ├── motion.dart           # Animation definitions
│   ├── typography.dart       # Text styles
│   └── theme.dart            # ThemeData composition
│
├── engine/               # Pure Dart game logic (no Flutter!)
│   ├── rules.dart            # State reducer
│   ├── scoring.dart          # Score calculations
│   ├── power_resolver.dart   # Power card logic
│   ├── mirror_resolver.dart  # Mirror bluffing
│   └── models/               # Game state immutable models
│
├── data/                 # Repository pattern
│   ├── auth_repository.dart
│   ├── room_repository.dart
│   └── firestore_converters.dart
│
├── screens/              # UI layer (ConsumerWidget + StatefulWidget)
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── lobby_screen.dart
│   ├── arena_screen.dart
│   ├── tienda_screen.dart
│   └── perfil_screen.dart
│
├── state/                # Riverpod providers
│   ├── providers.dart        # Core app providers
│   ├── auth_providers.dart   # Auth providers
│   └── room_providers.dart   # Room/game providers
│
└── widgets/              # Reusable components
    ├── card_widget.dart
    ├── player_hand_widget.dart
    ├── deck_and_discard_widget.dart
    └── turn_banner.dart
```

### Key Design Decisions

| Decision              | Why                                                             |
| --------------------- | --------------------------------------------------------------- |
| **Riverpod**          | Type-safe provider composition, excellent for real-time streams |
| **Pure Dart Engine**  | Decoupled from UI, fully testable, can be reused on web/CLI     |
| **FireStore Streams** | Real-time by default, scales to thousands of concurrent rooms   |
| **Go Router**         | Declarative routing with deep linking support                   |
| **immutable Models**  | Predictable state machine, easier debugging                     |
| **Semantic Tokens**   | Single source of truth for design, easy theme changes           |

---

## 🚀 Getting Started

### Prerequisites

- Flutter 3.0+ (tested with 3.41.7)
- Dart 3.0+
- Firebase CLI (for deployment)

### Installation

```bash
# Clone repository
git clone https://github.com/ribkeeze/4-cartas-clean.git
cd 4-cartas

# Get dependencies
flutter pub get

# Configure Firebase
# 1. Create project at https://console.firebase.google.com
# 2. Enable Authentication (Email/Password)
# 3. Enable Firestore Database
# 4. Download google-services.json → android/app/
# 5. Download GoogleService-Info.plist → ios/Runner/

# Run
flutter run
```

### Environment Setup

```bash
# Check dependencies
flutter doctor -v

# Analyze code
flutter analyze

# Run tests
flutter test
```

---

## 💡 Key Implementation Highlights

### 1. Real-Time Game Synchronization

```dart
// Players see live state updates without manual refresh
final roomStream = ref.watch(roomStreamProvider(roomCode));
// Automatically refetches when opponent makes a move
```

### 2. Complex State Derivation

```dart
// Derived providers compose simple providers into complex state
final isMyTurnProvider = Provider.family<bool, String>((ref, code) {
  final game = ref.watch(gameStateProvider(code));
  final uid = ref.watch(currentUserIdProvider);
  return game?.turnPlayerId == uid;
});
```

### 3. Immutable Game State

```dart
// State reducer ensures deterministic transitions
GameState apply(GameState state, GameAction action) {
  switch (action) {
    case DrawFromDeck():
      return state.copyWith(
        deck: state.deck..removeLast(),
        drawnCard: state.deck.last,
      );
    // ...
  }
}
```

### 4. Optimized UI Performance

- `autoDispose` providers prevent memory leaks
- `ConsumerWidget` reduces rebuild scope
- Animation controllers prevent jank
- Image caching for card assets

---

## 📊 Technical Metrics

- **Codebase**: ~4,000 lines of Dart
- **Game Engine**: ~1,200 lines pure logic
- **UI Screens**: 6 full-featured screens
- **Providers**: 15+ Riverpod definitions
- **Models**: 12 immutable game state models
- **Build Time**: ~45 seconds (debug)
- **APK Size**: ~65MB (release)
- **Min SDK**: Android 21, iOS 12.0

---

## 🔍 Code Quality

```bash
# Analysis
flutter analyze
# ✓ No issues found

# Testing structure ready for:
# - Unit tests (engine logic)
# - Widget tests (UI components)
# - Integration tests (full game flow)
```

### Notable Patterns Used

- ✅ Repository pattern for data access
- ✅ State reducer pattern (Redux-like)
- ✅ Provider composition
- ✅ Immutable models with copyWith
- ✅ Declarative routing
- ✅ Theme inheritance
- ✅ Error handling with results/exceptions
- ✅ Async/await with proper cancellation

---

## 🎓 Learning Resources in This Project

Study this codebase to learn:

1. **Riverpod Architecture** - Async providers, family modifiers, composition
2. **Firebase Real-Time Apps** - Firestore streams, security rules, data modeling
3. **Game Engine Design** - State machines, turn-based logic, scoring systems
4. **Flutter UI Patterns** - Custom widgets, animations, theming
5. **Clean Architecture** - Separation of concerns, dependency injection
6. **Type-Safety** - Sealed classes, immutability, strong typing

---

## 🚢 Production Readiness

### Implemented

- ✅ Error handling with user feedback
- ✅ Loading states for async operations
- ✅ Secure authentication
- ✅ Data validation
- ✅ Firestore security rules
- ✅ Offline awareness (streams)
- ✅ Real user display names (Firebase)
- ✅ Riverpod state caching for coins
- ✅ Owned skins tracking and display
- ✅ Shop system with purchase history

### In Progress / Planned

- 🔄 **Profile Picture Upload** - Image picker + Firestore Storage integration
- 🔄 **Google Authentication** - OAuth 2.0 sign-in flow
- 🔄 **Real-Time Opponent Names** - Display rival name in lobby and during game
- 🔄 **Enhanced Game Context** - More feedback messages for better UX
- 🔄 **Leave Game Notifications** - Alert opponent when player disconnects
- 🔄 **Ad Monetization** - Double coins reward for watching ads
- 🔄 **Lives System** - Daily lives with ad-based recharge (Candy Crush model)
- 🔄 **Chat System** - Real-time messaging between players
- 🔄 **Dynamic UI Skins** - Theme UI based on purchased card skins
- 🔄 **Todo Management** - Task list for gameplay features
- 🔄 **Performance Optimizations** - Image caching, lazy loading

### Future Improvements

- [ ] Comprehensive unit/widget test suite
- [ ] Player rankings and statistics
- [ ] Seasonal battle pass system
- [ ] Sound effects and haptic feedback
- [ ] Analytics tracking (Firebase Analytics)
- [ ] Performance monitoring (Crashlytics)
- [ ] A/B testing infrastructure
- [ ] Leaderboards with real-time updates
- [ ] Replay system for recorded games
- [ ] Tournament mode for groups

---

## 📱 Platform Support

- ✅ **Android** (API 21+)
- ✅ **iOS** (12.0+)
- ✅ **Web** (responsive design)
- ✅ **macOS** / **Linux** / **Windows** (supported by Flutter)

---

## 🎖️ Hackathon Achievement

**Built in 6 hours** with a focus on:

- Production-quality architecture
- Real-time multiplayer synchronization
- Polished user experience
- Clean, maintainable code

This demonstrates the ability to balance rapid development with sound engineering practices.

---

## � Development Team

**Ezequiel Ribke** - Frontend Developer (Flutter/Dart/UI)
- Architecture and state management design
- Game UI and custom design system
- Real-time game screen implementation
- Riverpod provider architecture

**Mariano Backhaus** - QA & Testing
- Manual testing and bug reporting
- Game balance feedback
- User experience validation
- Feature refinement

**Santiago Franco** - UI/UX Designer
- Visual design and component styling
- User interface layout
- Animation and transition design
- Theme and branding implementation

**Lucas Pasolli** - Backend Developer (Firebase)
- Firebase Authentication setup
- Firestore data modeling and security rules
- Real-time database architecture
- Server-side logic and game state persistence

**Fatima Abigail Pereyra** - Backend Developer (Firestore)
- Firestore collection structure
- Data validation and serialization
- Security rules implementation
- Performance optimization for real-time queries

---

## 📄 License

Private portfolio project. Not for redistribution.

---

## 🎯 Repository

**Live Portfolio:** https://github.com/ribkeeze/4-cartas-clean  
*Built by a collaborative team in 6 hours during a hackathon.*
