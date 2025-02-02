import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          NavigationDestination(icon: Icon(Icons.star), label: "Home"),
          NavigationDestination(icon: Icon(Icons.star), label: "Entries"),
          NavigationDestination(icon: Icon(Icons.star), label: "Menu"),
        ],
      ),
    );
  }
}
