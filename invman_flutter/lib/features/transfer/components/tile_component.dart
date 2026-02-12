import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferTileComponent extends StatelessWidget {
  final Transfer transfer;

  const TransferTileComponent({super.key, required this.transfer});

  @override
  Widget build(BuildContext context) {
    final currency = (getIt<AuthController>().state.value as AuthStateSuccess).account.currency;

    return ListTile(
      title: Text(transfer.amount.toStringPrice(currency)),
      subtitle: Text(DateFormat('dd/MM/yyyy').format(transfer.createdAt.toLocal())),
      trailing: Text('${S.of(context).investment_quantity}: ${transfer.quantity}'),
      onTap: () => getIt<GoRouter>().pushRelative(TransferEditScreen.route(transfer.id)),
    );
  }
}
