import 'package:go_router/go_router.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRoutes {
  static String namespace = "/withdrawals";

  static final routes = [
    GoRoute(
      path: WithdrawalRuleRootScreen.pathSegment,
      builder: (_, _) => WithdrawalRuleRootScreen(),
      routes: [
        GoRoute(
          path: WithdrawalRuleDetailScreen.pathSegment,
          builder: (_, state) => WithdrawalRuleDetailScreen(id: int.tryParse(state.pathParameters['id'] ?? '') ?? 0),
          routes: [
            GoRoute(
              path: WithdrawalRuleEditScreen.pathSegment,
              builder: (_, state) => WithdrawalRuleEditScreen(id: int.tryParse(state.pathParameters['id'] ?? '') ?? 0),
            ),
          ],
        ),
      ],
    ),
  ];
}
