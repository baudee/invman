# Skill: Serverpod Patterns

## Purpose
Guide Claude Code when implementing Serverpod backend features. Follow these conventions unless the project's CLAUDE.md overrides them.

## Project Structure

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

**Naming conventions:**
- Files: `snake_case.dart` (e.g. `investment_service.dart`)
- Classes: `PascalCase` (e.g. `InvestmentService`)
- Features: singular noun (`investment`, `stock`, `auth`)
- Models: `{feature}.spy.yaml` or `{feature}_{variant}.spy.yaml`
- Endpoints: `{feature}_endpoint.dart`
- Services: `{feature}_service.dart`
- Generated files: in `generated/` — never edit

## Models (Protocol Definitions)

Models are defined in `.spy.yaml` files. Serverpod generates Dart classes from these.

### Basic Model

```yaml
# lib/src/investment/models/investment.spy.yaml
class: Investment
table: investment
fields:
  user: module:serverpod_auth_core:AuthUser?, relation(onDelete=Cascade)
  name: String
  stockId: UuidValue
  stock: Stock?, relation
  withdrawalRuleId: int
  withdrawalRule: WithdrawalRule?, relation
  transfers: List<Transfer>?, relation(name=investment_transfer)
  investAmount: double?, !persist
  quantity: double?, !persist
  withdrawAmount: double?, !persist
  updatedAt: DateTime?
indexes:
  investment_user_idx:
    fields: userId
```

### Model Field Types

```yaml
# Basic types
name: String
count: int
amount: double
active: bool
createdAt: DateTime

# Optional fields
description: String?
updatedAt: DateTime?

# UUIDs
userId: UuidValue

# Enums
type: StockType

# Default values
amount: double, default=0.0
createdAt: DateTime, default=now

# Non-persisted (computed) fields
totalAmount: double?, !persist

# Relations
user: module:serverpod_auth_core:AuthUser?, relation(onDelete=Cascade)
stock: Stock?, relation
fees: List<WithdrawalFee>?, relation(name=withdrawal_fee)
```

### Relations

```yaml
# One-to-one / Many-to-one (foreign key)
stock: Stock?, relation(optional)                          # Nullable relation
user: AuthUser?, relation(onDelete=Cascade)      # Cascade delete

# One-to-many (list relation)
transfers: List<Transfer>?, relation(name=investment_transfer)
fees: List<WithdrawalFee>?, relation(name=withdrawal_fee)
prices: List<StockPrice>?, relation(name=stock_price)
```

### Enum Definition

```yaml
# lib/src/stock/models/stock_type.spy.yaml
enum: StockType
serialized: byName
values:
  - stock
  - etf
  - crypto
```

### Exception Definition

```yaml
# lib/src/core/exceptions/server_exception.spy.yaml
exception: ServerException
fields:
  errorCode: ErrorCode
  message: String?
```

**Conventions:**
- Models in `{feature}/models/` directory
- One model per `.spy.yaml` file
- Use `!persist` for computed/transient fields
- Always define indexes for foreign keys
- Use `relation(name=...)` for list relations to name the FK constraint
- Use `relation(onDelete=Cascade)` for cascading deletes
- Import auth module types with `module:serverpod_auth_core:`

### Code Generation

After modifying `.spy.yaml` files:

```bash
# From project root
make generate

# Or directly
cd invman_server && serverpod generate
```

## Endpoints

Endpoints are thin HTTP handlers that delegate to services. All endpoints mix in `EndpointMiddleware`.

### Basic Endpoint

```dart
// lib/src/investment/endpoints/investment_endpoint.dart
class InvestmentEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  Future<List<Investment>> list(Session session) async {
    return withMiddleware(
      session,
      () => getIt<InvestmentService>().list(session),
    );
  }

  Future<Investment> retrieve(Session session, int id) async {
    return withMiddleware(
      session,
      () => getIt<InvestmentService>().retrieve(session, id),
    );
  }

  Future<Investment> save(Session session, Investment investment) async {
    return withMiddleware(
      session,
      () => getIt<InvestmentService>().save(session, investment),
    );
  }

  Future<Investment> delete(Session session, int id) async {
    return withMiddleware(
      session,
      () => getIt<InvestmentService>().delete(session, id),
    );
  }
}
```

### Endpoint with Pagination

```dart
class TransferEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  Future<List<Transfer>> list(
    Session session,
    int investmentId, {
    int limit = 10,
    int page = 1,
  }) async {
    return withMiddleware(
      session,
      () => getIt<TransferService>().list(
        session,
        investmentId,
        limit: limit,
        page: page,
      ),
    );
  }
}
```

### Endpoint with Search

```dart
class StockEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => true;

  Future<List<Stock>> search(
    Session session, {
    required String query,
    int limit = 10,
    int page = 1,
  }) async {
    return withMiddleware(
      session,
      () => getIt<StockService>().search(
        session,
        query: query,
        limit: limit,
        page: page,
      ),
    );
  }
}
```

### Public Endpoint (No Auth)

```dart
class CurrencyEndpoint extends Endpoint with EndpointMiddleware {
  @override
  bool get requireLogin => false;  // Public endpoint

  Future<List<Currency>> list(Session session) async {
    return withMiddleware(
      session,
      () => getIt<CurrencyService>().list(session),
    );
  }
}
```

**Conventions:**
- All endpoints extend `Endpoint` and mix in `EndpointMiddleware`
- Set `requireLogin => true` for authenticated endpoints
- Wrap all method bodies in `withMiddleware(session, () => ...)`
- Inject services via `getIt<ServiceType>()`
- Pass `Session` to all service methods
- Use default parameter values for pagination (`limit = 10, page = 1`)
- Keep endpoints thin — no business logic

## Service Layer

Services contain all business logic, database access, validation, and authorization.

### Basic Service

```dart
// lib/src/investment/business/investment_service.dart
@injectable
class InvestmentService {
  final AccountService accountService;
  final CurrencyService currencyService;
  final StockService stockService;
  final WithdrawalRuleService withdrawalRuleService;

  InvestmentService({
    required this.accountService,
    required this.currencyService,
    required this.stockService,
    required this.withdrawalRuleService,
  });

  Future<List<Investment>> list(Session session) async {
    final sessionUserId = session.authenticated!.authUserId;

    final investments = await Investment.db.find(
      session,
      where: (e) => e.userId.equals(sessionUserId),
      include: IncludeHelpers.investmentInclude(),
    );

    // Post-processing with computed fields
    final result = <Investment>[];
    for (final investment in investments) {
      result.add(await _addComputedFields(session, investment));
    }

    result.sort((a, b) => a.withdrawAmount!.compareTo(b.withdrawAmount!));
    return result;
  }

  Future<Investment> retrieve(
    Session session,
    int id, {
    Transaction? transaction,
  }) async {
    final investment = await Investment.db.findById(
      session,
      id,
      include: IncludeHelpers.investmentInclude(),
      transaction: transaction,
    );

    if (investment == null) {
      throw ServerException(errorCode: ErrorCode.notFound);
    }

    // Authorization check
    if (investment.userId != session.authenticated!.authUserId) {
      throw ServerException(errorCode: ErrorCode.forbidden);
    }

    return _addComputedFields(session, investment, transaction: transaction);
  }

  Future<Investment> save(Session session, Investment investment) async {
    // Validation
    if (investment.name.isEmpty || investment.stock == null) {
      throw ServerException(errorCode: ErrorCode.badRequest);
    }

    return session.db.transaction(
      (transaction) async {
        // Verify related entities exist
        await withdrawalRuleService.retrieve(
          session,
          investment.withdrawalRuleId,
          transaction: transaction,
        );
        final stock = await stockService.retrieve(
          session,
          investment.stockId,
          transaction: transaction,
        );

        // Set ownership
        investment = investment.copyWith(
          userId: session.authenticated!.authUserId,
          stockId: stock.id,
        );

        // Create or update
        if (investment.id == 0 || investment.id == null) {
          return Investment.db.insertRow(
            session,
            investment.copyWith(id: null),
            transaction: transaction,
          );
        } else {
          // Verify ownership before update
          await retrieve(session, investment.id!, transaction: transaction);
          return Investment.db.updateRow(
            session,
            investment,
            transaction: transaction,
          );
        }
      },
      settings: TransactionSettings(
        isolationLevel: IsolationLevel.serializable,
      ),
    );
  }

  Future<Investment> delete(Session session, int id) async {
    final investment = await retrieve(session, id);
    await Investment.db.deleteRow(session, investment);
    return investment;
  }
}
```

### Service with Pagination

```dart
@injectable
class TransferService {
  Future<List<Transfer>> list(
    Session session,
    int investmentId, {
    required int limit,
    required int page,
  }) async {
    // Verify access to parent resource
    await getIt<InvestmentService>().retrieve(session, investmentId);

    return Transfer.db.find(
      session,
      where: (e) => e.investmentId.equals(investmentId),
      include: IncludeHelpers.transferInclude(),
      limit: limit,
      offset: (page * limit) - limit,
      orderBy: (e) => e.date,
      orderDescending: true,
    );
  }
}
```

### Service with Search

```dart
@injectable
class StockService {
  Future<List<Stock>> search(
    Session session, {
    required String query,
    required int limit,
    required int page,
  }) async {
    return Stock.db.find(
      session,
      where: (e) =>
          e.shortName.ilike("%${query.trim()}%") |
          e.longName.ilike("%${query.trim()}%"),
      include: IncludeHelpers.stockInclude(),
      limit: limit,
      offset: (page * limit) - limit,
    );
  }
}
```

**Conventions:**
- Mark services with `@injectable` for DI registration
- Inject dependencies via constructor
- Accept `Session` as first parameter in all methods
- Accept optional `Transaction? transaction` for transactional operations
- Always check authorization: `session.authenticated!.authUserId`
- Use `session.db.transaction()` for multi-step operations
- Throw `ServerException` with appropriate `ErrorCode`
- Verify ownership before update/delete operations

## Database Access Patterns

### Find Operations

```dart
// Find all matching
final items = await Model.db.find(
  session,
  where: (e) => e.userId.equals(userId),
  include: Model.include(...),
  limit: 10,
  offset: 0,
  orderBy: (e) => e.createdAt,
  orderDescending: true,
  transaction: transaction,
);

// Find by ID
final item = await Model.db.findById(
  session,
  id,
  include: Model.include(...),
  transaction: transaction,
);

// Find first matching
final item = await Model.db.findFirstRow(
  session,
  where: (e) => e.userId.equals(userId),
  include: Model.include(...),
);
```

### Query Conditions

```dart
// Equality
where: (e) => e.userId.equals(userId)

// Comparison
where: (e) => e.amount.greaterThan(100.0)
where: (e) => e.createdAt.lessThan(DateTime.now())

// Like (case-sensitive)
where: (e) => e.name.like("%query%")

// ILike (case-insensitive)
where: (e) => e.name.ilike("%query%")

// OR condition
where: (e) => e.shortName.ilike("%$query%") | e.longName.ilike("%$query%")

// AND condition
where: (e) => e.userId.equals(userId) & e.active.equals(true)

// NULL check
where: (e) => e.deletedAt.equals(null)
```

### Insert / Update / Delete

```dart
// Insert
final created = await Model.db.insertRow(
  session,
  model.copyWith(id: null),  // Ensure id is null for insert
  transaction: transaction,
);

// Update
final updated = await Model.db.updateRow(
  session,
  model,
  transaction: transaction,
);

// Delete
await Model.db.deleteRow(session, model);
```

### Transactions

```dart
return session.db.transaction(
  (transaction) async {
    // All operations use the same transaction
    final item1 = await Model1.db.insertRow(session, m1, transaction: transaction);
    final item2 = await Model2.db.updateRow(session, m2, transaction: transaction);
    await Model3.db.deleteRow(session, m3);
    return item1;
  },
  settings: TransactionSettings(
    isolationLevel: IsolationLevel.serializable,  // Strictest isolation
  ),
);
```

### Pagination

```dart
Future<List<T>> list({required int limit, required int page}) async {
  return Model.db.find(
    session,
    limit: limit,
    offset: (page * limit) - limit,  // page starts at 1
  );
}
```

## Include Helpers (Eager Loading)

Centralize include configurations to prevent N+1 queries.

```dart
// lib/src/core/helpers/include_helpers.dart
class IncludeHelpers {
  static InvestmentInclude investmentInclude() {
    return Investment.include(
      stock: stockInclude(),
      withdrawalRule: withdrawalInclude(),
    );
  }

  static StockInclude stockInclude() {
    return Stock.include(
      currency: currencyInclude(),
      prices: StockPrice.includeList(
        orderBy: (e) => e.timestamp,
        orderDescending: true,
        limit: 1,  // Only latest price
      ),
    );
  }

  static WithdrawalRuleInclude withdrawalInclude() {
    return WithdrawalRule.include(
      fees: WithdrawalFee.includeList(),
    );
  }

  static CurrencyInclude currencyInclude() {
    return Currency.include(
      rates: CurrencyRate.includeList(
        orderBy: (e) => e.date,
        orderDescending: true,
        limit: 1,
      ),
    );
  }

  static TransferInclude transferInclude() {
    return Transfer.include();
  }

  static AccountInclude accountInclude() {
    return Account.include(
      currency: currencyInclude(),
    );
  }
}
```

**Usage:**

```dart
final investments = await Investment.db.find(
  session,
  where: (e) => e.userId.equals(userId),
  include: IncludeHelpers.investmentInclude(),
);
```

**Conventions:**
- Define include helpers in `core/helpers/include_helpers.dart`
- Use `includeList()` for one-to-many relations
- Limit list includes when only latest is needed (e.g., latest price)
- Compose includes hierarchically

## Model Extensions

Add computed properties and helper methods via extensions.

```dart
// lib/src/stock/utils/extensions.dart
extension StockExtension on Stock {
  double get currentPrice => prices?.firstOrNull?.value ?? 0.0;
}

extension CurrencyExtension on Currency {
  double get currentRate => rates?.firstOrNull?.value ?? 1.0;
}
```

**Usage:**

```dart
final price = stock.currentPrice;  // From extension
```

## Error Handling

### Error Code Enum

```yaml
# lib/src/core/exceptions/error_code.spy.yaml
enum: ErrorCode
serialized: byName
values:
  - unknown
  - notFound
  - conflict
  - unauthorized
  - forbidden
  - badRequest
```

### Server Exception

```yaml
# lib/src/core/exceptions/server_exception.spy.yaml
exception: ServerException
fields:
  errorCode: ErrorCode
  message: String?
```

### Throwing Exceptions

```dart
// Not found
if (item == null) {
  throw ServerException(errorCode: ErrorCode.notFound);
}

// Forbidden (authorization failure)
if (item.userId != session.authenticated!.authUserId) {
  throw ServerException(errorCode: ErrorCode.forbidden);
}

// Bad request (validation failure)
if (input.name.isEmpty) {
  throw ServerException(errorCode: ErrorCode.badRequest);
}

// Conflict (duplicate, etc.)
if (existingItem != null) {
  throw ServerException(errorCode: ErrorCode.conflict);
}

// Unknown with message
throw ServerException(
  errorCode: ErrorCode.unknown,
  message: "Unexpected error: $details",
);
```

### Endpoint Middleware

```dart
// lib/src/core/helpers/middleware.dart
mixin EndpointMiddleware {
  Future<T> withMiddleware<T>(
    Session session,
    Future<T> Function() callback,
  ) async {
    try {
      return await callback();
    } on ServerException catch (e, st) {
      if (e.errorCode == ErrorCode.unknown) {
        session.log(
          e.message ?? 'Server error',
          level: LogLevel.error,
          exception: e,
          stackTrace: st,
        );
      }
      rethrow;
    } catch (e, st) {
      session.log(
        'Unknown error',
        level: LogLevel.fatal,
        exception: e,
        stackTrace: st,
      );
      throw ServerException(errorCode: ErrorCode.unknown);
    }
  }
}
```

**Conventions:**
- Use typed `ErrorCode` enum for all errors
- Log `unknown` errors with full stack trace
- Catch unexpected exceptions and wrap in `ServerException`
- Let expected exceptions (`ServerException`) propagate

## Authentication

### Server Setup

```dart
// lib/server.dart
void run(List<String> args) async {
  final pod = Serverpod(args, Protocol(), Endpoints());
  configureDependencies();

  pod.initializeAuthServices(
    tokenManagerBuilders: [
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      EmailIdpConfigFromPasswords(
        sendRegistrationVerificationCode: _sendRegistrationCode,
        sendPasswordResetVerificationCode: _sendPasswordResetCode,
      ),
    ],
    authUsersConfig: AuthUsersConfig(
      onAfterAuthUserCreated: (session, authUser, {required transaction}) async {
        // Create related account on user creation
        final account = Account(userId: authUser.id);
        await Account.db.insertRow(session, account, transaction: transaction);
      },
    ),
  );

  await pod.start();
}
```

### Email Verification Callbacks

```dart
void _sendRegistrationCode(
  Session session, {
  required String email,
  required UuidValue accountRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  session.log('[EmailIdp] Registration code ($email): $verificationCode');

  if (getIt<Env>().flavor != Flavor.develop) {
    getIt<MailServiceInterface>().sendEmail(
      to: email,
      subject: 'Your registration verification code',
      body: 'Your verification code is: <b>$verificationCode</b>',
    );
  }
}

void _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue accountId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  session.log('[EmailIdp] Password reset code ($email): $verificationCode');

  if (getIt<Env>().flavor != Flavor.develop) {
    getIt<MailServiceInterface>().sendEmail(
      to: email,
      subject: 'Your password reset code',
      body: 'Your password reset code is: <b>$verificationCode</b>',
    );
  }
}
```

### Auth Endpoints

```dart
// lib/src/auth/endpoints/email_idp_endpoint.dart
class EmailIdpEndpoint extends EmailIdpBaseEndpoint {}

// lib/src/auth/endpoints/jwt_refresh_endpoint.dart
class JwtRefreshEndpoint extends RefreshJwtTokensEndpoint {}
```

### Using Authentication in Services

```dart
// Get current user ID
final userId = session.authenticated!.authUserId;

// Check if user owns resource
if (item.userId != session.authenticated!.authUserId) {
  throw ServerException(errorCode: ErrorCode.forbidden);
}

// Require authentication on endpoint
@override
bool get requireLogin => true;
```

## Dependency Injection

### DI Setup

```dart
// lib/src/di.dart
final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => getIt.init();
```

### Service Registration

```dart
// Factory (new instance each time)
@injectable
class InvestmentService {
  final StockService stockService;

  InvestmentService({required this.stockService});
}

// Singleton (one instance)
@singleton
class Env {
  late final Flavor flavor;
  // ...
}

// Interface implementation
@Injectable(as: MailServiceInterface)
class MailjetMailService implements MailServiceInterface {
  // ...
}
```

### Usage in Endpoints

```dart
Future<List<Investment>> list(Session session) async {
  return withMiddleware(
    session,
    () => getIt<InvestmentService>().list(session),
  );
}
```

### Initialization

```dart
// In server.dart, before pod.start()
configureDependencies();
```

### Code Generation

After adding/modifying injectable services:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Environment Configuration

### Env Class

```dart
// lib/src/env.dart
enum Flavor { develop, staging, production }

@singleton
class Env {
  late final Flavor flavor;
  late final DotEnv env;
  late final String yfinBaseUrl;
  late final String mailjetApiKeyPrivate;
  late final String mailjetApiKeyPublic;
  late final String mailjetEmailSender;

  Env() {
    env = DotEnv(includePlatformEnvironment: true)..load();

    switch (const String.fromEnvironment("APP_FLAVOR")) {
      case 'develop':
        flavor = Flavor.develop;
        yfinBaseUrl = "localhost";
        break;
      case 'staging':
        flavor = Flavor.staging;
        _loadProductionVars();
        break;
      case 'production':
        flavor = Flavor.production;
        _loadProductionVars();
        break;
      default:
        flavor = Flavor.develop;
        yfinBaseUrl = "localhost";
    }
  }

  void _loadProductionVars() {
    yfinBaseUrl = getVarFromKey("YFIN_BASE_URL");
    mailjetApiKeyPublic = getVarFromKey("MAILJET_API_KEY_PUBLIC");
    mailjetApiKeyPrivate = getVarFromKey("MAILJET_API_KEY_PRIVATE");
    mailjetEmailSender = getVarFromKey("MAILJET_EMAIL_SENDER");
  }

  String getVarFromKey(String key) {
    if (env[key] == null) {
      throw Exception("$key not set in environment.");
    }
    return env[key]!;
  }
}
```

### Config Files

```yaml
# config/development.yaml
apiServer:
  port: 8080
  publicHost: localhost
  publicPort: 8080
  publicScheme: http

database:
  host: localhost
  port: 8090
  name: invman
  user: postgres

redis:
  enabled: true
  host: localhost
  port: 8091

sessionLogs:
  persistentEnabled: true
  consoleEnabled: true
  consoleLogFormat: text
```

```yaml
# config/production.yaml
apiServer:
  port: 8080
  publicHost: api.example.com
  publicPort: 443
  publicScheme: https

database:
  host: postgresql-server
  port: 5432
  name: serverpod
  user: postgres
  requireSsl: true

redis:
  enabled: true
  host: redis-server
  port: 6379

sessionLogs:
  consoleEnabled: false
```

## External API Client

```dart
// lib/src/core/services/api_client_service.dart
class ApiClientService {
  static Future<dynamic> get({
    required String url,
    required String path,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    bool useHttps = true,
  }) async {
    final uri = useHttps
        ? Uri.https(url, path, queryParameters)
        : Uri.http(url, path, queryParameters);

    final response = await http.get(uri, headers: headers);

    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 404:
        throw ServerException(errorCode: ErrorCode.notFound);
      case 401:
        throw ServerException(errorCode: ErrorCode.unauthorized);
      default:
        throw ServerException(
          errorCode: ErrorCode.unknown,
          message: "HTTP ${response.statusCode}",
        );
    }
  }

  static Future<dynamic> post({
    required String url,
    required String path,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    Object? body,
    bool useHttps = true,
  }) async {
    final uri = useHttps
        ? Uri.https(url, path, queryParameters)
        : Uri.http(url, path, queryParameters);

    final response = await http.post(
      uri,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );

    // Similar error handling...
  }
}
```

## Mail Service

### Interface

```dart
// lib/src/core/services/mail_service_interface.dart
abstract interface class MailServiceInterface {
  Future<void> sendEmail({
    required String to,
    required String subject,
    required String body,
  });
}
```

### Implementation

```dart
// lib/src/core/services/mailjet_mail_service.dart
@Injectable(as: MailServiceInterface)
class MailjetMailService implements MailServiceInterface {
  final String _apiKeyPublic;
  final String _apiKeyPrivate;
  final String _senderEmail;

  MailjetMailService(Env env)
      : _apiKeyPublic = env.mailjetApiKeyPublic,
        _apiKeyPrivate = env.mailjetApiKeyPrivate,
        _senderEmail = env.mailjetEmailSender;

  @override
  Future<void> sendEmail({
    required String to,
    required String subject,
    required String body,
  }) async {
    final authHeader = 'Basic ${base64Encode(
      utf8.encode('$_apiKeyPublic:$_apiKeyPrivate'),
    )}';

    await ApiClientService.post(
      url: 'api.mailjet.com',
      path: '/v3.1/send',
      headers: {
        'Authorization': authHeader,
        'Content-Type': 'application/json',
      },
      body: {
        'Messages': [
          {
            'From': {'Email': _senderEmail, 'Name': 'InvMan'},
            'To': [{'Email': to}],
            'Subject': subject,
            'HTMLPart': body,
          }
        ]
      },
    );
  }
}
```

## Migrations

### Migration Structure

```
migrations/
└── 20260209175855549/
    ├── migration.json
    ├── migration.sql
    ├── definition.sql
    ├── definition.json
    └── definition_project.json
```

### Creating Migrations

```bash
# Generate migration from model changes
serverpod generate

# Create repair migration (if needed)
serverpod create-repair-migration
```

### Applying Migrations

```bash
# Development (auto-apply)
dart run bin/main.dart --apply-migrations

# Production (manual review first)
# Review migration.sql before applying
```

**Conventions:**
- Review auto-generated migrations before committing
- Never edit migrations that have been applied to production
- Test migrations in staging before production
- Timestamp-based naming (auto-generated)

## Testing

### Test Configuration

```yaml
# config/test.yaml
apiServer:
  port: 8080
  publicHost: localhost
  publicPort: 8080
  publicScheme: http

database:
  host: localhost
  port: 8090
  name: invman_test
  user: postgres
```

### Integration Test Setup

```dart
// test/integration/test_tools/serverpod_test_tools.dart
// Auto-generated — provides withServerpod helper

void withServerpod(
  String testGroupName,
  TestClosure<TestEndpoints> testClosure, {
  bool? applyMigrations,
  bool? enableSessionLogging,
  RollbackDatabase? rollbackDatabase,
});
```

### Service Unit Tests

```dart
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class MockSession extends Mock implements Session {}
class MockStockService extends Mock implements StockService {}

void main() {
  late MockSession session;
  late MockStockService mockStockService;
  late InvestmentService service;

  setUp(() {
    session = MockSession();
    mockStockService = MockStockService();
    service = InvestmentService(stockService: mockStockService);
  });

  group('InvestmentService', () {
    test('retrieve throws notFound when investment does not exist', () async {
      when(() => Investment.db.findById(session, 1, include: any(named: 'include')))
          .thenAnswer((_) async => null);

      expect(
        () => service.retrieve(session, 1),
        throwsA(isA<ServerException>()
            .having((e) => e.errorCode, 'errorCode', ErrorCode.notFound)),
      );
    });

    test('retrieve throws forbidden when user does not own investment', () async {
      final investment = Investment(id: 1, userId: UuidValue.nil, name: 'Test', ...);
      final authInfo = AuthenticationInfo(UuidValue.fromString('different-user'), ...);

      when(() => Investment.db.findById(session, 1, include: any(named: 'include')))
          .thenAnswer((_) async => investment);
      when(() => session.authenticated).thenReturn(authInfo);

      expect(
        () => service.retrieve(session, 1),
        throwsA(isA<ServerException>()
            .having((e) => e.errorCode, 'errorCode', ErrorCode.forbidden)),
      );
    });
  });
}
```

### Endpoint Integration Tests

```dart
import 'package:serverpod_test/serverpod_test.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Investment endpoint tests', (endpoints) {
    test('list returns empty list for new user', () async {
      final session = await endpoints.session;
      final result = await endpoints.investment.list(session);
      expect(result, isEmpty);
    });

    test('save creates new investment', () async {
      final session = await endpoints.session;
      final investment = Investment(name: 'Test', ...);

      final saved = await endpoints.investment.save(session, investment);

      expect(saved.id, isNotNull);
      expect(saved.name, 'Test');
    });

    test('retrieve returns saved investment', () async {
      final session = await endpoints.session;
      final investment = Investment(name: 'Test', ...);
      final saved = await endpoints.investment.save(session, investment);

      final retrieved = await endpoints.investment.retrieve(session, saved.id!);

      expect(retrieved.name, 'Test');
    });

    test('delete removes investment', () async {
      final session = await endpoints.session;
      final investment = Investment(name: 'Test', ...);
      final saved = await endpoints.investment.save(session, investment);

      await endpoints.investment.delete(session, saved.id!);

      expect(
        () => endpoints.investment.retrieve(session, saved.id!),
        throwsA(isA<ServerException>()
            .having((e) => e.errorCode, 'errorCode', ErrorCode.notFound)),
      );
    });
  });
}
```

**Conventions:**
- Use `mocktail` for mocking
- Test services independently (unit tests)
- Test endpoints with `withServerpod` (integration tests)
- Test error cases explicitly
- Use `rollbackDatabase: RollbackDatabase.afterEach` for isolation

## Development Commands

```bash
# Start server (development)
make dev
# or
dart run bin/main.dart --apply-migrations

# Generate code (models, DI)
make generate
# or
serverpod generate && dart run build_runner build --delete-conflicting-outputs

# Run tests
make test
# or
dart test

# Create migration
serverpod generate

# Apply migrations only
dart run bin/main.dart --apply-migrations --role=maintenance
```

## Integration Summaries

After completing a backend feature, generate an integration summary for Flutter developers.

### Template

````markdown
# Feature: {Feature Name}

## Endpoints

### List {Feature}
- **Method:** `{feature}.list()`
- **Auth:** Required
- **Parameters:**
  - `limit` (int, default: 10) — Items per page
  - `page` (int, default: 1) — Page number
- **Returns:** `List<{Model}>`

### Retrieve {Feature}
- **Method:** `{feature}.retrieve(id)`
- **Auth:** Required
- **Parameters:**
  - `id` (int) — Resource ID
- **Returns:** `{Model}`
- **Errors:**
  - `notFound` — Resource doesn't exist
  - `forbidden` — User doesn't own resource

### Save {Feature}
- **Method:** `{feature}.save({model})`
- **Auth:** Required
- **Parameters:**
  - `{model}` ({Model}) — Resource to create/update
- **Returns:** `{Model}` — Saved resource with ID
- **Errors:**
  - `badRequest` — Invalid input
  - `notFound` — Referenced resource doesn't exist

### Delete {Feature}
- **Method:** `{feature}.delete(id)`
- **Auth:** Required
- **Parameters:**
  - `id` (int) — Resource ID
- **Returns:** `{Model}` — Deleted resource
- **Errors:**
  - `notFound` — Resource doesn't exist
  - `forbidden` — User doesn't own resource

## Model

```dart
class {Model} {
  int? id;
  String name;
  // ... fields
}
```

## Error Codes

| Code | Description |
|------|-------------|
| `notFound` | Resource doesn't exist |
| `forbidden` | User doesn't own resource |
| `badRequest` | Invalid input data |
| `unauthorized` | Not authenticated |

## Notes

- {Any special behavior}
- {Computed fields explanation}
- {Related endpoints to call}
````

### Save Location

Save integration summaries to:
```
docs/integration/{feature-name}.md
```

## Quick Reference

### Feature Checklist

When implementing a new feature:

1. **Models** — Create `.spy.yaml` files in `{feature}/models/`
2. **Generate** — Run `serverpod generate`
3. **Include Helper** — Add to `IncludeHelpers` if relations exist
4. **Service** — Create `{feature}_service.dart` with `@injectable`
5. **Endpoint** — Create `{feature}_endpoint.dart` with middleware
6. **DI** — Run `dart run build_runner build`
7. **Tests** — Add unit and integration tests
8. **Migration** — Review and commit generated migration
9. **Integration Summary** — Document for Flutter developers

### Common Patterns

```dart
// Get current user ID
final userId = session.authenticated!.authUserId;

// Check ownership
if (item.userId != userId) {
  throw ServerException(errorCode: ErrorCode.forbidden);
}

// Validate required fields
if (input.name.isEmpty) {
  throw ServerException(errorCode: ErrorCode.badRequest);
}

// Not found check
if (item == null) {
  throw ServerException(errorCode: ErrorCode.notFound);
}

// Transaction
return session.db.transaction((tx) async {
  // ... operations with transaction: tx
}, settings: TransactionSettings(isolationLevel: IsolationLevel.serializable));

// Pagination offset
offset: (page * limit) - limit
```

### File Structure for New Feature

```
lib/src/{feature}/
├── models/
│   └── {feature}.spy.yaml
├── endpoints/
│   ├── endpoints.dart              # export '{feature}_endpoint.dart';
│   └── {feature}_endpoint.dart
├── business/
│   ├── business.dart               # export '{feature}_service.dart';
│   └── {feature}_service.dart
└── utils/
    └── extensions.dart             # Optional
```
