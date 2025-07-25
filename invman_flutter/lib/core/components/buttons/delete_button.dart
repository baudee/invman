import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final void Function()? onPressed;
  const DeleteButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 0),
      ),
      label: Icon(Icons.delete),
    );
  }
}
