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
          NavigationDestination(icon: Icon(Icons.my_library_books_outlined), label: "Stock"),
          NavigationDestination(icon: Icon(Icons.menu), label: "Menu"),
        ],
      ),
    );
  }
}
