sealed class ModelDetailState<T> {
  const ModelDetailState();
}

class Initial<T> extends ModelDetailState<T> {
  const Initial();
}

class Loading<T> extends ModelDetailState<T> {
  const Loading();
}

class Success<T> extends ModelDetailState<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends ModelDetailState<T> {
  final String error;
  const Failure(this.error);
}
