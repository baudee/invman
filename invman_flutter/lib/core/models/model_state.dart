sealed class ModelState<T> {
  const ModelState();
}

class Initial<T> extends ModelState<T> {
  const Initial();
}

class Loading<T> extends ModelState<T> {
  const Loading();
}

class Success<T> extends ModelState<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends ModelState<T> {
  final String error;
  const Failure(this.error);
}
