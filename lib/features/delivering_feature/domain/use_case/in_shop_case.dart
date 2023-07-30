import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/delivering_feature/domain/repository/repository.dart';
import 'package:shop_delivery/features/delivering_feature/domain/use_case/use_case.dart';

import '../../data/model/in_shop_model.dart';
import '../../data/model/to_shop_model.dart';

class InShopCase extends DeliveringUseCase<InShopModel,ParamInShop>{
  final DeliveringRepository repository;

  InShopCase(this.repository);

  @override
  Future<Either<Failure, InShopModel>> call(ParamInShop param)async{
    return await repository.inShop(param.orderId);
  }

}


class ParamInShop{
  final int orderId;
  ParamInShop(this.orderId);
}