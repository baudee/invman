import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/stock/extensions/extensions.dart';

class LikeButtonComponent extends StatelessWidget {
  final Stock stock;
  final VoidCallback onPressed;

  const LikeButtonComponent({super.key, required this.stock, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      onPressed: onPressed,
      icon: Icon(stock.isLiked ? Icons.favorite : Icons.favorite_border, color: theme.colorScheme.primary),
    );
  }
}
