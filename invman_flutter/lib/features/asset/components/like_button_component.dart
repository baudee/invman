import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/features/asset/asset.dart';

class LikeButtonComponent extends StatelessWidget {
  final Asset asset;
  final VoidCallback onPressed;

  const LikeButtonComponent({super.key, required this.asset, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      onPressed: onPressed,
      icon: Icon(asset.isLiked ? Icons.favorite : Icons.favorite_border, color: theme.colorScheme.primary),
    );
  }
}
