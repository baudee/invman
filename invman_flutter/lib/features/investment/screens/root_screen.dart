import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentRootScreen extends HookWidget {
  const InvestmentRootScreen({super.key});

  static const pathSegment = '/investments';
  static String route() => pathSegment;

  static const _idleDuration = Duration(seconds: 3);

  @override
  Widget build(BuildContext context) {
    final controller = useController(() => getIt<InvestmentListController>());
    final authManager = getIt<AuthManager>();
    final preferencesManager = getIt<UserPreferencesManager>();

    final fabVisible = useState(true);
    final idleTimer = useRef<Timer?>(null);

    void scheduleHide() {
      idleTimer.value?.cancel();
      idleTimer.value = Timer(_idleDuration, () {
        fabVisible.value = false;
      });
    }

    useEffect(() {
      scheduleHide();
      return () => idleTimer.value?.cancel();
    }, const []);

    void onActivity() {
      if (!fabVisible.value) fabVisible.value = true;
      scheduleHide();
    }

    return BaseScreen(
      usePadding: false,
      useTopSafeArea: false,
      floatingActionButton: AnimatedScale(
        scale: fabVisible.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: FloatingActionButton(
          onPressed: () => router.push(InvestmentEditScreen.route(0)),
          child: const Icon(Icons.add),
        ),
      ),
      body: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (_) => onActivity(),
        onPointerMove: (_) => onActivity(),
        child: InvestmentRootComponent(
          controller: controller,
          currencyCode: authManager.currencyCode,
          preferencesManager: preferencesManager,
        ),
      ),
    );
  }
}
