# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter quiz application called "Quiz Iradat" that implements psychological assessment tools (DASS-21, SRQ-20, SMFA-10). The app follows Clean Architecture with GetX state management.

## Development Commands

Since Flutter/Dart tools may not be in PATH, use these commands based on your Flutter installation:

```bash
# Run the application
flutter run

# Build for production
flutter build apk --release    # Android
flutter build ios --release    # iOS

# Run tests
flutter test

# Analyze code (linting)
flutter analyze

# Format code
dart format .

# Get dependencies
flutter pub get

# Clean build artifacts
flutter clean
```

## Architecture

### Clean MVVM Architecture with GetX
The codebase follows a simplified MVVM-like pattern with GetX state management:

### State Management
- **GetX**: Used for state management, routing, and dependency injection
- **Controllers**: Direct repository communication, reactive state with `.obs` and `Rxn<T>`
- **Dependency Injection**: Centralized in `lib/core/di/app_bindings.dart`

### Key Patterns
- **Simple Error Handling**: Uses `try/catch` with `null` returns and `Get.snackbar` for user feedback
- **Repository Pattern**: Direct data access with simple API calls
- **Equatable Models**: Unified models using Equatable for value equality
- **Feature-based Structure**: Each feature contains data, models, presentation, and binding

## Project Structure

```
lib/
├─ core/
│  ├─ constants/               # App constants (URLs, keys)
│  ├─ di/                      # app_bindings.dart (global DI)
│  └─ network/                 # api_client.dart (HTTP with auto token)
├─ features/
│  ├─ auth/
│  │  ├─ data/                 # auth_repository.dart
│  │  ├─ models.dart           # User, OnboardingItem (Equatable)
│  │  ├─ presentation/
│  │  │  ├─ controllers/       # auth_controller.dart, onboarding_controller.dart
│  │  │  └─ pages/             # login_page.dart, register_page.dart, onboarding_page.dart
│  │  └─ auth_binding.dart
│  ├─ home/
│  │  ├─ presentation/
│  │  │  ├─ controllers/       # home_controller.dart
│  │  │  └─ pages/             # home_page.dart
│  │  └─ home_binding.dart
│  └─ profile/
│     ├─ data/                 # profile_repository.dart
│     ├─ models.dart           # Profile, ProfileUpdate (Equatable)
│     ├─ presentation/
│     │  ├─ controllers/       # profile_controller.dart
│     │  └─ pages/             # profile_page.dart
│     └─ profile_binding.dart
├─ settings/
│  └─ supabase.dart            # Backend URL configuration
├─ app_routes.dart             # Unified routing (AppRoutes + AppPages)
└─ main.dart
```

## Key Dependencies

- **GetX**: State management and navigation
- **http**: HTTP client for API calls
- **flutter_secure_storage**: Secure data storage
- **equatable**: Value equality comparisons
- **syncfusion_flutter_sliders**: UI components for quizzes
- **flutter_dotenv**: Environment variable management

## Development Notes

### Authentication Flow
- Uses JWT tokens stored in secure storage
- Authentication state managed through AuthRepository
- Login/Register/Logout use cases handle business logic

### Quiz System
- Supports multiple quiz types (DASS-21, SRQ-20, SMFA-10)
- Quiz data stored in JSON files in `lib/data/`
- Questions support different response types (yes/no, slider)

### Navigation
- GetX routing defined in `lib/app_routes.dart`
- Route names in `AppRoutes` class
- Page definitions with bindings in `AppPages`

### Error Handling
- Simple try/catch pattern with null returns
- Get.snackbar for user feedback
- No complex failure hierarchies

### Environment Configuration
- Uses `.env` file for environment variables
- Flutter dotenv for configuration management
- Splash screen configuration in pubspec.yaml

### Testing
- Basic widget test setup in `test/widget_test.dart`
- Follow Flutter testing conventions
- Use `flutter test` to run tests

## Code Style
- Follows standard Dart/Flutter conventions
- Uses flutter_lints for code analysis
- Material 3 design system
- Clean Architecture naming conventions