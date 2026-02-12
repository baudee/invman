import 'package:fpdart/fpdart.dart';
import 'package:signals_flutter/signals_flutter.dart';

abstract class DetailController<K, T> extends AsyncSignal<T> {
  final K id;

  DetailController(this.id) : super(AsyncState.loading()) {
    _fetch();
  }

  Future<void> _fetch() async {
    setLoading(value);

    final result = await retrieve(id);
    result.fold((error) => setError(error), (result) => setValue(result));
  }

  Future<Either<String, T>> retrieve(K id);
}
