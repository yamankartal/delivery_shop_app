import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/exceptions.dart';

import 'package:shop_delivery/core/constants/failures.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shop_delivery/features/auth_feature/data/sources/local.dart';
import 'package:shop_delivery/features/orders_feature/data/model/orders_model.dart';

import '../../domain/repository/repository.dart';
import '../sources/remote.dart';

class OrdersRepositoryImp extends OrdersRepository{
  final OrdersRemote remote;
  final InternetConnectionChecker internetConnectionChecker;
  final AuthLocal local;
  OrdersRepositoryImp(this.remote, this.internetConnectionChecker, this.local);

  @override
  Future<Either<Failure, List<OrderModel>>> getArchivedOrders()async{
    if(await internetConnectionChecker.hasConnection){
      try{
          final res=await remote.getArchivedOrders(local.getId()!);
          return res.isEmpty?Left(BackendFailure("No Data found")):Right(res);
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
  Future<Either<Failure, Unit>> accepteOrder(int orderId,final Map<String,dynamic>data) async{
    if(await internetConnectionChecker.hasConnection){
      try{
        final res=await remote.accepteOrder(local.getId()!,orderId,data);
        return res['success']==false?Left(BackendFailure(res['msg'])):const Right(unit);
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
  Future<Either<Failure, List<OrderModel>>> getPendingOrders()async {
    if(await internetConnectionChecker.hasConnection){
      try{
        final res=await remote.getPendingOrders(local.getId()!);
        if(res['success']){
          final List list=res['pending_orders'];
          return Right(list.map((e) => OrderModel.fromJson(e)).toList());
        }
        return Left(BackendFailure(res['msg']));
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