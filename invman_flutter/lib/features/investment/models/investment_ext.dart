import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';

extension InvestmentExtension on Investment {
  double get percent {
    final percent = (withdrawAmount - investAmount) / investAmount;
    return percent * 100;
  }

  Color get percentColor {
    if (percent > 0) {
      return Colors.green;
    } else if (percent < 0) {
      return Colors.red;
    }
    return Colors.grey;
  }
}
