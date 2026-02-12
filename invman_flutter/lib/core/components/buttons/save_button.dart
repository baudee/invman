import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';

class SaveButton extends StatelessWidget {
  final void Function()? onPressed;
  const SaveButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ActionButton(onPressed: onPressed, child: Text(S.of(context).core_save));
  }
}
