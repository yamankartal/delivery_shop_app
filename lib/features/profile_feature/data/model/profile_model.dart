// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  final int? deliveryAcceptingPercent;
  final int? deliveryCancelingPercent;
  final int? deliveryOrdersCount;
  final int? deliveryBanned;
  final double? deliveryBalance;
  final String? deliveryName;
  final int? deliveryReward;
  final int? ordersRewardNumber;
  final double? deliveryKilometerEarning;

  const ProfileModel({
    this.deliveryAcceptingPercent,
    this.deliveryCancelingPercent,
    this.deliveryOrdersCount,
    this.deliveryBanned,
    this.deliveryBalance,
    this.deliveryName,
    this.deliveryReward,
    this.ordersRewardNumber,
    this.deliveryKilometerEarning,
  });

  ProfileModel copyWith({
    int? deliveryAcceptingPercent,
    int? deliveryCancelingPercent,
    int? deliveryOrdersCount,
    int? deliveryBanned,
    double? deliveryBalance,
    String? deliveryName,
    int? deliveryReward,
    int? ordersRewardNumber,
    double? deliveryKilometerEarning,
  }) =>
      ProfileModel(
        deliveryAcceptingPercent: deliveryAcceptingPercent ?? this.deliveryAcceptingPercent,
        deliveryCancelingPercent: deliveryCancelingPercent ?? this.deliveryCancelingPercent,
        deliveryOrdersCount: deliveryOrdersCount ?? this.deliveryOrdersCount,
        deliveryBanned: deliveryBanned ?? this.deliveryBanned,
        deliveryBalance: deliveryBalance ?? this.deliveryBalance,
        deliveryName: deliveryName ?? this.deliveryName,
        deliveryReward: deliveryReward ?? this.deliveryReward,
        ordersRewardNumber: ordersRewardNumber ?? this.ordersRewardNumber,
        deliveryKilometerEarning: deliveryKilometerEarning ?? this.deliveryKilometerEarning,
      );

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    deliveryAcceptingPercent: json["delivery_accepting_percent"],
    deliveryCancelingPercent: json["delivery_canceling_percent"],
    deliveryOrdersCount: json["delivery_orders_count"],
    deliveryBanned: json["delivery_banned"],
    deliveryBalance: json["delivery_balance"]?.toDouble(),
    deliveryName: json["delivery_name"],
    deliveryReward: json["delivery_reward"],
    ordersRewardNumber: json["orders_reward_number"],
    deliveryKilometerEarning: json["delivery_kilometer_earning"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "delivery_accepting_percent": deliveryAcceptingPercent,
    "delivery_canceling_percent": deliveryCancelingPercent,
    "delivery_orders_count": deliveryOrdersCount,
    "delivery_banned": deliveryBanned,
    "delivery_balance": deliveryBalance,
    "delivery_name": deliveryName,
    "delivery_reward": deliveryReward,
    "orders_reward_number": ordersRewardNumber,
    "delivery_kilometer_earning": deliveryKilometerEarning,
  };
}
