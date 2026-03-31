import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/dividend/dividend.dart';

class DividendListScreen extends HookWidget {
  const DividendListScreen({super.key});

  static const pathSegment = 'history';
  static String route() => '${DividendRootScreen.pathSegment}/$pathSegment';

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appBar: AppBar(title: Text(S.of(context).dividend_history)),
      body: InfiniteListComponent(
        controller: useMemoized(() => getIt<DividendListController>()),
        itemBuilder: (entry) => DividendListTile(entry: entry),
      ),
    );
  }
}
