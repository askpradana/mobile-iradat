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

### Clean Architecture Structure
The codebase follows Clean Architecture with three layers:

1. **Domain Layer** (`lib/domain/`):
   - Entities: Business objects (User, Quiz, Question)
   - Repositories: Abstract contracts
   - Use Cases: Business logic operations

2. **Data Layer** (`lib/data/`):
   - Models: Data transfer objects
   - Data Sources: Local (SharedPreferences) and Remote (HTTP)
   - Repository Implementations: Concrete repository classes

3. **Presentation Layer** (`lib/presentation/`, `lib/screens/`, `lib/features/`):
   - Controllers: GetX controllers extending BaseController
   - Views: Flutter widgets and screens
   - Bindings: Dependency injection for controllers

### State Management
- **GetX**: Used for state management, routing, and dependency injection
- **BaseController**: All controllers extend this for common functionality (loading states, error handling)
- **Dependency Injection**: Centralized in `lib/core/services/dependency_injection.dart`

### Key Patterns
- **Either Pattern**: Uses `dartz` for functional error handling (`Either<Failure, Success>`)
- **UseCase Pattern**: Business logic encapsulated in use cases
- **Repository Pattern**: Data access abstraction
- **Failure Classes**: Structured error handling with specific failure types

## Project Structure

```
lib/
├── core/                     # Core utilities and services
│   ├── constants/           # App-wide constants
│   ├── errors/              # Failure and exception classes
│   ├── services/            # Core services (DI, auth storage, logging)
│   └── utils/               # Utility classes and bindings
├── data/                    # Data layer
│   ├── datasources/         # Local and remote data sources
│   ├── models/              # Data models
│   ├── repositories/        # Repository implementations
│   └── *.json              # Local quiz data files
├── domain/                  # Domain layer
│   ├── entities/            # Business entities
│   ├── repositories/        # Repository contracts
│   └── usecases/           # Business use cases
├── features/               # Feature-based modules (newer structure)
│   └── auth/               # Authentication feature
├── screens/                # Screen implementations (legacy structure)
├── presentation/           # Shared presentation layer
└── settings/               # App configuration
```

## Key Dependencies

- **GetX**: State management and navigation
- **http**: HTTP client for API calls
- **flutter_secure_storage**: Secure data storage
- **shared_preferences**: Simple data persistence
- **dartz**: Functional programming (Either pattern)
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
- GetX routing defined in `lib/settings/route_management.dart`
- Route names in `AppRoutes` class
- Page definitions with bindings in `AppPages`

### Error Handling
- Structured failure system with specific failure types
- BaseController provides common error handling methods
- Snackbars for user feedback

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