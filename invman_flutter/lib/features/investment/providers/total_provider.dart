import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'total_provider.g.dart';

@Riverpod(keepAlive: true)
class InvestmentTotal extends _$InvestmentTotal {
  @override
  ModelState<Investment> build() {
    load();
    return Initial();
  }

  Future<void> load() async {
    state = Loading();

    final currency = ref.read(userPreferencesProvider).currency;
    final result = await ref.read(investmentServiceProvider).total(currency: currency);

    result.fold((error) {
      state = Failure(error);
    }, (investment) {
      state = Success(investment);
    });
  }
}
