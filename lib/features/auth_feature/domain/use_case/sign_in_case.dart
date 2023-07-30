import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/auth_feature/domain/repository/repository.dart';
import 'package:shop_delivery/features/auth_feature/domain/use_case/auth_use_case.dart';

class SignInCase extends AuthUseCase<Unit,ParamSignIn>{
  final AuthRepository repository;
  SignInCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ParamSignIn param)async{
    return await repository.signIn(param.data);
  }

}

class ParamSignIn{

  final String verifyCode;
  ParamSignIn(this.verifyCode);

  Map<String,dynamic>get data{
    return {
      "delivery_verify_code":verifyCode.toString()
    };
  }

}