import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';

class PopupMenuActions extends StatelessWidget {
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const PopupMenuActions({this.onEdit, this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    if (onEdit == null && onDelete == null) return const SizedBox.shrink();

    return PopupMenuButton<int>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        if (value == 0) onEdit?.call();
        if (value == 1) onDelete?.call();
      },
      itemBuilder: (context) => [
        if (onEdit != null)
          PopupMenuItem(
            value: 0,
            child: Row(
              children: [
                const Icon(Icons.edit),
                const SizedBox(width: 10),
                Text(S.current.core_edit),
              ],
            ),
          ),
        if (onDelete != null)
          PopupMenuItem(
            value: 1,
            child: Row(
              children: [
                const Icon(Icons.delete, color: Colors.red),
                const SizedBox(width: 10),
                Text(
                  S.current.core_delete,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
