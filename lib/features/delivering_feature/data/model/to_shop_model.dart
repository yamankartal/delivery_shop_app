// To parse this JSON data, do
//
//     final toShopModel = toShopModelFromJson(jsonString);

import 'dart:convert';

ToShopModel toShopModelFromJson(String str) => ToShopModel.fromJson(json.decode(str));

String toShopModelToJson(ToShopModel data) => json.encode(data.toJson());

class ToShopModel {
  final double? shopLat;
  final double? shopLong;

const  ToShopModel({
    this.shopLat,
    this.shopLong,
  });

  ToShopModel copyWith({
    double? shopLat,
    double? shopLong,
  }) =>
      ToShopModel(
        shopLat: shopLat ?? this.shopLat,
        shopLong: shopLong ?? this.shopLong,
      );

  factory ToShopModel.fromJson(Map<String, dynamic> json) => ToShopModel(
    shopLat: json["shop_lat"]?.toDouble(),
    shopLong: json["shop_long"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "shop_lat": shopLat,
    "shop_long": shopLong,
  };
}
