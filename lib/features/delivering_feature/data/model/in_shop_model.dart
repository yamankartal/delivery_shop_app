// To parse this JSON data, do
//
//     final inShopModel = inShopModelFromJson(jsonString);

import 'dart:convert';

InShopModel inShopModelFromJson(String str) => InShopModel.fromJson(json.decode(str));

String inShopModelToJson(InShopModel data) => json.encode(data.toJson());

class InShopModel {
  final List<OrderItem>? orderItems;
  final OrderPrice? orderPrice;

 const InShopModel({
    this.orderItems,
    this.orderPrice,
  });

  InShopModel copyWith({
    List<OrderItem>? orderItems,
    OrderPrice? orderPrice,
  }) =>
      InShopModel(
        orderItems: orderItems ?? this.orderItems,
        orderPrice: orderPrice ?? this.orderPrice,
      );

  factory InShopModel.fromJson(Map<String, dynamic> json) => InShopModel(
    orderItems: json["order_items"] == null ? [] : List<OrderItem>.from(json["order_items"]!.map((x) => OrderItem.fromJson(x))),
    orderPrice: json["order_price"] == null ? null : OrderPrice.fromJson(json["order_price"]),
  );

  Map<String, dynamic> toJson() => {
    "order_items": orderItems == null ? [] : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
    "order_price": orderPrice?.toJson(),
  };
}

class OrderItem {
  final String? productName;
  final int? cartProductQuantity;

  OrderItem({
    this.productName,
    this.cartProductQuantity,
  });

  OrderItem copyWith({
    String? productName,
    int? cartProductQuantity,
  }) =>
      OrderItem(
        productName: productName ?? this.productName,
        cartProductQuantity: cartProductQuantity ?? this.cartProductQuantity,
      );

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    productName: json["product_name"],
    cartProductQuantity: json["cart_product_quantity"],
  );

  Map<String, dynamic> toJson() => {
    "product_name": productName,
    "cart_product_quantity": cartProductQuantity,
  };
}

class OrderPrice {
  final double? orderPrice;

  OrderPrice({
    this.orderPrice,
  });

  OrderPrice copyWith({
    double? orderPrice,
  }) =>
      OrderPrice(
        orderPrice: orderPrice ?? this.orderPrice,
      );

  factory OrderPrice.fromJson(Map<String, dynamic> json) => OrderPrice(
    orderPrice: json["order_price"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "order_price": orderPrice,
  };
}
