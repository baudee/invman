# Skill: Verify Serverpod

## Purpose
Systematic verification checklist for Serverpod backend code. Used by the reviewer agent after code execution.

## Verification Process

Run through each section. Flag issues as PASS, WARN, or FAIL.

### 1. Project Structure
- [ ] Feature-based organization: `src/{feature}/models|endpoints|business|utils`
- [ ] Core infrastructure in `src/core/` (exceptions, helpers, services)
- [ ] File naming follows `snake_case.dart` convention
- [ ] Generated files in `src/generated/` — never edited manually
- [ ] Barrel exports used (`endpoints.dart`, `business.dart`)
- [ ] No orphan files outside the expected structure

### 2. Models (Protocol Definitions)
- [ ] Models defined in `.spy.yaml` files
- [ ] One model per file in `{feature}/models/`
- [ ] Table name specified for database models
- [ ] Relations use proper syntax (`relation`, `relation(onDelete=Cascade)`)
- [ ] List relations use `relation(name=...)` for FK naming
- [ ] Indexes defined for foreign keys
- [ ] `!persist` used for computed/transient fields
- [ ] Optional fields marked with `?`
- [ ] Default values specified where appropriate (`default=now`, `default=0.0`)
- [ ] Enums use `serialized: byName`

### 3. Endpoints
- [ ] Endpoints extend `Endpoint` and mix in `EndpointMiddleware`
- [ ] `requireLogin` property set correctly (true for authenticated endpoints)
- [ ] All method bodies wrapped in `withMiddleware(session, () => ...)`
- [ ] Services injected via `getIt<ServiceType>()`
- [ ] `Session` passed to all service methods
- [ ] Pagination uses default values (`limit = 10, page = 1`)
- [ ] No business logic in endpoints — only delegation to services
- [ ] Standard CRUD naming: `list`, `retrieve`, `save`, `delete`

### 4. Services
- [ ] Marked with `@injectable` for DI registration
- [ ] Dependencies injected via constructor
- [ ] `Session` accepted as first parameter in all methods
- [ ] Optional `Transaction? transaction` parameter for transactional methods
- [ ] Authorization checked: `session.authenticated!.authUserId`
- [ ] Ownership verified before update/delete operations
- [ ] Input validation performed before database operations
- [ ] `ServerException` thrown with appropriate `ErrorCode`

### 5. Database Access
- [ ] `Model.db.find()` used with proper `where:` conditions
- [ ] `Model.db.findById()` used for single record retrieval
- [ ] `Model.db.findFirstRow()` used when expecting one result
- [ ] `Model.db.insertRow()` with `id: null` for new records
- [ ] `Model.db.updateRow()` for existing records
- [ ] `Model.db.deleteRow()` for deletion
- [ ] `include:` parameter used for eager loading
- [ ] `IncludeHelpers` used for consistent include patterns
- [ ] Pagination calculated as `offset: (page * limit) - limit`

### 6. Transactions
- [ ] `session.db.transaction()` used for multi-step operations
- [ ] `TransactionSettings` with appropriate isolation level
- [ ] `IsolationLevel.serializable` for critical operations
- [ ] Transaction parameter passed through entire call chain
- [ ] All operations within transaction use same `transaction:` parameter

### 7. Include Helpers
- [ ] Centralized in `core/helpers/include_helpers.dart`
- [ ] One method per model: `{model}Include()`
- [ ] List relations use `includeList()` with limits where appropriate
- [ ] Nested includes composed hierarchically
- [ ] Latest-only patterns (e.g., latest price) use `limit: 1, orderDescending: true`

### 8. Error Handling
- [ ] `ErrorCode` enum used for all error types
- [ ] `ServerException` thrown with appropriate `ErrorCode`
- [ ] `notFound` for missing resources
- [ ] `forbidden` for authorization failures
- [ ] `badRequest` for validation failures
- [ ] `unauthorized` for authentication failures
- [ ] `unknown` with message for unexpected errors
- [ ] `EndpointMiddleware` catches and logs errors
- [ ] Unknown errors logged with full stack trace
- [ ] No swallowed exceptions

### 9. Validation
- [ ] Required fields checked for empty/null
- [ ] Related entities verified to exist before save
- [ ] Authorization checked before any data access
- [ ] Business rules validated in service layer
- [ ] Validation errors throw `ServerException(errorCode: ErrorCode.badRequest)`

### 10. Authentication
- [ ] `requireLogin => true` set on authenticated endpoints
- [ ] `session.authenticated!.authUserId` used to get current user
- [ ] Resource ownership checked against `userId` field
- [ ] Serverpod auth module used (`EmailIdpBaseEndpoint`, `RefreshJwtTokensEndpoint`)
- [ ] Email verification callbacks implemented
- [ ] Account created in `onAfterAuthUserCreated` hook

### 11. Dependency Injection
- [ ] `@injectable` used for factory registration
- [ ] `@singleton` used for singletons (Env, etc.)
- [ ] `@lazySingleton` used for singletons with lazy initialization
- [ ] `@Injectable(as: Interface)` for interface implementations
- [ ] Constructor injection for all dependencies
- [ ] `getIt<T>()` used to resolve dependencies
- [ ] `configureDependencies()` called in `server.dart`

### 12. Environment Configuration
- [ ] `Env` class handles all environment variables
- [ ] Flavor enum defines environments (develop, staging, production)
- [ ] `getVarFromKey()` throws for missing required vars
- [ ] Sensitive values loaded from `.env` or environment
- [ ] No hardcoded secrets in code

### 13. External API Calls
- [ ] `ApiClientService` used for HTTP requests
- [ ] Proper error handling with `ServerException` mapping
- [ ] Status codes handled appropriately
- [ ] Timeouts configured
- [ ] No raw `http` calls outside `ApiClientService`

### 14. Mail Service
- [ ] Interface defined (`MailServiceInterface`)
- [ ] Implementation registered with DI (`@Injectable(as: MailServiceInterface)`)
- [ ] Emails skipped in development mode
- [ ] Proper error handling for email failures

### 15. Migrations
- [ ] `make server/build` run after model changes
- [ ] You do not create migrations by yourself

### 16. Code Generation
- [ ] `make server/build` run after model changes, or injection annotations
- [ ] Generated files not manually edited
- [ ] No conflicts in generated code

### 17. Testing
- [ ] `make server/test` passes with no failures
- [ ] `mocktail` used for mocking
- [ ] Services tested with mocked dependencies
- [ ] `ServerException` assertions check `errorCode`
- [ ] `withServerpod` used for integration tests
- [ ] Test config uses separate database

### 18. Code Quality
- [ ] `make server/test` passes with no issues
- [ ] No commented-out code
- [ ] No debug `print()` statements (use `session.log()`)
- [ ] Imports organized (dart, package, relative)
- [ ] Consistent naming conventions
- [ ] `const` constructors where applicable
- [ ] No unused imports or variables

### 19. Logging
- [ ] `session.log()` used for logging (not `print()`)
- [ ] Appropriate log levels: `info`, `warning`, `error`, `fatal`
- [ ] Error stack traces included in logs
- [ ] Sensitive data not logged
- [ ] Development logs more verbose than production

## Output
Produce:
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

### Endpoints: [PASS/WARN/FAIL]
- [notes]

### Services: [PASS/WARN/FAIL]
- [notes]

### Database Access: [PASS/WARN/FAIL]
- [notes]

### Transactions: [PASS/WARN/FAIL]
- [notes]

### Include Helpers: [PASS/WARN/FAIL]
- [notes]

### Error Handling: [PASS/WARN/FAIL]
- [notes]

### Validation: [PASS/WARN/FAIL]
- [notes]

### Authentication: [PASS/WARN/FAIL]
- [notes]

### Dependency Injection: [PASS/WARN/FAIL]
- [notes]

### Environment Configuration: [PASS/WARN/FAIL]
- [notes]

### Migrations: [PASS/WARN/FAIL]
- [notes]

### Code Generation: [PASS/WARN/FAIL]
- [notes]

### Testing: [PASS/WARN/FAIL]
- [notes]

### Code Quality: [PASS/WARN/FAIL]
- [notes]

### Logging: [PASS/WARN/FAIL]
- [notes]

## Issues Found
1. [FAIL] Description + suggested fix
2. [WARN] Description + recommendation

## Recommended Actions
- [ ] Fix: ...
- [ ] Consider: ...
- [ ] Run: `make server/build`
- [ ] Run: `make server/test`
```

## Quick Checks

```bash
# Run all checks
make server/build
make server/test
```

### Common Issues

| Issue | Check | Fix |
|-------|-------|-----|

