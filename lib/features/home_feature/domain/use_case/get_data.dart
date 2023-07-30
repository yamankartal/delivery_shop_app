import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/home_feature/data/model/home_model.dart';
import 'package:shop_delivery/features/home_feature/domain/use_case/home_use_case.dart';

import '../repository/repository.dart';

class GetDateCase extends HomeUseCase<HomeModel,ParamGetData>{
  final HomeRepository repository;
  GetDateCase(this.repository);

  @override
  Future<Either<Failure, HomeModel>> call(ParamGetData param)async{
    return await repository.getData();
  }

}


class ParamGetData{}