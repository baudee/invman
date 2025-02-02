import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/features/auth/auth.dart';

final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier(ref);
});

class RouterNotifier extends ChangeNotifier {
  // constructor
  RouterNotifier(this.ref) {
    ref.listen(authProvider, (previous, next) {
      final isPreviousSuccess = previous is AuthStateSuccess;
      final isNextSuccess = next is AuthStateSuccess;
      if (isPreviousSuccess != isNextSuccess) {
        notifyListeners();
      }
    });
  }
  Ref<RouterNotifier> ref;
  bool isLoggedIn = false;
}
