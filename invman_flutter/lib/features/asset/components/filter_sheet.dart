import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/utils/constants/ui_constants.dart';
import 'package:invman_flutter/features/asset/controllers/search_list_controller.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AssetFilterSheet extends HookWidget {
  final AssetSearchListController controller;

  const AssetFilterSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final selectedType = signal(controller.type.value);
    final selectedExchange = signal(controller.exchange.value);
    final selectedCurrency = signal(controller.currency.value);

    final s = S.of(context);

    return Padding(
      padding: const EdgeInsets.all(UIConstants.spacingMd),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(s.asset_filters, style: Theme.of(context).textTheme.titleMedium),
              TextButton(
                onPressed: () {
                  selectedType.value = null;
                  selectedExchange.value = null;
                  selectedCurrency.value = null;
                  context.pop();
                },
                child: Text(s.core_cancel),
              ),
            ],
          ),
          const SizedBox(height: UIConstants.spacingMd),
          Text(s.investment_type, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: UIConstants.spacingSm),
          _TypeChips(selectedTypeSignal: selectedType),
          const SizedBox(height: UIConstants.spacingMd),
          Text(s.asset_filters_currency, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: UIConstants.spacingSm),
          _CurrencyDropdown(
            selectedCurrencySignal: selectedCurrency,
            currencies: controller.currencies.watch(context),
          ),
          const SizedBox(height: UIConstants.spacingMd),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                controller.setType(selectedType.value);
                controller.setExchange(selectedExchange.value);
                controller.setCurrency(selectedCurrency.value);
                context.pop();
              },
              child: Text(s.core_apply),
            ),
          ),
          const SizedBox(height: UIConstants.spacingSm),
        ],
      ),
    );
  }
}

class _TypeChips extends StatelessWidget {
  final Signal<AssetType?> selectedTypeSignal;

  const _TypeChips({required this.selectedTypeSignal});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final types = AssetType.values;
    final padding = const EdgeInsets.all(UIConstants.spacingXs);

    return Wrap(
      spacing: UIConstants.spacingSm,
      children: [
        ChoiceChip(
          padding: padding,
          label: Text(s.asset_filters_all),
          selected: selectedTypeSignal.watch(context) == null,
          onSelected: (_) => selectedTypeSignal.value = null,
        ),
        ...types.map(
          (type) => ChoiceChip(
            padding: padding,
            label: Text(s.asset_type(type.name)),
            selected: selectedTypeSignal.watch(context) == type,
            onSelected: (selected) => selectedTypeSignal.value = selected ? type : null,
          ),
        ),
      ],
    );
  }
}

class _CurrencyDropdown extends StatelessWidget {
  final Signal<Currency?> selectedCurrencySignal;
  final List<Currency> currencies;

  const _CurrencyDropdown({required this.selectedCurrencySignal, required this.currencies});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return DropdownButtonFormField<Currency?>(
      initialValue: selectedCurrencySignal.watch(context),
      decoration: const InputDecoration(border: OutlineInputBorder()),
      items: [
        DropdownMenuItem(value: null, child: Text(s.asset_filters_all)),
        ...currencies.map(
          (currency) => DropdownMenuItem(value: currency, child: Text(currency.code)),
        ),
      ],
      onChanged: (value) => selectedCurrencySignal.value = value,
    );
  }
}
