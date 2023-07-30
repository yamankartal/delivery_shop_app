import 'package:dartz/dartz.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/delivering_feature/domain/repository/repository.dart';
import 'package:shop_delivery/features/delivering_feature/domain/use_case/use_case.dart';

import '../../data/model/in_shop_model.dart';
import '../../data/model/to_shop_model.dart';

class DoneOrderStageCase extends DeliveringUseCase<Unit,ParamDoneOrderStage>{
  final DeliveringRepository repository;

  DoneOrderStageCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ParamDoneOrderStage param)async{
    return await repository.doneOrderStage(param.orderId,param.data);
  }

}


class ParamDoneOrderStage{
  final int orderId;
  final DateTime dateTime;
  ParamDoneOrderStage(this.orderId, this.dateTime);

  Map<String,dynamic>get data{
    return {'date_time':dateTime.toIso8601String()};
  }

}