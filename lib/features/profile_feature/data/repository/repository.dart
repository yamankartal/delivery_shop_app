import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shop_delivery/core/constants/exceptions.dart';

import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/auth_feature/data/sources/local.dart';

import 'package:shop_delivery/features/profile_feature/data/model/profile_model.dart';

import '../../domain/repository/repository.dart';
import '../sources/remote.dart';

class ProfileRepositoryImp extends ProfileRepository{
  final InternetConnectionChecker internetConnectionChecker;
  final AuthLocal local;
  final ProfileRemote remote;

  ProfileRepositoryImp(this.internetConnectionChecker, this.local, this.remote);
  @override
  Future<Either<Failure, ProfileModel>> getProfile()async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        print(0);
          final res=await remote.getProfile(local.getId()!);
          return res==null?Left(BackendFailure("something went wrong, try again later")):Right(res);
      }
      on ServerException {
        return Left(ServerFailure());
      }
    }


    else{
      return Left(ConnectionFailure());
    }
  }

}