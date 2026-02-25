import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:signals_flutter/signals_flutter.dart';

class InvestmentRootScreen extends HookWidget {
  const InvestmentRootScreen({super.key});

  static String route() => InvestmentRoutes.namespace;

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<InvestmentListController>());
    final authManager = useMemoized(() => getIt<AuthManager>());
    final headerHeight = 260.0;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => router.pushRelative(InvestmentEditScreen.route(0)),
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: controller.refresh,
        edgeOffset: headerHeight,
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: InvestmentHeaderComponent(
                height: headerHeight,
                investment: Investment(
                  userId: UuidValue.raw("jhg"),
                  name: "Investment Name",
                  stockId: UuidValue.raw("jhg"),
                  investAmount: 100,
                  withdrawAmount: 110,
                ),
                currencyCode: authManager.currencyCode,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                top: UIConstants.spacingMd,
                left: UIConstants.appHorizontalPadding,
                right: UIConstants.appHorizontalPadding,
              ),
              sliver: InfiniteSliverListComponent(
                controller: controller,
                itemBuilder: (investment) => InvestmentTileComponent(investment: investment),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
