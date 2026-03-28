import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/asset/asset.dart';

class AssetRootScreen extends HookWidget {
  const AssetRootScreen({super.key});

  static const pathSegment = '/assets';
  static String route() => pathSegment;

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<AssetRootController>());

    return BaseScreen(
      appBar: AppBar(
        leading: Padding(padding: const EdgeInsets.all(8.0), child: Image.asset("assets/images/logo.webp")),
        title: Text(AppConstants.appName, style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: AssetRootComponent(controller: controller),
    );
  }
}
