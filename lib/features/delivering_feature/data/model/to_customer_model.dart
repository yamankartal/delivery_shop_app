// To parse this JSON data, do
//
//     final toCustomerModel = toCustomerModelFromJson(jsonString);

import 'dart:convert';

ToCustomerModel toCustomerModelFromJson(String str) => ToCustomerModel.fromJson(json.decode(str));

String toCustomerModelToJson(ToCustomerModel data) => json.encode(data.toJson());

class ToCustomerModel {
  final int? orderTotalPrice;
  final int? orderPaymentMethode;
  final String? addressCity;
  final String? addressStreet;
  final double? addressLat;
  final double? addressLong;
  final String? addressDetails;
  final String? addressFloor;
  final int? addressPhone;

 const ToCustomerModel({
    this.orderTotalPrice,
    this.orderPaymentMethode,
    this.addressCity,
    this.addressStreet,
    this.addressLat,
    this.addressLong,
    this.addressDetails,
    this.addressFloor,
    this.addressPhone,
  });

  ToCustomerModel copyWith({
    int? orderTotalPrice,
    int? orderPaymentMethode,
    String? addressCity,
    String? addressStreet,
    double? addressLat,
    double? addressLong,
    String? addressDetails,
    String? addressFloor,
    int? addressPhone,
  }) =>
      ToCustomerModel(
        orderTotalPrice: orderTotalPrice ?? this.orderTotalPrice,
        orderPaymentMethode: orderPaymentMethode ?? this.orderPaymentMethode,
        addressCity: addressCity ?? this.addressCity,
        addressStreet: addressStreet ?? this.addressStreet,
        addressLat: addressLat ?? this.addressLat,
        addressLong: addressLong ?? this.addressLong,
        addressDetails: addressDetails ?? this.addressDetails,
        addressFloor: addressFloor ?? this.addressFloor,
        addressPhone: addressPhone ?? this.addressPhone,
      );

  factory ToCustomerModel.fromJson(Map<String, dynamic> json) => ToCustomerModel(
    orderTotalPrice: json["order_total_price"],
    orderPaymentMethode: json["order_payment_methode"],
    addressCity: json["address_city"],
    addressStreet: json["address_street"],
    addressLat: json["address_lat"]?.toDouble(),
    addressLong: json["address_long"]?.toDouble(),
    addressDetails: json["address_details"],
    addressFloor: json["address_floor"],
    addressPhone: json["address_phone"],
  );

  Map<String, dynamic> toJson() => {
    "order_total_price": orderTotalPrice,
    "order_payment_methode": orderPaymentMethode,
    "address_city": addressCity,
    "address_street": addressStreet,
    "address_lat": addressLat,
    "address_long": addressLong,
    "address_details": addressDetails,
    "address_floor": addressFloor,
    "address_phone": addressPhone,
  };
}
