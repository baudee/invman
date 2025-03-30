import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/config/generated/l10n.dart';

class AppContainer extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AppContainer({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.sync_alt_rounded), label: S.of(context).transfer_title),
          NavigationDestination(icon: Icon(Icons.my_library_books_outlined), label: S.of(context).stock_title),
          NavigationDestination(icon: Icon(Icons.menu), label: S.of(context).account_title),
        ],
      ),
    );
  }
}
