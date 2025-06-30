import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/models/models.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_provider.g.dart';

@Riverpod(keepAlive: true)
class WithdrawalFeeDetail extends _$WithdrawalFeeDetail {
  @override
  ModelState<WithdrawalFee> build(int id) {
    load();
    return Initial();
  }

  Future<void> load() async {
    state = Loading();

    final result = await ref.read(withdrawalFeeServiceProvider).retrieve(id);

    result.fold((error) {
      state = Failure(error);
    }, (fee) {
      state = Success(fee);
    });
  }
}
