import 'package:invman_server/src/stock/data/models/models.dart';

class StockResponse {
  final List<StockInfo> data;
  final String status;

  StockResponse({required this.data, required this.status});

  factory StockResponse.fromJson(Map<String, dynamic> json) {
    return StockResponse(
      data: (json['data'] as List).map((item) => StockInfo.fromJson(item)).toList(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((stock) => stock.toJson()).toList(),
      'status': status,
    };
  }
}