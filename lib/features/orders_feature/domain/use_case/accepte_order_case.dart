import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/orders_feature/domain/use_case/use_case.dart';

import '../../data/model/orders_model.dart';
import '../repository/repository.dart';

class AccepteOrderCase extends OrdersUseCase<Unit,ParamAccepteOrderCase>{
  final OrdersRepository repository;
  AccepteOrderCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ParamAccepteOrderCase param)async{
    return await repository.accepteOrder(param.orderId,param.data);
  }

}

class ParamAccepteOrderCase{
  final int orderId;
  final DateTime dateTime;
  ParamAccepteOrderCase(this.orderId, this.dateTime);

  Map<String,dynamic> get data{
    return {"date_time":dateTime.toIso8601String()};
  }

}