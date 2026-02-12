import 'package:fpdart/fpdart.dart';
import 'package:invman_flutter/config/generated/l10n.dart';

class DeleteCommand<T> {
  final Future<Either<String, T>> Function() onExecute;

  DeleteCommand({required this.onExecute});

  Future<(bool, String?)> execute() async {
    final result = await onExecute();

    return result.fold(
      (error) {
        return (false, error);
      },
      (deletedRule) {
        return (true, S.current.core_itemDeleted);
      },
    );
  }
}
