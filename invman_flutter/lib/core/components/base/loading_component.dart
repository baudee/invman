import 'package:flutter/material.dart';

class LoadingComponent extends StatelessWidget {
  const LoadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        Theme.of(context).brightness == Brightness.dark
            ? "assets/images/loading_dark.gif"
            : "assets/images/loading.gif",
        width: 50,
        height: 50,
        errorBuilder: (context, error, stackTrace) {
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
