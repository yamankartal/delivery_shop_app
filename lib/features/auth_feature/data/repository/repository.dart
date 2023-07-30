import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/exceptions.dart';

import 'package:shop_delivery/core/constants/failures.dart';

import '../../domain/repository/repository.dart';
import '../sources/local.dart';
import '../sources/remote.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
class AuthRepositoryImp extends AuthRepository{

  final AuthRemote remote;
  final AuthLocal local;
  final InternetConnectionChecker internetConnectionChecker;
  AuthRepositoryImp(this.remote, this.internetConnectionChecker, this.local);


  @override
  Either<Failure, bool> isSignIn() {
    try{

      final res=local.isSignIn();
      return Right(res);
    }
        on ServerException{
      return Left(CacheFailure());
        }
  }

  @override
  Future<Either<Failure, Unit>> signIn(Map<String, dynamic> data)async {
    try{
      final res=await remote.signIn(data);
      if(res['success']){
        local.signIni(res['delivery_id']);
        return const Right(unit);
      }

      return Left(BackendFailure(res['msg']));

    }
    on ServerException{
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async{
    try{
      final res=await remote.signOut(local.getId()!);
      if(res['success']){
        local.signOut();
        return const Right(unit);
      }

      return Left(BackendFailure("something  went wrong"));

    }
    on ServerException{
      return Left(ServerFailure());
    }
    }
  }

