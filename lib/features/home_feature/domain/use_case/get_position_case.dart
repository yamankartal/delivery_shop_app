import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/home_feature/data/model/home_model.dart';
import 'package:shop_delivery/features/home_feature/domain/use_case/home_use_case.dart';

import '../repository/repository.dart';

class GetPositionCase extends HomeUseCase<Position,ParamGetPosition>{
  final HomeRepository repository;
  GetPositionCase(this.repository);

  @override
  Future<Either<Failure, Position>> call(ParamGetPosition param)async{
    return await repository.getPosition();
  }

}


class ParamGetPosition{}