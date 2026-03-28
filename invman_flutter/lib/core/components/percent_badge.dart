import 'package:flutter/material.dart';
import 'package:invman_flutter/core/utils/constants/ui_constants.dart';

class PercentBadge extends StatelessWidget {
  final double percent;
  final Color color;

  const PercentBadge({super.key, required this.percent, required this.color});

  @override
  Widget build(BuildContext context) {
    final isPositive = percent >= 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: UIConstants.spacingSm, vertical: UIConstants.spacingXs),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(UIConstants.radiusXl),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isPositive ? Icons.trending_up : Icons.trending_down, size: UIConstants.iconSm, color: color),
          const SizedBox(width: UIConstants.spacingXs),
          Text(
            '${isPositive ? '+' : ''}${percent.toStringAsFixed(1)}%',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
