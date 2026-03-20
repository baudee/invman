import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:signals_flutter/signals_flutter.dart';

@lazySingleton
class InvestmentRepository {
  final Client client;

  InvestmentRepository(this.client);

  final _invalidation = signal(false);
  ReadonlySignal<bool> get invalidation => _invalidation;

  void invalidate() => _invalidation.value = !_invalidation.value;

  Future<Either<String, List<Investment>>> list({required int page, required int limit}) async {
    return safeCall(() async {
      return right(await client.investment.list(limit: limit, page: page));
    });
  }

  Future<Either<String, Investment>> save(Investment investment) async {
    final result = await safeCall(() async {
      return right(await client.investment.save(investment));
    });
    if (result.isRight()) invalidate();
    return result;
  }

  Future<Either<String, Investment>> delete(int id) async {
    final result = await safeCall(() async {
      return right(await client.investment.delete(id));
    });
    if (result.isRight()) invalidate();
    return result;
  }

  Future<Either<String, Investment>> retrieve(int id) async {
    return safeCall(() async {
      return right(await client.investment.retrieve(id));
    });
  }

  Future<Either<String, Investment>> total() async {
    return safeCall(() async {
      return right(await client.investment.total());
    });
  }
}
