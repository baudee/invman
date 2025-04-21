import 'package:flutter/material.dart';

class InvestmentHeaderComponent extends StatelessWidget {
  const InvestmentHeaderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Text('header'),
    );
  }
}
