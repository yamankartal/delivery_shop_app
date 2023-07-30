import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/delivering_feature/domain/repository/repository.dart';
import 'package:shop_delivery/features/delivering_feature/domain/use_case/use_case.dart';

import '../../data/model/in_shop_model.dart';
import '../../data/model/to_shop_model.dart';

class LeavingShopStageCase extends DeliveringUseCase<Unit,ParamLeavingShopStage>{
  final DeliveringRepository repository;

  LeavingShopStageCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ParamLeavingShopStage param)async{
    return await repository.leavingShopStage(param.orderId);
  }

}


class ParamLeavingShopStage{
 final  int orderId;

  ParamLeavingShopStage(this.orderId);
}