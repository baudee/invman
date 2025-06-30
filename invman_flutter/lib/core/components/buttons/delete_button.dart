import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final void Function()? onPressed;
  const DeleteButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      label: Icon(Icons.delete),
    );
  }
}
