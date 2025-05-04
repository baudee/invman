import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/models/models.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_provider.g.dart';

@Riverpod(keepAlive: true)
class WithdrawalDetail extends _$WithdrawalDetail {
  @override
  ModelState<Withdrawal> build(int id) {
    load();
    return Initial();
  }

  Future<void> load() async {
    state = Loading();

    final result = await ref.read(withdrawalServiceProvider).retrieve(id);

    result.fold((error) {
      state = Failure(error);
    }, (withdrawal) {
      state = Success(withdrawal);
    });
  }

  Future<(bool, String?)> delete() async {
    if (state is! Success) {
      return (false, S.current.error_invalidState);
    }

    final withdrawalToDelete = (state as Success).data;

    state = Loading();

    final result = await ref.read(withdrawalServiceProvider).delete(id);

    return result.fold((error) {
      state = Success(withdrawalToDelete);
      return (false, error);
    }, (deletedWithdrawal) {
      state = Success(deletedWithdrawal);
      ref.read(withdrawalListProvider.notifier).refresh();
      return (true, S.current.core_itemDeleted);
    });
  }
}
