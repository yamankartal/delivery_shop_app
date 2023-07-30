import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/delivering_feature/domain/repository/repository.dart';
import 'package:shop_delivery/features/delivering_feature/domain/use_case/use_case.dart';


class GetCurrentLocationCase extends DeliveringUseCase<Position,ParamGetCurrentLocation>{
  final DeliveringRepository repository;

  GetCurrentLocationCase(this.repository);

  @override
  Future<Either<Failure, Position>> call(ParamGetCurrentLocation param)async{
    return await repository.getCurrentLocation();
  }

}


class ParamGetCurrentLocation{

}