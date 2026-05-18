import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/features/asset/asset.dart';
import 'package:invman_flutter/features/transfer/components/transfer_import_investment_picker.dart';
import 'package:invman_flutter/features/transfer/components/transfer_import_row_tile.dart';
import 'package:invman_flutter/features/transfer/controllers/transfer_import_controller.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class TransferImportGroupCard extends StatelessWidget {
  final TransferImportController controller;
  final List<int> rowIndices;

  const TransferImportGroupCard({
    super.key,
    required this.controller,
    required this.rowIndices,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rows = controller.rows.value;
    final firstRow = rows[rowIndices.first];
    final isExisting = firstRow.resolution == TransferImportRowResolution.existingInvestment;
    final asset = firstRow.asset;

    final hasErrors = rowIndices.any((i) {
      final r = rows[i];
      return r.investmentErrorKey != null || r.rowErrorKey != null;
    });

    return Card(
      margin: const EdgeInsets.only(bottom: UIConstants.spacingMd),
      shape: hasErrors
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: theme.colorScheme.error, width: 1.5),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: UIConstants.spacingSm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, firstRow, isExisting, asset),
            const Divider(height: UIConstants.spacingMd),
            for (int j = 0; j < rowIndices.length; j++) ...[
              if (j > 0)
                const Divider(
                  height: 1,
                  indent: UIConstants.spacingSm,
                  endIndent: UIConstants.spacingSm,
                ),
              TransferImportRowTile(
                key: ValueKey(rows[rowIndices[j]].lineNumber),
                row: rows[rowIndices[j]],
                onQuantityChanged: (v) => controller.setQuantity(rowIndices[j], v),
                onAmountChanged: (v) => controller.setAmount(rowIndices[j], v),
                onDateChanged: (d) => controller.setDate(rowIndices[j], d),
                onDelete: () => controller.deleteRow(rowIndices[j]),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TransferImportRow firstRow, bool isExisting, Asset? asset) {
    final theme = Theme.of(context);
    final badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: UIConstants.spacingSm, vertical: 2),
      decoration: BoxDecoration(
        color: isExisting ? theme.colorScheme.surfaceContainerHighest : theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isExisting ? S.of(context).transferImport_existingInvestment : S.of(context).transferImport_newInvestment,
        style: theme.textTheme.labelSmall,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: UIConstants.spacingSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [badge]),
          const SizedBox(height: UIConstants.spacingSm),
          if (isExisting) _buildExistingBody(context, firstRow, asset) else _buildNewBody(context, firstRow, asset),
        ],
      ),
    );
  }

  Widget _buildExistingBody(BuildContext context, TransferImportRow firstRow, Asset? asset) {
    final theme = Theme.of(context);
    if (firstRow.existingInvestmentId == null) {
      final errorText = translateRowError(firstRow.investmentErrorKey, firstRow.investmentErrorContext);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (errorText != null)
            Text(
              errorText,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
            ),
          const SizedBox(height: UIConstants.spacingSm),
          Wrap(
            spacing: UIConstants.spacingSm,
            children: [
              OutlinedButton.icon(
                icon: const Icon(Icons.search),
                label: Text(S.of(context).transferImport_useExisting),
                onPressed: () => _pickExisting(context),
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.add),
                label: Text(S.of(context).transferImport_createNew),
                onPressed: () {
                  for (final i in rowIndices) {
                    controller.setResolution(i, TransferImportRowResolution.newInvestment);
                  }
                },
              ),
            ],
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(firstRow.existingInvestmentName ?? '', style: theme.textTheme.titleMedium),
        if (asset != null) AssetTileComponent(asset: asset, contentPadding: EdgeInsets.zero),
      ],
    );
  }

  Widget _buildNewBody(BuildContext context, TransferImportRow firstRow, Asset? asset) {
    final theme = Theme.of(context);
    final candidates = firstRow.assetCandidates ?? const <Asset>[];
    final showCandidates = asset == null && candidates.isNotEmpty;
    final errorText = translateRowError(firstRow.investmentErrorKey, firstRow.investmentErrorContext);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          initialValue: firstRow.newInvestmentName ?? '',
          decoration: InputDecoration(
            isDense: true,
            labelText: S.of(context).transferImport_investmentName,
          ),
          onChanged: (v) {
            for (final i in rowIndices) {
              controller.setNewInvestmentName(i, v);
            }
          },
        ),
        const SizedBox(height: UIConstants.spacingSm),
        if (errorText != null) ...[
          Text(
            errorText,
            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error),
          ),
          const SizedBox(height: UIConstants.spacingXs),
        ],
        if (showCandidates) ...[
          Text(S.of(context).transferImport_pickCandidate, style: theme.textTheme.labelMedium),
          const SizedBox(height: UIConstants.spacingXs),
          for (final candidate in candidates)
            AssetTileComponent(
              asset: candidate,
              contentPadding: EdgeInsets.zero,
              onTap: (a) {
                for (final i in rowIndices) {
                  controller.setAsset(i, a);
                }
              },
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              icon: const Icon(Icons.search, size: 16),
              label: Text(S.of(context).transferImport_searchAllAssets),
              onPressed: () => _pickAssetFromSearch(context),
            ),
          ),
        ] else
          AssetSelectTileComponent(
            asset: asset,
            onAssetSelected: (a) {
              for (final i in rowIndices) {
                controller.setAsset(i, a);
              }
            },
          ),
        WithdrawalRuleSelectTileComponent(
          rule: controller.findWithdrawalRule(firstRow.newInvestmentWithdrawalRuleId),
          onRuleSelected: (rule) {
            for (final i in rowIndices) {
              controller.setWithdrawalRule(i, rule.id);
            }
          },
          onRemove: () {
            for (final i in rowIndices) {
              controller.setWithdrawalRule(i, null);
            }
          },
        ),
      ],
    );
  }

  Future<void> _pickExisting(BuildContext context) async {
    final picked = await TransferImportInvestmentPicker.pick(context);
    if (picked != null) {
      for (final i in rowIndices) {
        controller.setExistingInvestment(i, picked);
      }
    }
  }

  Future<void> _pickAssetFromSearch(BuildContext context) async {
    final picked = await router.push(AssetSelectScreen.route());
    if (picked is Asset) {
      for (final i in rowIndices) {
        controller.setAsset(i, picked);
      }
    }
  }
}
