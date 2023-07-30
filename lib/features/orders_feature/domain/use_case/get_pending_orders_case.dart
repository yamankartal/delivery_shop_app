import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/orders_feature/domain/use_case/use_case.dart';

import '../../data/model/orders_model.dart';
import '../repository/repository.dart';

class GetPendingOrdersCase extends OrdersUseCase<List<OrderModel>,ParamGetPendingOrders>{
  final OrdersRepository repository;
  GetPendingOrdersCase(this.repository);

  @override
  Future<Either<Failure, List<OrderModel>>> call(ParamGetPendingOrders param)async{
    return await repository.getPendingOrders();
  }

}

class ParamGetPendingOrders{}