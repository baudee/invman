import 'package:go_router/go_router.dart';
import 'package:invman_flutter/features/withdrawal/fee/fee.dart';
import 'package:invman_flutter/features/withdrawal/rule/screens/screens.dart';

class WithdrawalRoutes {
  static String namespace = "/withdrawal";
  static String namespaceFee = "/fee";

  static final routes = [
    GoRoute(
      path: WithdrawalRuleRootScreen.route(),
      builder: (_, __) => WithdrawalRuleRootScreen(),
      routes: [
        GoRoute(
          path: WithdrawalRuleDetailScreen.route(),
          builder: (_, state) => WithdrawalRuleDetailScreen(id: int.tryParse(state.pathParameters['id'] ?? '') ?? 0),
          routes: [
            GoRoute(
              path: WithdrawalRuleEditScreen.route(),
              builder: (_, state) => WithdrawalRuleEditScreen(id: int.tryParse(state.pathParameters['id'] ?? '') ?? 0),
            ),
            GoRoute(
              path: WithdrawalFeeDetailScreen.route(),
              builder: (_, state) =>
                  WithdrawalFeeDetailScreen(id: int.tryParse(state.pathParameters['idFee'] ?? '') ?? 0),
              routes: [
                GoRoute(
                  path: WithdrawalFeeEditScreen.route(),
                  builder: (_, state) {
                    return WithdrawalFeeEditScreen(
                      ruleId: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
                      id: int.tryParse(state.pathParameters['idFee'] ?? '') ?? 0,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ];
}
