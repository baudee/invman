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
- Use `relation(name=...)` for list relations to name the FK constraint
- Use `relation(onDelete=Cascade)` for cascading deletes
- Import auth module types with `module:serverpod_auth_core:`

### Code Generation

After modifying `.spy.yaml` files:

```bash
# From project root
make server/build
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
    return Investment.db.deleteRow(session, investment);
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


## Testing

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
