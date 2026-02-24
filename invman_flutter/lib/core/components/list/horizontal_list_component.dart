import 'package:flutter/material.dart';
import 'package:invman_flutter/core/utils/constants/ui_constants.dart';

class HorizontalListComponent<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final double height;
  final double itemWidth;
  final double spacing;

  const HorizontalListComponent({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.height = 120,
    this.itemWidth = 100,
    this.spacing = UIConstants.spacingMd,
  });

  @override
  Widget build(BuildContext context) {
    const shadowPadding = UIConstants.spacingSm;
    return SizedBox(
      height: height + shadowPadding,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        padding: const EdgeInsets.symmetric(vertical: shadowPadding),
        itemCount: items.length,
        separatorBuilder: (_, _) => SizedBox(width: spacing),
        itemBuilder: (context, index) => SizedBox(width: itemWidth, child: itemBuilder(items[index])),
      ),
    );
  }
}
