import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_provider.g.dart';

@riverpod
class InvestmentDetail extends _$InvestmentDetail {
  @override
  ModelState<Investment> build(int id) {
    load();
    return Initial();
  }

  Future<void> load() async {
    state = Loading();

    final currency = ref.read(userPreferencesProvider).currency;
    final result = await ref.read(investmentServiceProvider).retrieve(id, currency: currency);

    result.fold((error) {
      state = Failure(error);
    }, (investment) {
      state = Success(investment);
    });
  }
}
