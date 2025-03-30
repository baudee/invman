import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';

class ErrorComponent extends StatelessWidget {
  final String error;
  final Function? handleRefresh;
  const ErrorComponent({super.key, required this.error, this.handleRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error),
          if (handleRefresh != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () => handleRefresh!(),
                child: Text(S.of(context).error_tryAgain),
              ),
            )
        ],
      ),
    );
  }
}
