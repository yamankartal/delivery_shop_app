import 'package:dartz/dartz.dart';

import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:shop_delivery/core/constants/exceptions.dart';

import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/auth_feature/data/sources/local.dart';

import 'package:shop_delivery/features/home_feature/data/model/home_model.dart';
import 'package:shop_delivery/features/home_feature/data/sources/remote.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../domain/repository/repository.dart';

class HomeRepositoryImp extends HomeRepository{
  final HomeRemote remote;
  final AuthLocal local;
  final InternetConnectionChecker internetConnectionChecker;
  HomeRepositoryImp(this.remote, this.internetConnectionChecker, this.local);

  @override
  Future<Either<Failure, Unit>> openStatus()async {
    if(await internetConnectionChecker.hasConnection){

      try{
        final res=await remote.openStatus(local.getId()!);
        if(res) {
          return const Right(unit);
        }
        return Left(BackendFailure( "No Data found"));


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
  Future<Either<Failure, Unit>> closeStatus()async {
    if(await internetConnectionChecker.hasConnection){

      try{
        final res=await remote.closeStatus(local.getId()!);
        if(res) {
          return const Right(unit);
        }
        return Left(BackendFailure( "No Data found"));


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
  Future<Either<Failure, HomeModel>> getData()async {
    if(await internetConnectionChecker.hasConnection){

      try{
        final res=await remote.getData(local.getId()!);
        if(res!=null) {
          return  Right(res);
        }
        return Left(BackendFailure( "No Data found"));


      }
      on ServerException{
        return Left(ServerFailure());
      }
    }

    else{
      print("dasd");
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Position>> getPosition() async{
    if(await internetConnectionChecker.hasConnection){

      try{
        final res=await remote.getPosition();
          return  Right(res);
      }
      on ServerException{
        return Left(ServerFailure());
      }
    }

    else{
      return Left(ConnectionFailure());
    }
  }


}