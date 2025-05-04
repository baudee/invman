import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/providers/providers.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalTileComponent extends ConsumerWidget {
  final Withdrawal withdrawal;

  const WithdrawalTileComponent({super.key, required this.withdrawal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.read(userPreferencesProvider).currency;
    return ListTile(
      title: Text("${withdrawal.percent} %", overflow: TextOverflow.ellipsis),
      subtitle: Text(
          "Fixed: ${withdrawal.fixed.toStringPrice(currency)} - Minimum: ${withdrawal.minimum.toStringPrice(currency)}",
          overflow: TextOverflow.ellipsis),
      onTap: () => context.push(WithdrawalDetailScreen.absoluteRoute(withdrawal.id)),
    );
  }
}
