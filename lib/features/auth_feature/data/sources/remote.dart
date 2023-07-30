import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_delivery/core/constants/failures.dart';

import '../../../../core/constants/backend_url.dart';

class AuthRemote{

  Future<Map>signIn(Map<String, dynamic> data)async{
    try{
      final response =await http.post(Uri.parse(signInLink),body:data);
      if(response.statusCode==200){
        final res=jsonDecode(response.body);
        return res;
      }


      throw ServerFailure();
    }
        catch(e){
      throw ServerFailure();
        }
  }


  Future<Map>signOut(int deliveryId)async{
    try{
      final response =await http.post(Uri.parse(signOutLink),body: {'delivery_id':deliveryId.toString()});
      if(response.statusCode==200){
        final res=jsonDecode(response.body);
        return res;
      }


      throw ServerFailure();
    }
    catch(e){
      throw ServerFailure();
    }
  }

}