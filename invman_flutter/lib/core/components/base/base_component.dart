import 'package:flutter/material.dart';
import 'package:invman_flutter/core/utils/utils.dart';

abstract class BaseComponent extends StatelessWidget {
  const BaseComponent({super.key});

  @override
  Widget build(BuildContext context) {
    switch (ScreenUtils.size(context)) {
      case ScreenSize.lg:
        return bodyLg(context);
      case ScreenSize.md:
        return bodyMd(context);
      case ScreenSize.sm:
        return body(context);
    }
  }

  Widget body(BuildContext context) {
    return const SizedBox.shrink();
  }

  Widget bodyMd(BuildContext context) {
    return body(context);
  }

  Widget bodyLg(BuildContext context) {
    return bodyMd(context);
  }
}
