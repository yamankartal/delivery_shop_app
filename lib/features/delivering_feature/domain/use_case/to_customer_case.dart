import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/delivering_feature/domain/repository/repository.dart';
import 'package:shop_delivery/features/delivering_feature/domain/use_case/use_case.dart';

import '../../data/model/in_shop_model.dart';
import '../../data/model/to_customer_model.dart';
import '../../data/model/to_shop_model.dart';

class ToCustomerCase extends DeliveringUseCase<ToCustomerModel,ParamToCustomer>{
  final DeliveringRepository repository;

  ToCustomerCase(this.repository);

  @override
  Future<Either<Failure, ToCustomerModel>> call(ParamToCustomer param)async{
    return await repository.toCustomer(param.orderId);
  }

}


class ParamToCustomer{
  final int orderId;
  ParamToCustomer(this.orderId);
}