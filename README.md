# toss_sdk_flutter

A Flutter project for testing Toss SDK integration

## 🚀 Getting Started

This project is a starting point for a Flutter application that will integrate with Toss SDK.

### Prerequisites
- Flutter SDK (3.10.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- Xcode (for iOS development)

### Installation

1. Clone the repository
```bash
git clone https://github.com/efforthye/toss_sdk_flutter.git
cd toss_sdk_flutter
```

2. Install dependencies
```bash
flutter pub get
```

3. Set up environment variables
```bash
cp .env.example .env
# Configure the required values in .env file
```

4. Run the app
```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── core/
│   ├── constants/           # App constants
│   ├── utils/              # Utility functions
│   └── theme/              # App theme configuration
├── data/
│   ├── models/             # Data models
│   ├── repositories/       # Data repositories
│   └── services/           # API services
├── presentation/
│   ├── pages/              # UI pages
│   ├── widgets/            # Reusable widgets
│   └── providers/          # State management
└── domain/
    ├── entities/           # Business entities
    └── usecases/           # Business logic
```

## 🛠 Tech Stack

- **Framework**: Flutter
- **State Management**: Provider
- **HTTP Client**: Dio
- **Secure Storage**: Flutter Secure Storage
- **Environment Variables**: Flutter Dotenv

## 📝 Commit Convention

```
feat: add new feature
fix: bug fix
docs: documentation changes
style: code formatting, missing semicolons, etc.
refactor: code refactoring
test: adding/modifying tests
chore: build process or auxiliary tool changes
```

Examples:
```
feat: add toss payment integration
fix: resolve payment validation error
docs: update README with setup instructions
```

## 📱 Features

- Basic Flutter app structure
- Environment configuration
- Theme setup with Toss design colors
- Provider state management setup
- Ready for Toss SDK integration

## 📄 License

MIT License