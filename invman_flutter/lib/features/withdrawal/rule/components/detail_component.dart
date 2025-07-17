import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleDetailComponent extends StatelessWidget {
  final WithdrawalRule rule;
  const WithdrawalRuleDetailComponent({super.key, required this.rule});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("${rule.currencyChangePercentage} %"),
          Divider(),
          Builder(
            builder: (_) {
              final fees = rule.fees ?? [];
              if (fees.isEmpty) {
                return Text(S.of(context).core_noItemsFound);
              } else {
                return Column(
                  children: fees.map(
                    (fee) {
                      return WithdrawalFeeTileComponent(
                        fee: fee,
                      );
                    },
                  ).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
