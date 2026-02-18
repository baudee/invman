# Skill: Verify Flutter

## Purpose
Systematic verification checklist for Flutter code. Used by the reviewer agent after code execution.

## Verification Process

Run through each section. Flag issues as PASS, WARN, or FAIL.

### 1. Project Structure
- [ ] Feature-based organization: `features/{name}/screens|controllers|repositories|components|models`
- [ ] Core infrastructure in `core/` (components, controllers, repositories, sources, modules, navigation, utils)
- [ ] File naming follows `snake_case.dart` convention
- [ ] Generated files in expected locations (`di.config.dart`, `config/generated/`)
- [ ] No orphan files outside the expected structure
- [ ] Barrel exports (`components.dart`, `business.dart`, ...) used for clean imports

### 2. Models
- [ ] Serverpod models used from `invman_client` package — not manually created
- [ ] No manual edits to Serverpod-generated model files
- [ ] `copyWith()` used for immutable updates
- [ ] Custom domain models use sealed classes for type-safe states
- [ ] `id == 0` used for create-vs-update logic
- [ ] Model shapes match Serverpod protocol definitions

### 3. Repositories
- [ ] Marked with `@lazySingleton` for DI registration
- [ ] All methods return `Future<Either<String, T>>` (fpdart)
- [ ] All client calls wrapped in `safeCall()` helper
- [ ] Error messages returned via `left()`, success via `right()`

### 4. State Management (Signals)
- [ ] `FlutterSignal<T>` used for basic mutable state
- [ ] `AsyncSignal<T>` used for async operations (detail, edit controllers)
- [ ] `FlutterComputed<T>` used for derived/computed state
- [ ] `signal()` initialization with proper initial values
- [ ] State updates via `.value =` assignment
- [ ] `watch(context)` used in widgets for reactivity
- [ ] No manual `setState()` calls — use Signals

### 5. Controllers
- [ ] List controllers extend `PaginationController<T>`
- [ ] Detail controllers extend `DetailController<K, T>`
- [ ] Edit controllers extend `AsyncSignal<T>` with form management
- [ ] Marked with `@injectable` for DI registration
- [ ] `@factoryParam` used for runtime parameters (IDs)
- [ ] Controllers inject repositories via constructor
- [ ] `id == 0` means create mode, `id > 0` means edit mode

### 6. Pagination Controller
- [ ] Extends `PaginationController<T>` base class
- [ ] Implements `fetchPage(int page)` returning `Either<String, List<T>>`
- [ ] State managed via `Signal<PagingState<int, T>>`
- [ ] `fetchNextPage()` checks `isLoading` and `hasNextPage`
- [ ] `refresh()` resets state and fetches first page
- [ ] Error state set on failure, not thrown

### 7. Edit Controller Pattern
- [ ] Extends `AsyncSignal<T>`
- [ ] Owns `GlobalKey<FormState>` and `TextEditingController`s
- [ ] `_load()` initializes state (create vs edit mode)
- [ ] `_refreshControllers()` populates text controllers from model
- [ ] Setter methods (`setStock()`, `setWithdrawalRule()`) update state with `copyWith()`
- [ ] `submit()` returns `(bool, String?)` tuple for success + message
- [ ] Form validation via `formKey.currentState!.validate()`
- [ ] Business validation before API call
- [ ] `setLoading(value)` during submission
- [ ] Related controllers invalidated after successful save (if applicable)

### 8. Screens
- [ ] Screens extend `HookWidget` when `useMemoized()` is used, otherwise `StatelessWidget`
- [ ] Static `route()` method returns the path string
- [ ] `useMemoized()` used to cache controller instances
- [ ] `getIt<Controller>()` for dependency injection
- [ ] `getIt<Controller>(param1: id)` for factory parameters
- [ ] `BaseScreen` widget used for consistent layout
- [ ] `context.mounted` checked after async operations before navigation

### 9. Base Components
- [ ] `BaseScreen` used with responsive body/appBar variants
- [ ] `BaseStateComponent` used for `AsyncSignal` rendering
- [ ] `InfiniteListComponent` used for paginated lists
- [ ] `LoadingComponent` used for loading states
- [ ] `ErrorComponent` used for error states with retry

### 10. Widgets
- [ ] Extracted when exceeding ~40 lines or reused
- [ ] One widget per file in `components/`
- [ ] `const` constructors with all `final` fields
- [ ] Composition over inheritance (except base classes)
- [ ] `StatelessWidget` by default, `HookWidget` only when hooks needed
- [ ] No deep nesting — sub-widgets extracted at 3-4 levels
- [ ] Data passed as constructor params, not fetched inside leaf widgets

### 11. Dependency Injection
- [ ] `@injectable` used for factory registration (new instance each time)
- [ ] `@singleton` used for singletons (one instance)
- [ ] `@lazySingleton` used for lazy singletons (one instance, created on first use)
- [ ] `@factoryParam` used for runtime parameters
- [ ] `@Injectable(as: Interface)` for interface implementations
- [ ] Constructor injection for all dependencies
- [ ] `getIt<T>()` used to resolve dependencies
- [ ] `configureDependencies()` called in `main()`
- [ ] `make app/build` run after changes

### 12. Routing
- [ ] GoRouter used with `StatefulShellRoute` for bottom nav
- [ ] Feature routes defined in `{feature}/routes.dart`
- [ ] Static `route()` methods on screens return path strings
- [ ] Path parameters use `:id` syntax in route definitions
- [ ] `router.push()`, `router.pushRelative()`, `router.pop()` for navigation
- [ ] `context.pop(value)` for returning values from selection screens
- [ ] Router watches `authManager.state` for auth redirects

### 13. Error Handling
- [ ] `Either<String, T>` used for all repository returns
- [ ] `safeCall()` wraps all Serverpod client calls
- [ ] `ServerException` caught and converted to error string
- [ ] Unknown errors logged to Sentry
- [ ] `result.fold()` used to handle left/right cases
- [ ] `ToastUtils.message()` used to display errors to user
- [ ] `(bool, String?)` tuple returned from controller mutations
- [ ] No swallowed exceptions — every error surfaces or logs

### 14. Forms
- [ ] Edit controller owns form state (`formKey`, `TextEditingController`s)
- [ ] `Form` widget uses controller's `formKey`
- [ ] `TextFormField` uses controller's `TextEditingController`
- [ ] `validator:` uses `ValidationUtils` methods
- [ ] Selection tiles navigate to select screens and call setter methods
- [ ] `SaveButton` calls `controller.submit()` and handles result
- [ ] `ToastUtils.message()` displays success/error
- [ ] `router.pop()` on success

### 15. Lists
- [ ] `InfiniteListComponent` used with `PaginationController`
- [ ] `itemBuilder:` returns tile component
- [ ] Pull-to-refresh calls `controller.refresh()`

### 16. Localization
- [ ] `intl_utils` configured in `pubspec.yaml`
- [ ] Strings defined in `config/l10n/intl_en.arb`
- [ ] `S.current.key` used (not hardcoded strings)
- [ ] Parameterized strings use ICU syntax
- [ ] `make app/build` run after string changes

### 17. Testing
- [ ] `make app/test` passes with no failures
- [ ] `mocktail` for mocking (not `mockito`)
- [ ] Repositories mocked, not Serverpod client directly
- [ ] Controllers tested with mocked repositories
- [ ] Widget tests wrap with `MaterialApp`
- [ ] Tests assert behavior (what user sees), not implementation
- [ ] `Future.delayed(Duration.zero)` for async controller init

### 18. Code Quality
- [ ] `make app/build` passes with no issues
- [ ] No commented-out code
- [ ] No debug `print()` statements
- [ ] Imports organized (dart, package, relative)
- [ ] Consistent naming (camelCase variables, PascalCase classes, snake_case files)
- [ ] `const` constructors used where possible
- [ ] No unused imports or variables

## Output
Produce a output:
```markdown
# Verification Report: [Feature/Phase]
Date: [date]
Reviewer: Claude (automated)

## Summary: [PASS/WARN/FAIL]

## Details
### Project Structure: [PASS/WARN/FAIL]
- [notes]

### Models: [PASS/WARN/FAIL]
- [notes]

### Repositories: [PASS/WARN/FAIL]
- [notes]

### State Management: [PASS/WARN/FAIL]
- [notes]

### Controllers: [PASS/WARN/FAIL]
- [notes]

### Screens: [PASS/WARN/FAIL]
- [notes]

### Widgets: [PASS/WARN/FAIL]
- [notes]

### Dependency Injection: [PASS/WARN/FAIL]
- [notes]

### Routing: [PASS/WARN/FAIL]
- [notes]

### Error Handling: [PASS/WARN/FAIL]
- [notes]

### Forms: [PASS/WARN/FAIL]
- [notes]

### Lists: [PASS/WARN/FAIL]
- [notes]

### Localization: [PASS/WARN/FAIL]
- [notes]

### Testing: [PASS/WARN/FAIL]
- [notes]

### Code Quality: [PASS/WARN/FAIL]
- [notes]

## Issues Found
1. [FAIL] Description + suggested fix
2. [WARN] Description + recommendation

## Recommended Actions
- [ ] Fix: ...
- [ ] Consider: ...
- [ ] Run: `make app/build`
- [ ] Run: `make app/test`
```

## Quick Checks

```bash
# Run all checks
make app/build
make app/test
```

### Common Issues

| Issue | Check | Fix |
|-------|-------|-----|
