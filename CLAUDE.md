# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an investment management application built with Flutter and Serverpod. The project consists of three main components:
- **invman_flutter**: Flutter mobile application
- **invman_server**: Serverpod backend server
- **invman_client**: Generated client library for API communication

## Development Commands

### Server Development
```bash
# Generate Serverpod code
make server/build

# Create database migration
make server/migration

# Force create migration (overwrite existing)
make server/migration-force

# Apply migrations to database
make server/migrate

# Run the server
make server/run

# Start Docker containers (database, etc.)
make server/up

# Stop Docker containers
make server/down

# Clean Docker containers and volumes
make server/clean
```

### Flutter App Development
```bash
# Build and generate code
make app/build

# This runs:
# - flutter pub get
# - dart run build_runner build --delete-conflicting-outputs
# - dart run intl_utils:generate
```

### Manual Commands
```bash
# For Flutter app (in invman_flutter directory)
flutter pub get
dart run build_runner build --delete-conflicting-outputs  # Generate Riverpod providers
dart run intl_utils:generate  # Generate localization files

# For server (in invman_server directory)
serverpod generate  # Generate protocol and endpoints
dart bin/main.dart  # Run server
```

## Architecture

### Flutter App (invman_flutter)
- **State Management**: Riverpod 2.x with code generation using `@Riverpod()` annotations
- **Navigation**: GoRouter with StatefulShellRoute for bottom navigation
- **Architecture**: Feature-based with consistent structure:
  - `components/` - UI components
  - `providers/` - Riverpod providers (generated)
  - `screens/` - Full-screen widgets
  - `services/` - Business logic and API calls
  - `models/` - Data models and extensions
  - `routes.dart` - Feature routing

### Main Features
- **investment**: Core investment management
- **stock**: Stock data and selection
- **transfer**: Transfer/transaction management
- **withdrawal**: Withdrawal processing with fees and rules
- **auth**: Authentication system
- **account**: User account management

### Key Patterns
- **Base Classes**: `BaseScreen`, `BaseComponent`, `BaseStateComponent` for consistent UI patterns
- **Error Handling**: Uses `fpdart` Either type with `safeCall()` utility
- **Responsive Design**: Built-in breakpoints (sm, md, lg)
- **Pagination**: `infinite_scroll_pagination` integration
- **Localization**: Flutter intl with generated files

### Server (invman_server)
- **Framework**: Serverpod with authentication
- **Database**: PostgreSQL with migrations
- **Architecture**: Feature-based endpoints matching Flutter features
- **Deployment**: Docker support with AWS/GCP deployment scripts

## Database Schema

Key entities based on the class diagram:
- **Userinfo**: User account information
- **Investment**: Investment records linked to users
- **Stock**: Stock information with symbol, name, value, currency
- **Transfer**: Financial transfers with quantity and amount
- **WithdrawalRule**: Withdrawal rules with fees
- **WithdrawalFee**: Fee structure (fixed, percent, minimum)

## Development Workflow

1. **Protocol Changes**: Modify `.spy` files in `invman_server/lib/src/`
2. **Generate Code**: Run `make server/build` to generate protocol and endpoints
3. **Database Changes**: Run `make server/migration` to create migrations
4. **Flutter Updates**: Run `make app/build` to update client and generate providers
5. **Test**: Start server with `make server/run` and test Flutter app

## Code Generation

The project heavily relies on code generation:
- **Serverpod**: Generates protocol, endpoints, and client code
- **Riverpod**: Generates providers from annotations
- **Intl**: Generates localization files
- **Build Runner**: Orchestrates code generation for Flutter

Always run the appropriate build commands after making changes to annotated files or protocol definitions.