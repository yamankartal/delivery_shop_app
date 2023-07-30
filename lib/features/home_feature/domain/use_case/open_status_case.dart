import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/home_feature/data/model/home_model.dart';
import 'package:shop_delivery/features/home_feature/domain/use_case/home_use_case.dart';

import '../repository/repository.dart';

class OpenStatusCase extends HomeUseCase<Unit,OpenStatusParam>{
  final HomeRepository repository;
  OpenStatusCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(OpenStatusParam param)async{
    return await repository.openStatus();
  }

}


class OpenStatusParam{}