import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/delivering_feature/domain/repository/repository.dart';
import 'package:shop_delivery/features/delivering_feature/domain/use_case/use_case.dart';

class GetPolyLineCase extends DeliveringUseCase<Set<Polyline>,ParamGetPolyLine>{

  final DeliveringRepository repository;
  GetPolyLineCase(this.repository);

  @override
  Future<Either<Failure, Set<Polyline>>> call(ParamGetPolyLine param)async{
    return await repository.getPolyLine(param.data);
  }

}





class ParamGetPolyLine {
  final double lat;
  final double long;
  final double destLat;
  final double destLong;

  ParamGetPolyLine({required this.lat, required this.long, required this.destLat, required this.destLong});
  Map<String,dynamic>get data{

    return {
      'lat':lat.toString(),
      'long':lat.toString(),
      'dest_lat':lat.toString(),
      'dest_long':lat.toString(),
    };
  }

}
