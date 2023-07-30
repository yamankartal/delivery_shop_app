import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/home_feature/data/model/home_model.dart';
import 'package:shop_delivery/features/home_feature/domain/use_case/home_use_case.dart';

import '../repository/repository.dart';

class CloseStatusCase extends HomeUseCase<Unit,CloseStatusParam>{
  final HomeRepository repository;
  CloseStatusCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(CloseStatusParam param)async{
    return await repository.closeStatus();
  }

}


class CloseStatusParam{}