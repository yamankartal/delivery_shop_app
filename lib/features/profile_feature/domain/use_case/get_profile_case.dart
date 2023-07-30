import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/profile_feature/domain/use_case/use_case.dart';

import '../../data/model/profile_model.dart';
import '../repository/repository.dart';

class GetProfileCase extends ProfileUseCase<ProfileModel,ParamGetProfile>{

  final ProfileRepository repository;
  GetProfileCase(this.repository);

  @override
  Future<Either<Failure, ProfileModel>> call(ParamGetProfile param)async{
    return await repository.getProfile();
  }

}



class ParamGetProfile{

}