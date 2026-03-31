import 'package:invman_client/invman_client.dart';

class DividendData {
  final List<ComputedDividendValue> calendar;
  final List<TotalDividendYear> history;

  DividendData({
    required this.calendar,
    required this.history,
  });
}
