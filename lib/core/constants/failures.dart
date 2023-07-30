import 'package:dartz/dartz.dart';

abstract class Failure{}

class ServerFailure extends Failure{}
class CacheFailure extends Failure{}
class ConnectionFailure extends Failure{}
class EmptyCacheFailure extends Failure{}
class BackendFailure extends Failure{
  final String errorMsg;
  BackendFailure(this.errorMsg);
}





