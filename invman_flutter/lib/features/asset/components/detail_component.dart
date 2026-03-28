import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/asset/components/graph_component.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/asset/asset.dart';

class AssetDetailComponent extends StatelessWidget {
  final AssetDetailController controller;
  final UserPreferencesManager userPreferencesManager;
  const AssetDetailComponent({super.key, required this.controller, required this.userPreferencesManager});

  @override
  Widget build(BuildContext context) {
    final asset = controller.state.value.requireValue;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AssetHeaderComponent(asset: asset),
          Padding(
            padding: .symmetric(horizontal: UIConstants.appHorizontalPadding),
            child: Column(
              children: [
                AssetGraphComponent(controller: controller, preferencesManager: userPreferencesManager),
                const SizedBox(height: UIConstants.spacingSm),
                SectionHeaderComponent(title: S.of(context).asset_info),
                const SizedBox(height: UIConstants.spacingSm),
                if (asset.exchange != null)
                  Material(
                    child: ListTile(
                      leading: Icon(Icons.attach_money, color: Theme.of(context).colorScheme.primary),
                      title: Text(S.of(context).asset_exchange),
                      trailing: Text(asset.exchange!),
                    ),
                  ),
                const SizedBox(height: UIConstants.spacingXs),
                Material(
                  child: ListTile(
                    leading: Icon(Icons.category, color: Theme.of(context).colorScheme.primary),
                    title: Text(S.of(context).investment_quoteType),
                    trailing: Text(S.of(context).asset_type(asset.type.name)),
                  ),
                ),
                const SizedBox(height: UIConstants.spacingXs),
                Material(
                  child: ListTile(
                    leading: Icon(Icons.update, color: Theme.of(context).colorScheme.primary),
                    title: Text(S.of(context).core_lastUpdate),
                    trailing: Text(
                      asset.timestamp != null ? DateFormat.yMMMd().add_jm().format(asset.timestamp!.toLocal()) : '-',
                    ),
                  ),
                ),
                const SizedBox(height: UIConstants.spacingXl),
                ActionButton(
                  child: Text(S.of(context).investment_create),
                  onPressed: () => router.push(InvestmentEditScreen.route(0), extra: asset),
                ),
                const SizedBox(height: UIConstants.spacingMd),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
