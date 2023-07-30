// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  final int? orderId;
  final int? deliveryEarning;
  final DateTime? orderAccepteTime;
  final int? orderDistance;
  final int? deliveryKilometerEarning;
  final DateTime? orderDateTime;

 const OrderModel({
    this.orderId,
    this.deliveryEarning,
    this.orderAccepteTime,
    this.orderDistance,
    this.deliveryKilometerEarning,
    this.orderDateTime,
  });

  OrderModel copyWith({
    int? orderId,
    int? deliveryEarning,
    DateTime? orderAccepteTime,
    int? orderDistance,
    int? deliveryKilometerEarning,
    DateTime? orderDateTime,
  }) =>
      OrderModel(
        orderId: orderId ?? this.orderId,
        deliveryEarning: deliveryEarning ?? this.deliveryEarning,
        orderAccepteTime: orderAccepteTime ?? this.orderAccepteTime,
        orderDistance: orderDistance ?? this.orderDistance,
        deliveryKilometerEarning: deliveryKilometerEarning ?? this.deliveryKilometerEarning,
        orderDateTime: orderDateTime ?? this.orderDateTime,
      );

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    orderId: json["order_id"],
    deliveryEarning: json["delivery_earning"],
    orderAccepteTime: json["order_accepte_time"] == null ? null : DateTime.parse(json["order_accepte_time"]),
    orderDistance: json["order_distance"],
    deliveryKilometerEarning: json["delivery_kilometer_earning"],
    orderDateTime: json["order_date_time"] == null ? null : DateTime.parse(json["order_date_time"]),
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "delivery_earning": deliveryEarning,
    "order_accepte_time": orderAccepteTime?.toIso8601String(),
    "order_distance": orderDistance,
    "delivery_kilometer_earning": deliveryKilometerEarning,
    "order_date_time": orderDateTime?.toIso8601String(),
  };
}
