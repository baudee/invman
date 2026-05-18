import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/investment/repositories/repositories.dart';

class TransferImportInvestmentPicker {
  TransferImportInvestmentPicker._();

  /// Opens a modal listing the user's investments. Returns the picked one or null.
  static Future<Investment?> pick(BuildContext context) async {
    return showModalBottomSheet<Investment>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => const _PickerSheet(),
    );
  }
}

class _PickerSheet extends StatefulWidget {
  const _PickerSheet();

  @override
  State<_PickerSheet> createState() => _PickerSheetState();
}

class _PickerSheetState extends State<_PickerSheet> {
  late final Future<List<Investment>> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<List<Investment>> _load() async {
    final repo = getIt<InvestmentRepository>();
    final result = await repo.list(page: 1, limit: 1000);
    return result.fold((_) => <Investment>[], (list) => list);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (ctx, scrollController) {
        return Padding(
          padding: const EdgeInsets.all(UIConstants.spacingMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).transferImport_existingInvestment, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: UIConstants.spacingSm),
              Expanded(
                child: FutureBuilder<List<Investment>>(
                  future: _future,
                  builder: (ctx, snap) {
                    if (snap.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final items = snap.data ?? [];
                    if (items.isEmpty) {
                      return Center(child: Text(S.of(context).investment_firstCreate));
                    }
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: items.length,
                      itemBuilder: (_, i) {
                        final inv = items[i];
                        return ListTile(
                          title: Text(inv.name, overflow: TextOverflow.ellipsis),
                          subtitle: inv.asset != null
                              ? Text('${inv.asset!.symbol} - ${inv.asset!.name}', overflow: TextOverflow.ellipsis)
                              : null,
                          onTap: () => Navigator.of(ctx).pop(inv),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
