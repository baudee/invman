import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/models/models.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_provider.g.dart';

@riverpod
class WithdrawalRuleDetail extends _$WithdrawalRuleDetail {
  @override
  ModelState<WithdrawalRule> build(int id) {
    load();
    return Initial();
  }

  Future<void> load() async {
    state = Loading();

    final result = await ref.read(withdrawalRuleServiceProvider).retrieve(id);

    result.fold((error) {
      state = Failure(error);
    }, (rule) {
      state = Success(rule);
    });
  }
}
