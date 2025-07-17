import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';
import 'package:invman_flutter/features/withdrawal/rule/rule.dart';

class InvestmentRoutes {
  static String namespace = "/investment";
  static String namespaceTransfer = "/transfer";
  static final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "Investment Shell");

  static StatefulShellBranch branch = StatefulShellBranch(
    navigatorKey: shellNavigatorKey,
    routes: [
      GoRoute(
        path: InvestmentRootScreen.route(),
        builder: (_, __) => InvestmentRootScreen(),
        routes: [
          GoRoute(
            path: InvestmentDetailScreen.route(),
            builder: (_, state) => InvestmentDetailScreen(id: int.tryParse(state.pathParameters['id'] ?? '') ?? 0),
            routes: [
              GoRoute(
                path: InvestmentEditScreen.route(),
                builder: (_, state) => InvestmentEditScreen(id: int.tryParse(state.pathParameters['id'] ?? '') ?? 0),
              ),
              GoRoute(
                path: TransferDetailScreen.route(),
                builder: (_, state) =>
                    TransferDetailScreen(id: int.tryParse(state.pathParameters['transferId'] ?? '') ?? 0),
                routes: [
                  GoRoute(
                    path: TransferEditScreen.route(),
                    builder: (_, state) => TransferEditScreen(
                      id: int.tryParse(state.pathParameters['transferId'] ?? '') ?? 0,
                      investmentId: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: WithdrawalRuleSelectScreen.route(),
        builder: (_, __) => const WithdrawalRuleSelectScreen(),
      ),
    ],
  );
}
