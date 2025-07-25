import 'package:flutter/material.dart';

class EditIconButton extends StatelessWidget {
  final void Function()? onPressed;
  const EditIconButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: onPressed,
    );
  }
}
