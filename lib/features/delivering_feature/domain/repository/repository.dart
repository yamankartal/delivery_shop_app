import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_delivery/core/constants/failures.dart';

import '../../data/model/in_shop_model.dart';
import '../../data/model/to_customer_model.dart';
import '../../data/model/to_shop_model.dart';

abstract class DeliveringRepository{
  Future<Either<Failure,ToShopModel>>toShop();
  Future<Either<Failure,InShopModel>>inShop(int orderId);
  Future<Either<Failure,ToCustomerModel>>toCustomer(int orderId);
  Future<Either<Failure,Unit>>arrivingToShopStage();
  Future<Either<Failure,Unit>>leavingShopStage(int orderId);
  Future<Either<Failure,Unit>>doneOrderStage(int orderId,Map<String,dynamic>data);
  Future<Either<Failure,Position>>getCurrentLocation();
  Future<Either<Failure,Unit>>updateLocation(Map<String,dynamic>data);
  Future<Either<Failure,Set<Polyline>>>getPolyLine(Map<String,dynamic>data);
}