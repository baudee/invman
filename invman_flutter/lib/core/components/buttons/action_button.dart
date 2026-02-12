import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  const ActionButton({super.key, this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed == null ? null : () => onPressed!(),
      style: FilledButton.styleFrom(minimumSize: const Size(double.infinity, 0)),
      child: child,
    );
  }
}
