# Global Developer Defaults

## How to Work With Me

- **Ask before assuming.** If requirements are ambiguous, ask a clarifying question rather than guessing.
- **Plan before coding.** For anything beyond a trivial change, outline your approach before writing code.
- **Work in small steps.** Implement one thing at a time, verify it works, then move on.
- **Read before modifying.** Understand the patterns already in use and follow them.
- **Don't refactor while building.** Note it and move on. Mixing refactoring with feature work makes both harder to review.

## Workflow Rules

- When executing phased implementation plans, start making code changes immediately. Do NOT spend the entire session exploring the codebase without producing output. If exploration is needed, timebox it to 2-3 minutes then begin implementation.
- Always run commands from the correct project directory. Before executing any shell command, verify the current working directory matches the target sub-project. Never mix files between sub-projects (e.g., frontend files into backend folder).

## Communication

- Be direct and concise. Skip preamble.
- Lead with the what and why, not the thought process.
- If something is broken, say what's broken and how to fix it.
- When unsure, say so explicitly with what you'd need to become sure.

## Code Quality Defaults

- Write tests alongside implementation, not after.
- Handle errors explicitly — no silent failures, no bare excepts, no empty catch blocks.
- Prefer readability over cleverness.
- Use meaningful names. If you need a comment to explain what a variable is, rename it.
- Follow existing project conventions. Consistency beats preference.
- Don't leave dead code, TODOs without context, or commented-out blocks.
- Comment the code only when neccessary. If you find yourself writing a comment, consider if the code can be made clearer instead.

## Testing & Verification

After implementing any feature, always run the full test suite.
- For Flutter, at root level, run `make app/build` and then `make app/test`
- For Serverpod, at root level, run `make server/build` and then `make server/test`
Do not consider a phase complete until all checks pass.

## Debugging

- Gather evidence before proposing a fix. Read the error, check the code, understand the cause.
- Don't shotgun-fix by trying multiple things at once. Change one thing, test, iterate.
- If a fix works but you don't understand why, keep investigating.

## Context Awareness

- Use `/compact` proactively when context is getting heavy.
- If you've lost track, re-read the plan or task description before continuing.
- When starting a new task, state what you understand the goal to be before diving in.

## Tech Stack

This project uses Serverpod for backends and Flutter for frontends, typically in a Docker Compose setup. Always assume this stack unless told otherwise.

Global structure:
- `invman_flutter/`: Flutter frontend
- `invman_server/`: Serverpod backend
- `invman_client/`: Serverpod generated code to link frontend and backend

### Serverpod Backend
Official docs if necessary : `https://docs.serverpod.dev/`
#### Project Structure

```
invman_server/
├── bin/
│   └── main.dart                    # Entry point
├── config/
│   ├── development.yaml             # Dev config
│   ├── staging.yaml                 # Staging config
│   ├── production.yaml              # Production config
│   ├── test.yaml                    # Test config
│   └── passwords.yaml               # Secrets storage
├── lib/
│   ├── server.dart                  # Server initialization & auth setup
│   └── src/
│       ├── generated/               # Auto-generated (DO NOT EDIT)
│       ├── di.dart                  # DI configuration
│       ├── di.config.dart           # Generated DI (DO NOT EDIT)
│       ├── env.dart                 # Environment configuration
│       ├── core/                    # Shared utilities
│       │   ├── exceptions/          # ErrorCode, ServerException models
│       │   ├── helpers/             # Middleware, IncludeHelpers
│       │   └── services/            # ApiClientService, MailService
│       └── {feature}/               # Feature modules
│           ├── models/              # .spy.yaml model definitions
│           ├── endpoints/           # Endpoint classes
│           ├── business/            # Service classes
│           └── utils/               # Feature-specific utilities
├── migrations/                      # Database migrations
└── test/                            # Tests
```

#### Code Generation

After modifying `.spy.yaml` files:

```bash
# From project root
make server/build
```

#### Endpoints
Endpoints should always extend `Endpoint` and use `EndpointMiddleware` for consistent error handling and response formatting. Example:

```dart
class CurrencyEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  Future<List<Currency>> list(Session session) async {
    return withMiddleware(
      session,
      () => getIt<CurrencyService>().list(session),
    );
  }
}
```

#### Dependency Injection
Use `getIt` and `injectable` for DI. Annotate injectable classes with `@injectable`, `@singleton`, `@lazySingleton`, etc. Then generate the DI code using `make server/build`.

#### DB Transactions
Serverpod provides a `session.db.transaction` method for handling transactions. Always use the appropriate transaction level. Link the docs if necessary: `https://docs.serverpod.dev/concepts/database/transactions`

#### DB Migrations
Never update migrations files yourself, to generate a new migration execut `make server/migration`

### Flutter Frontend
dart MCP accessible

#### Project Structure

```
lib/
├── main.dart                          # App entry, DI init, MaterialApp
├── di.dart & di.config.dart          # GetIt + Injectable setup
├── env.dart                          # Environment/flavor config
├── config/
│   ├── l10n/                         # ARB localization files
│   ├── theme/                        # Material 3 ThemeData
│   └── generated/                    # Generated l10n code
├── core/
│   ├── models/                       # Enums, shared domain models
│   ├── components/                   # Base UI components
│   │   ├── base/                    # BaseScreen, BaseStateComponent
│   │   ├── buttons/                 # Custom button components
│   │   ├── infinite_list/           # Pagination wrapper
│   │   └── appbar/                  # Custom app bars
│   ├── controllers/                  # Base controller classes
│   │   ├── pagination_controller.dart
│   │   ├── detail_controller.dart
│   │   └── commands/                # Reusable command patterns
│   ├── repositories/                 # Shared helpers (safeCall)
│   ├── sources/                      # Data sources (storage)
│   ├── modules/                      # DI modules
│   ├── navigation/                   # GoRouter config
│   └── utils/
│       ├── constants/               # UI constants
│       ├── extensions/              # Utility extensions
│       ├── ui_utils/                # Toast, dialog utilities
│       └── validation_utils.dart
├── features/
│   └── {feature}/
│       ├── screens/                 # Full-page widgets
│       ├── controllers/             # Feature state management
│       ├── repositories/            # API calls via Serverpod client
│       ├── components/              # Feature-specific widgets
│       ├── models/                  # Feature-specific models (if any)
│       └── routes.dart              # GoRouter branch definition
```

#### Models
Always use the Serverpod client models for data coming from the backend.

#### Repositories
Repositories wrap Serverpod client calls and handle errors with `safeCall()`.

```dart
@lazySingleton
class InvestmentRepository {
  final Client client;

  const InvestmentRepository(this.client);

  Future<Either<String, Investment>> retrieve(int id) async {
    return safeCall(() async {
      return right(await client.investment.retrieve(id));
    });
  }

  ...
}
```

**Conventions:**
- Return `Either<String, T>` — `left` for error message, `right` for success
- Use `safeCall()` to wrap all API calls
- One repository per feature
- Mark with `@lazySingleton` for DI registration

#### Controllers
Always use base controllers for detail and pagination screens.

```dart
import 'package:fpdart/fpdart.dart';
import 'package:signals_flutter/signals_flutter.dart';

abstract class DetailController<K, T> extends AsyncSignal<T> {
  final K id;

  DetailController(this.id) : super(AsyncState.loading()) {
    _fetch();
  }

  ...
}

```dart
import 'package:fpdart/fpdart.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:signals_flutter/signals_flutter.dart';

abstract class PaginationController<T> {
  final Signal<PagingState<int, T>> state = signal(PagingState());

  PaginationController() {
    fetchNextPage();
  }

  ...
}
```

Custom controllers can be made for other porpose, but signals should always be used for state management.

#### Dependency Injection
Use `getIt` and `injectable` for DI. Annotate injectable classes with `@injectable`, `@singleton`, `@lazySingleton`, etc. Then generate the DI code using `make app/build`.

#### Screens
Always use the BaseScreen component for consistent layout :

```dart
class BaseScreen extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final PreferredSizeWidget? appBarMd;
  final PreferredSizeWidget? appBarLg;

  ...
}
```

Then for the body, if the controller of the component is an AsyncSignal, use BaseStateComponent to handle loading and error states:

```dart
class BaseStateComponent<T> extends StatelessWidget {
  final Widget Function(T data) successBuilder;
  final AsyncSignal<T> state;

  const BaseStateComponent({super.key, required this.state, required this.successBuilder});

  @override
  Widget build(BuildContext context) {
    return state
        .watch(context)
        .map(
          data: (data) => successBuilder(data),
          error: (error, _) => ErrorComponent(error: error, handleRefresh: () => state.refresh()),
          loading: () => const LoadingComponent(),
        );
  }
}
```

If you need a custom app bar that also depends on the same controller, you can use BaseStateAppbar:

```dart
class BaseStateAppbar<T> extends StatelessWidget implements PreferredSizeWidget {
  final AsyncSignal<T> state;
  final PreferredSizeWidget Function(T data) successBuilder;
  final double height;

  const BaseStateAppbar({super.key, required this.state, required this.successBuilder, this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return state
        .watch(context)
        .map(data: (data) => successBuilder(data), error: (error, _) => AppBar(), loading: () => AppBar());
  }
}
```