import 'package:flutter/material.dart';
import 'package:invman_flutter/core/utils/utils.dart';

class BaseScreen extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final PreferredSizeWidget? appBarMd;
  final PreferredSizeWidget? appBarLg;

  final Widget body;
  final Widget? bodyMd;
  final Widget? bodyLg;

  final FloatingActionButton? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool noPadding;
  final bool extendBodyBehindAppBar;
  final bool noTopSafeArea;

  const BaseScreen({
    super.key,
    required this.body,
    this.bodyMd,
    this.bodyLg,
    this.appBar,
    this.appBarMd,
    this.appBarLg,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.noPadding = false,
    this.extendBodyBehindAppBar = false,
    this.noTopSafeArea = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = ScreenUtils.size(context);

    final PreferredSizeWidget? currentAppBar = switch (size) {
      ScreenSize.sm => appBar,
      ScreenSize.md => appBarMd ?? appBar,
      ScreenSize.lg => appBarLg ?? appBarMd ?? appBar,
    };

    final Widget currentBody = switch (size) {
      ScreenSize.sm => body,
      ScreenSize.md => bodyMd ?? body,
      ScreenSize.lg => bodyLg ?? bodyMd ?? body,
    };

    Widget bodyContent = noPadding
        ? currentBody
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: UIConstants.appHorizontalPadding),
            child: currentBody,
          );

    if (!noTopSafeArea) {
      bodyContent = SafeArea(top: true, bottom: true, child: bodyContent);
    } else {
      bodyContent = SafeArea(top: false, bottom: true, child: bodyContent);
    }

    return Scaffold(
      appBar: currentAppBar,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: bodyContent,
    );
  }
}
