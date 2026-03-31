import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';

class DeleteButton extends StatelessWidget {
  final void Function()? onPressed;
  const DeleteButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.error,
      child: Text(S.of(context).core_delete),
    );
  }
}
