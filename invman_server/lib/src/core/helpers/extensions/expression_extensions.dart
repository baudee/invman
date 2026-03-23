import 'package:serverpod/serverpod.dart';

extension ExpressionsExtension on List<Expression> {
  Expression? get and {
    if (isEmpty) {
      return null;
    } else {
      return _recursiveAnd(this);
    }
  }

  Expression _recursiveAnd(List<Expression> expressions) {
    if (expressions.length == 1) {
      return expressions.last;
    } else {
      final lastElement = expressions.removeLast();
      return lastElement & _recursiveAnd(expressions);
    }
  }
}
