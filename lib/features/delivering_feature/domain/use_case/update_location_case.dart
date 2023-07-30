

import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/delivering_feature/domain/repository/repository.dart';
import 'package:shop_delivery/features/delivering_feature/domain/use_case/use_case.dart';

class UpdateLocationCase extends DeliveringUseCase<Unit,ParamUpdateLocation>{
  final DeliveringRepository repository;
  UpdateLocationCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ParamUpdateLocation param)async{
    return await repository.updateLocation(param.data);
  }

}



class ParamUpdateLocation {
  final double lat;
  final double long;
  ParamUpdateLocation(this.lat, this.long);

  Map<String,dynamic>get data{
    return {
      "lat":lat.toString(),
      "long":long.toString(),
    };
  }

}