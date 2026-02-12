import 'package:injectable/injectable.dart';
import 'package:invman_server/src/core/helpers/helpers.dart';
import 'package:invman_server/src/currency/currency.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

@injectable
class AccountService {
  AccountService({required this.currencyService});

  final CurrencyService currencyService;

  Future<Account> retrieve(Session session) async {
    final sessionUserId = (session.authenticated)!.authUserId;

    final account = await Account.db.findFirstRow(
      session,
      where: (a) => a.userId.equals(sessionUserId),
      include: IncludeHelpers.accountInclude(),
    );

    if (account == null) {
      throw ServerException(errorCode: ErrorCode.notFound);
    }

    return account;
  }

  Future<Account> save(Session session, Account account) async {
    Account existingAccount = await retrieve(session);

    if (account.currencyId == null) {
      throw ServerException(errorCode: ErrorCode.badRequest);
    }

    final currency = await currencyService.retrieve(session, account.currencyId!);

    return await Account.db.updateRow(
      session,
      existingAccount.copyWith(
        currencyId: currency.id,
      ),
    );
  }
}
