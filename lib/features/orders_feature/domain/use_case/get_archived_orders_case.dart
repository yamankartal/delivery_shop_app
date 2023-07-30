import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/orders_feature/domain/use_case/use_case.dart';

import '../../data/model/orders_model.dart';
import '../repository/repository.dart';

class GetArchivedOrdersCase extends OrdersUseCase<List<OrderModel>,ParamGetArchivedOrders>{
  final OrdersRepository repository;
  GetArchivedOrdersCase(this.repository);

  @override
  Future<Either<Failure, List<OrderModel>>> call(ParamGetArchivedOrders param)async{
    return await repository.getArchivedOrders();
  }

}

class ParamGetArchivedOrders{}