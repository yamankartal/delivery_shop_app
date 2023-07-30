import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/failures.dart';

import '../../data/model/orders_model.dart';

abstract class OrdersRepository{
  Future<Either<Failure,List<OrderModel>>>getArchivedOrders();
  Future<Either<Failure,List<OrderModel>>>getPendingOrders();
  Future<Either<Failure,Unit>>accepteOrder(int orderId,Map<String,dynamic>data);
}