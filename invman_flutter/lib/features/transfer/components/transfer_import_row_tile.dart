import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/transfer/controllers/transfer_import_controller.dart';

class TransferImportRowTile extends StatefulWidget {
  final TransferImportRow row;
  final ValueChanged<double?> onQuantityChanged;
  final ValueChanged<double?> onAmountChanged;
  final ValueChanged<DateTime> onDateChanged;
  final VoidCallback onDelete;

  const TransferImportRowTile({
    super.key,
    required this.row,
    required this.onQuantityChanged,
    required this.onAmountChanged,
    required this.onDateChanged,
    required this.onDelete,
  });

  @override
  State<TransferImportRowTile> createState() => _TransferImportRowTileState();
}

class _TransferImportRowTileState extends State<TransferImportRowTile> {
  late final TextEditingController _quantityController;
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(text: widget.row.quantity?.toString() ?? '');
    _amountController = TextEditingController(text: widget.row.amount?.toString() ?? '');
  }

  @override
  void didUpdateWidget(covariant TransferImportRowTile old) {
    super.didUpdateWidget(old);
    final qStr = widget.row.quantity?.toString() ?? '';
    if (qStr != _quantityController.text && double.tryParse(_quantityController.text) != widget.row.quantity) {
      _quantityController.text = qStr;
    }
    final aStr = widget.row.amount?.toString() ?? '';
    if (aStr != _amountController.text && double.tryParse(_amountController.text) != widget.row.amount) {
      _amountController.text = aStr;
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.row.date ?? DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) widget.onDateChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = widget.row.date != null
        ? '${widget.row.date!.year.toString().padLeft(4, '0')}-${widget.row.date!.month.toString().padLeft(2, '0')}-${widget.row.date!.day.toString().padLeft(2, '0')}'
        : '—';
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: UIConstants.spacingSm, vertical: UIConstants.spacingXs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.row.rowErrorKey != null) ...[
            Text(
              translateRowError(widget.row.rowErrorKey, widget.row.rowErrorContext) ?? '',
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error),
            ),
            const SizedBox(height: UIConstants.spacingXs),
          ],
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _quantityController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[-0-9.]'))],
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: S.of(context).transferImport_quantity,
                  ),
                  onChanged: (v) => widget.onQuantityChanged(double.tryParse(v.trim())),
                ),
              ),
              const SizedBox(width: UIConstants.spacingSm),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[-0-9.]'))],
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: S.of(context).transferImport_amount,
                  ),
                  onChanged: (v) => widget.onAmountChanged(double.tryParse(v.trim())),
                ),
              ),
              const SizedBox(width: UIConstants.spacingSm),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: S.of(context).core_delete,
                onPressed: widget.onDelete,
              ),
            ],
          ),
          const SizedBox(height: UIConstants.spacingXs),
          Row(
            children: [
              TextButton.icon(
                icon: const Icon(Icons.calendar_today, size: 16),
                label: Text(dateStr),
                onPressed: _pickDate,
              ),
              const Spacer(),
              Text(S.of(context).transferImport_lineNumber(widget.row.lineNumber), style: theme.textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}
