import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class InvestmentRoutes {
  static String namespace = "/investments";
  static String namespaceTransfer = "/transfers";
  static final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "Investment Shell");

  static StatefulShellBranch branch = StatefulShellBranch(
    navigatorKey: shellNavigatorKey,
    routes: [
      GoRoute(
        path: InvestmentRootScreen.pathSegment,
        builder: (_, _) => InvestmentRootScreen(),
        routes: [
          GoRoute(
            path: InvestmentDetailScreen.pathSegment,
            builder: (_, state) => InvestmentDetailScreen(id: int.tryParse(state.pathParameters['id'] ?? '') ?? 0),
            routes: [
              GoRoute(
                path: InvestmentEditScreen.pathSegment,
                builder: (_, state) => InvestmentEditScreen(
                  id: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
                  stock: state.extra as Stock?,
                ),
              ),
              GoRoute(
                path: TransferRootScreen.pathSegment,
                builder: (_, state) =>
                    TransferRootScreen(investmentId: int.tryParse(state.pathParameters['id'] ?? '') ?? 0),
                routes: [
                  GoRoute(
                    path: TransferEditScreen.pathSegment,
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
      GoRoute(path: WithdrawalRuleSelectScreen.pathSegment, builder: (_, _) => const WithdrawalRuleSelectScreen()),
      ...WithdrawalRoutes.routes,
    ],
  );
}
