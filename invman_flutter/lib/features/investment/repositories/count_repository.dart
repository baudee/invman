import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:signals_flutter/signals_flutter.dart';

@lazySingleton
class InvestmentCountRepository {
  final Client client;

  InvestmentCountRepository(this.client);

  final Signal<int?> _count = signal(null);
  ReadonlySignal<int?> get count => _count.readonly();

  void setCount(int count) {
    _count.value = count;
  }

  Future<void> refresh() async {
    _count.value = null;
    final result = await safeCall(() async {
      return right(await client.investment.count());
    });
    result.fold((error) => null, (count) => _count.value = count);
  }
}
