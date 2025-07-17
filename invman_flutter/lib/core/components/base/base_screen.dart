import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/core/utils/utils.dart';

abstract class BaseScreen<T> extends ConsumerWidget {
  const BaseScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: switch (ScreenUtils.size(context)) {
        ScreenSize.sm => appBar(context, ref),
        ScreenSize.md => appBarMd(context, ref),
        ScreenSize.lg => appBarLg(context, ref),
      },
      floatingActionButton: floatingActionButton(context, ref),
      bottomNavigationBar: bottomNavigationBar(context, ref),
      body: Builder(
        builder: (bodyContext) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: UIConstants.appHorizontalPadding,
              vertical: UIConstants.appVerticalPadding,
            ),
            child: switch (ScreenUtils.size(context)) {
              ScreenSize.sm => body(context, ref),
              ScreenSize.md => bodyMd(context, ref),
              ScreenSize.lg => bodyLg(context, ref),
            },
          );
        },
      ),
    );
  }

  AppBar? appBar(BuildContext context, WidgetRef ref) {
    return null;
  }

  AppBar? appBarMd(BuildContext context, WidgetRef ref) {
    return appBar(context, ref);
  }

  AppBar? appBarLg(BuildContext context, WidgetRef ref) {
    return appBarMd(context, ref);
  }

  FloatingActionButton? floatingActionButton(BuildContext context, WidgetRef ref) {
    return null;
  }

  Widget? bottomNavigationBar(BuildContext context, WidgetRef ref) {
    return null;
  }

  Widget body(BuildContext context, WidgetRef ref);

  Widget bodyMd(BuildContext context, WidgetRef ref) {
    return body(context, ref);
  }

  Widget bodyLg(BuildContext context, WidgetRef ref) {
    return bodyMd(context, ref);
  }
}
