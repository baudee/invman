import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_provider.g.dart';

@Riverpod(keepAlive: true)
class InvestmentList extends _$InvestmentList {
  @override
  ModelState<List<Investment>> build() {
    load();
    return Initial();
  }

  Future<void> load() async {
    state = Loading();

    final result = await ref.read(investmentServiceProvider).list();

    result.fold(
      (error) {
        state = Failure(error);
      },
      (investments) {
        state = Success(investments);
      },
    );
  }
}
