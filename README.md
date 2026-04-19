# 4 Cartas

A fast-paced, strategic card game for two players built with Flutter. Play against friends in real-time matches using a standard poker deck with special powers and bluffing mechanics.

*This project was created during a 6-hour hackathon.*

## Game Overview

4 Cartas is a competitive card game where two players compete in a series of rounds. Each player starts with 4 face-down cards and takes turns drawing from the deck, swapping cards, and using special abilities to outscore their opponent.

### Key Features

- Real-time multiplayer matches
- Strategic card swapping and discarding
- Special power cards with unique abilities
- Mirror bluffing mechanic
- Cutting system for dramatic comebacks
- Multiple rounds per game, best of series matches

## How to Play

### Setup

- Each player receives 4 face-down cards
- Players take turns peeking at their initial cards
- The deck contains 52 standard cards plus 2 jokers

### Gameplay

1. **Draw Phase**: Draw a card from the deck
2. **Action Phase**: Choose to swap with one of your hand cards or discard
3. **Power Phase**: Use special card powers when available
4. **Mirror Phase**: Attempt to mirror your opponent's card values
5. **Cut Phase**: Declare a cut to potentially steal the round

### Scoring

- Cards score points based on rank (A=1, 2-10=face value, J=11, Q=12, K=13, Joker=-2)
- Lowest total score wins each round
- Failed mirror attempts add penalty points
- Cutting allows winning with a higher score if strictly lower than opponent

### Winning

- Win rounds by having the lowest score (or cutting successfully)
- First to win the required number of rounds wins the game
- Ties result in "golden rounds" with special rules

## Installation

### Prerequisites

- Flutter SDK (version 3.11.5 or higher)
- Dart SDK (included with Flutter)
- Android Studio or Xcode for mobile development
- Firebase project for authentication and data storage

### Setup Steps

1. **Clone the repository**

   ```bash
   git clone https://github.com/ribkeeze/4-cartas.git
   cd 4-cartas
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a Firebase project at https://console.firebase.google.com/
   - Enable Authentication and Firestore
   - Download `google-services.json` for Android and place in `android/app/`
   - Download `GoogleService-Info.plist` for iOS and place in `ios/Runner/`

4. **Run the app**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── app.dart              # Main app widget and theme
├── main.dart             # App entry point
├── router.dart           # Navigation configuration
├── core/                 # Design system and utilities
│   ├── constants.dart
│   ├── design_tokens.dart
│   ├── motion.dart
│   ├── theme.dart
│   └── typography.dart
├── data/                 # Data layer
│   ├── auth_repository.dart
│   ├── firestore_converters.dart
│   ├── room_doc.dart
│   └── room_repository.dart
├── engine/               # Game logic (pure Dart)
│   ├── deck.dart
│   ├── mirror_resolver.dart
│   ├── power_resolver.dart
│   ├── rules.dart
│   ├── scoring.dart
│   └── models/           # Game state models
├── screens/              # UI screens
│   ├── arena_screen.dart
│   ├── home_screen.dart
│   ├── lobby_screen.dart
│   ├── login_screen.dart
│   └── ...
├── state/                # State management
│   ├── auth_providers.dart
│   ├── game_controller.dart
│   ├── providers.dart
│   └── room_providers.dart
└── widgets/              # Reusable UI components
    ├── card_widget.dart
    ├── player_hand_widget.dart
    └── ...
```

## Tech Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: Riverpod
- **Backend**: Firebase (Authentication, Firestore)
- **Navigation**: Go Router
- **Platform Support**: iOS, Android, Web, Desktop

## Development

### Running Tests

```bash
flutter test
```

### Building for Production

```bash
# Android APK
flutter build apk --release

# iOS (requires macOS)
flutter build ios --release

# Web
flutter build web --release
```

### Code Style

The project follows Flutter's recommended linting rules. Run the linter with:

```bash
flutter analyze
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and linting
5. Submit a pull request

## License

This project is private and not intended for public distribution.
