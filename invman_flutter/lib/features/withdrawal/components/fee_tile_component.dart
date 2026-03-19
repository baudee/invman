import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';

class WithdrawalFeeTileComponent extends StatelessWidget {
  final WithdrawalFee fee;
  final Widget? trailing;
  final VoidCallback? onTap;

  const WithdrawalFeeTileComponent({super.key, required this.fee, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    final authManager = getIt<AuthManager>();
    final theme = Theme.of(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
        child: Icon(Icons.percent, color: theme.colorScheme.primary, size: UIConstants.iconMd),
      ),
      title: Text("${fee.percent}%"),
      subtitle: Text(
        "${S.of(context).withdrawal_fixed}: ${fee.fixed.toStringPrice(authManager.currencyCode)} - ${S.of(context).withdrawal_minimum}: ${fee.minimum.toStringPrice(authManager.currencyCode)}",
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
