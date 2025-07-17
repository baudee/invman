import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

class WithdrawalFeeDetailComponent extends ConsumerWidget {
  final WithdrawalFee fee;
  const WithdrawalFeeDetailComponent({super.key, required this.fee});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text("${fee.percent} %"),
        Divider(),
        Text(fee.fixed.toStringPrice(ref.read(userPreferencesProvider).currency)),
        Divider(),
        Text(fee.minimum.toStringPrice(ref.read(userPreferencesProvider).currency)),
      ],
    );
  }
}
