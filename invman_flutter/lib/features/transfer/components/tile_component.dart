import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferTileComponent extends StatelessWidget {
  final Transfer transfer;

  const TransferTileComponent({super.key, required this.transfer});

  @override
  Widget build(BuildContext context) {
    final authManager = getIt<AuthManager>();

    return ListTile(
      title: Text(transfer.amount.toStringPrice(authManager.currencyCode)),
      subtitle: Text(DateFormat('dd/MM/yyyy').format(transfer.createdAt.toLocal())),
      trailing: Text('${S.of(context).investment_quantity}: ${transfer.quantity}'),
      onTap: () => router.push(TransferEditScreen.route(transfer.investmentId, transfer.id!)),
    );
  }
}
