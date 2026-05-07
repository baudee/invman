import 'package:serverpod/serverpod.dart';

class UserScope extends Scope {
  const UserScope(super.name);

  static const premium = UserScope('premium');
}
