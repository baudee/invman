import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/core/providers/providers.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalFeeTileComponent extends ConsumerWidget {
  final WithdrawalFee fee;

  const WithdrawalFeeTileComponent({super.key, required this.fee});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.read(userPreferencesProvider).currency;
    return ListTile(
      title: Text("${fee.percent} %", overflow: TextOverflow.ellipsis),
      subtitle: Text("Fixed: ${fee.fixed.toStringPrice(currency)} - Minimum: ${fee.minimum.toStringPrice(currency)}",
          overflow: TextOverflow.ellipsis),
      onTap: () => router.pushRelative(WithdrawalFeeDetailScreen.route(fee.id)),
    );
  }
}
