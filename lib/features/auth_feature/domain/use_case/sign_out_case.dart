import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/auth_feature/domain/repository/repository.dart';
import 'package:shop_delivery/features/auth_feature/domain/use_case/auth_use_case.dart';

class SignOutCase extends AuthUseCase<Unit,ParamSignOut>{
  final AuthRepository repository;
  SignOutCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ParamSignOut param)async{
    return await repository.signOut();
  }

}

class ParamSignOut{

}