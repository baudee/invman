import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

class InvestmentSelectTileComponent extends StatelessWidget {
  final Investment investment;
  final bool selected;
  final bool locked;
  final VoidCallback onToggle;

  const InvestmentSelectTileComponent({
    super.key,
    required this.investment,
    required this.selected,
    required this.locked,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: !locked,
      leading: investment.asset != null ? AvatarComponent(asset: investment.asset!) : null,
      title: Text(investment.name, overflow: TextOverflow.ellipsis),
      subtitle: Text(investment.asset?.name ?? "", overflow: TextOverflow.ellipsis),
      trailing: Checkbox(
        value: selected,
        onChanged: locked ? null : (_) => onToggle(),
      ),
      onTap: locked ? null : onToggle,
    );
  }
}
