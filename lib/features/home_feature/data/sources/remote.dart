import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shop_delivery/core/constants/backend_url.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/auth_feature/data/sources/local.dart';
import 'package:shop_delivery/features/home_feature/data/model/home_model.dart';


class HomeRemote{

  final AuthLocal local;

  HomeRemote(this.local);



  Future<bool> closeStatus(int deliveryId)async{
    try{
      final response=await http.post(Uri.parse(closeStatusLink),body:{"delivery_id":deliveryId.toString()});
      if(response.statusCode==200){
        final res=jsonDecode(response.body);
        if(res['success']){
          return true;
        }
        return false;
      }


      throw ServerFailure();
    }
    catch(e){
      throw ServerFailure();
    }
  }

  Future<HomeModel?> getData(int deliveryId)async{
    try{

      final response=await http.post(Uri.parse(getHomeLink),body:{"delivery_id":deliveryId.toString()});
      if(response.statusCode==200){
        final res=jsonDecode(response.body);
        if(res['success']){
           final Map<String,dynamic> jsonMap=res['delivery'];
           return HomeModel.fromJson(jsonMap);
        }
        return null;
      }


      throw ServerFailure();
    }
    catch(e){
      rethrow;
    }
  }

  Future<Position> getPosition()async{
    try{
      final  Position position= await Geolocator.getCurrentPosition();
      return position;
    }
    catch(e){
      throw ServerFailure();
    }
  }

  Future<bool> openStatus(int deliveryId)async{
    try{
      final response=await http.post(Uri.parse(openStatusLink),body:{"delivery_id":deliveryId.toString()});
      if(response.statusCode==200){
        final res=jsonDecode(response.body);
        if(res['success']){
          return true;
        }
        return false;
      }


      throw ServerFailure();
    }
    catch(e){
      throw ServerFailure();
    }
  }

}