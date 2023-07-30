import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/failures.dart';

abstract class HomeUseCase<Type,Param>{
  Future<Either<Failure,Type>>call(Param param);
}