import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/auth_feature/domain/repository/repository.dart';
import 'package:shop_delivery/features/auth_feature/domain/use_case/auth_use_case.dart';

class IsSignInCase extends AuthUseCase<bool,ParamIsSignIn>{
  final AuthRepository repository;
  IsSignInCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(ParamIsSignIn param){
    return  Future.value(repository.isSignIn());
  }

}

class ParamIsSignIn{



}