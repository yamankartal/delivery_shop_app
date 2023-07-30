import 'package:dartz/dartz.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:google_maps_flutter_platform_interface/src/types/polyline.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shop_delivery/core/constants/exceptions.dart';

import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/auth_feature/data/sources/local.dart';

import 'package:shop_delivery/features/delivering_feature/data/model/in_shop_model.dart';

import 'package:shop_delivery/features/delivering_feature/data/model/to_customer_model.dart';

import 'package:shop_delivery/features/delivering_feature/data/model/to_shop_model.dart';

import '../../domain/repository/repository.dart';
import '../sources/remote.dart';

class DeliveringRepositoryImp extends DeliveringRepository{
  final AuthLocal local;
  final InternetConnectionChecker internetConnectionChecker;
  final DeliveringRemote remote;
  DeliveringRepositoryImp(this.local, this.internetConnectionChecker, this.remote);


  @override
  Future<Either<Failure, InShopModel>> inShop(int orderId)async{
    if(await internetConnectionChecker.hasConnection){
      try{
        final res=await remote.inShop(orderId);
        return res==null?Left(BackendFailure( "No Data found")):Right(res);

      }

      on ServerException{
        return Left(ServerFailure());
      }
    }

    else{
      return Left(ConnectionFailure());
    }


  }

  @override
  Future<Either<Failure, ToCustomerModel>> toCustomer(int orderId) async{
    if(await internetConnectionChecker.hasConnection){
      try{
        final res=await remote.toCustomer(orderId);
        return res==null?Left(BackendFailure( "No Data found")):Right(res);

      }

      on ServerException{
        return Left(ServerFailure());
      }
    }

    else{
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, ToShopModel>> toShop() async{
    if(await internetConnectionChecker.hasConnection){
      try{
        final res=await remote.toShop(local.getId()!);
        return res==null?Left(BackendFailure( "No Data found")):Right(res);

      }

      on ServerException{
        return Left(ServerFailure());
      }
    }

    else{
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> arrivingToShopStage() async{
    if(await internetConnectionChecker.hasConnection){
      try{
        final res=await remote.arrivingToShopStage(local.getId()!);
        return res==false?Left(BackendFailure( "No Data found")):const Right(unit);

      }

      on ServerException{
        return Left(ServerFailure());
      }
    }

    else{
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> doneOrderStage(int orderId,Map<String,dynamic>data) async{
    if(await internetConnectionChecker.hasConnection){
      try{
        final res=await remote.doneOrderStage(local.getId()!,orderId,data);
        return res==false?Left(BackendFailure( "No Data found")):const Right(unit);

      }

      on ServerException{
        return Left(ServerFailure());
      }
    }

    else{
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> leavingShopStage(int orderId) async{
    if(await internetConnectionChecker.hasConnection){
      try{
        final res=await remote.leavingShopStage(local.getId()!,orderId);
        return res==false?Left(BackendFailure( "No Data found")):const Right(unit);

      }

      on ServerException{
        return Left(ServerFailure());
      }
    }

    else{
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Position>> getCurrentLocation() async{
    if(await internetConnectionChecker.hasConnection){
      try{
        final res=await remote.getCurrentLocation();
        return Right(res);

      }

      on ServerException{
        return Left(ServerFailure());
      }
    }

    else{
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateLocation(Map<String, dynamic> data) async{
    try{
      await remote.updateLocation(data,local.getId()!);
      return const Right(unit);
    }
        on ServerException{
      return Left(ServerFailure());
        }
  }

  @override
  Future<Either<Failure, Set<Polyline>>> getPolyLine(Map<String, dynamic> data)async{
    try{
    final res=  await remote.decodePolyline(data);
      return res.isEmpty?Left(BackendFailure("sdd")): Right(res);
    }
    on ServerException{
      return Left(ServerFailure());
    }
  }

}