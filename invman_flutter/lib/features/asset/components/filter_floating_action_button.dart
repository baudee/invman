import 'package:flutter/material.dart';
import 'package:invman_flutter/features/asset/components/filter_sheet.dart';
import 'package:invman_flutter/features/asset/controllers/search_list_controller.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AssetFilterFloatingActionButton extends StatelessWidget {
  final AssetSearchListController controller;

  const AssetFilterFloatingActionButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        FocusScope.of(context).unfocus();
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => AssetFilterSheet(controller: controller),
        );
      },
      child: Watch((context) {
        final hasFilters =
            controller.type.value != null || controller.exchange.value != null || controller.currency.value != null;
        return Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.filter_list),
            if (hasFilters)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
