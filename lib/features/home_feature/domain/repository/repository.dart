import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/model/home_model.dart';

abstract class HomeRepository{
  Future<Either<Failure,HomeModel>>getData();
  Future<Either<Failure,Unit>>openStatus();
  Future<Either<Failure,Unit>>closeStatus();
  Future<Either<Failure,Position>>getPosition();
}