// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  final int? deliveryStatus;
  final int? deliveryAcceptingPercent;
  final int? deliveryCancelingPercent;
  final int? deliveryBanned;
  final int? deliveryOrderStage;
  final int? orderId;

 const HomeModel({
    this.deliveryStatus,
    this.deliveryAcceptingPercent,
    this.deliveryCancelingPercent,
    this.deliveryBanned,
    this.deliveryOrderStage,
    this.orderId,
  });

  HomeModel copyWith({
    int? deliveryStatus,
    int? deliveryAcceptingPercent,
    int? deliveryCancelingPercent,
    int? deliveryBanned,
    int? deliveryOrderStage,
    int? orderId,
  }) =>
      HomeModel(
        deliveryStatus: deliveryStatus ?? this.deliveryStatus,
        deliveryAcceptingPercent: deliveryAcceptingPercent ?? this.deliveryAcceptingPercent,
        deliveryCancelingPercent: deliveryCancelingPercent ?? this.deliveryCancelingPercent,
        deliveryBanned: deliveryBanned ?? this.deliveryBanned,
        deliveryOrderStage: deliveryOrderStage ?? this.deliveryOrderStage,
        orderId: orderId ?? this.orderId,
      );

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    deliveryStatus: json["delivery_status"],
    deliveryAcceptingPercent: json["delivery_accepting_percent"],
    deliveryCancelingPercent: json["delivery_canceling_percent"],
    deliveryBanned: json["delivery_banned"],
    deliveryOrderStage: json["delivery_order_stage"],
    orderId: json["order_id"],
  );

  Map<String, dynamic> toJson() => {
    "delivery_status": deliveryStatus,
    "delivery_accepting_percent": deliveryAcceptingPercent,
    "delivery_canceling_percent": deliveryCancelingPercent,
    "delivery_banned": deliveryBanned,
    "delivery_order_stage": deliveryOrderStage,
    "order_id": orderId,
  };
}
