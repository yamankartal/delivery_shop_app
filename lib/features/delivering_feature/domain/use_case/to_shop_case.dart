import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/delivering_feature/domain/repository/repository.dart';
import 'package:shop_delivery/features/delivering_feature/domain/use_case/use_case.dart';

import '../../data/model/to_shop_model.dart';

class ToShopCase extends DeliveringUseCase<ToShopModel,ParamToShop>{
  final DeliveringRepository repository;

  ToShopCase(this.repository);

  @override
  Future<Either<Failure, ToShopModel>> call(ParamToShop param)async{
    return await repository.toShop();
  }

}


class ParamToShop{}