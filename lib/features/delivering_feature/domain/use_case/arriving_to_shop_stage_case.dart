import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/delivering_feature/domain/repository/repository.dart';
import 'package:shop_delivery/features/delivering_feature/domain/use_case/use_case.dart';

import '../../data/model/in_shop_model.dart';
import '../../data/model/to_shop_model.dart';

class ArrivingShopStageCase extends DeliveringUseCase<Unit,ParamArrivingToShopStage>{
  final DeliveringRepository repository;

  ArrivingShopStageCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ParamArrivingToShopStage param)async{
    return await repository.arrivingToShopStage();
  }

}


class ParamArrivingToShopStage{

}