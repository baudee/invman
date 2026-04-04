import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';

extension InvestmentExtension on Investment {
  Color get percentColor {
    if (returnPercentage == null) {
      return Colors.grey;
    }
    if (returnPercentage! > 0) {
      return Colors.green;
    } else if (returnPercentage! < 0) {
      return Colors.red;
    }
    return Colors.grey;
  }
}
