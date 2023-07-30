import 'package:dartz/dartz.dart';

import '../../../../core/constants/failures.dart';

abstract class AuthRepository{
  Future<Either<Failure,Unit>>signIn(Map<String,dynamic>data);
  Future<Either<Failure,Unit>>signOut();
  Either<Failure,bool>isSignIn();
}
