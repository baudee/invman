class ModelFormState<T> {
  final T object;
  final bool isLoading;
  final String? error;

  ModelFormState({
    required this.object,
    required this.isLoading,
    this.error,
  });

  factory ModelFormState.initial(T initialObject) {
    return ModelFormState<T>(
      object: initialObject,
      isLoading: false,
    );
  }

  ModelFormState<T> loading() {
    return ModelFormState<T>(
      object: object,
      isLoading: true,
      error: null,
    );
  }

  ModelFormState<T> success(T object) {
    return ModelFormState<T>(
      object: object,
      isLoading: false,
      error: null,
    );
  }

  ModelFormState<T> failure(String error) {
    return ModelFormState<T>(
      object: object,
      isLoading: false,
      error: error,
    );
  }

  ModelFormState<T> update(T object) {
    return ModelFormState<T>(
      object: object,
      isLoading: false,
      error: null,
    );
  }
}
