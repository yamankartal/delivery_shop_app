import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_delivery/core/constants/backend_url.dart';
import 'package:shop_delivery/core/constants/failures.dart';

import '../model/profile_model.dart';

class ProfileRemote{

 Future<ProfileModel?> getProfile(int deliveryId)async{
   print(0);
   final response=await http.post(Uri.parse(getProfileLink),body:{"delivery_id":deliveryId.toString()});
    if(response.statusCode==200){
      final res=jsonDecode(response.body);
      if(res['success']){
        print(res);
        final Map<String,dynamic> map=res['profile'];
        return ProfileModel.fromJson(map);
      }

      return null;
    }

    throw ServerFailure();
  }

}