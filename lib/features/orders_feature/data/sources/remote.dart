
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_delivery/core/constants/backend_url.dart';
import 'package:shop_delivery/core/constants/failures.dart';

import '../model/orders_model.dart';
class OrdersRemote{


  Future<List<OrderModel>>getArchivedOrders(int deliveryId)async{
    try{
      final response=await http.post(Uri.parse(getArchivesOrdersLink),body: {"delivery_id":deliveryId.toString()});
      if(response.statusCode==200){
        final res=jsonDecode(response.body);
        if(res['success']){
          final List list=res['archived_orders'];
          return list.map((e) =>OrderModel.fromJson(e)).toList();
        }
        return [];
      }



      throw ServerFailure();
    }
        catch(e){
      throw ServerFailure();
        }

  }

  Future<Map>getPendingOrders(int deliveryId)async {
    try {
      final response = await http.post(Uri.parse(getPendingOrdersLink),
          body: {'delivery_id': deliveryId.toString()});
      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        return res;
      }
    throw ServerFailure();
  }
    catch(e){
      throw ServerFailure();
    }

  }


  Future<Map>accepteOrder(int deliveryId,int orderId,final Map<String,dynamic>data)async{
    try{
      final response=await http.post(Uri.parse(accepteOrderLink),body: data..addAll({"delivery_id":deliveryId.toString(),"order_id":orderId.toString()}));
      if(response.statusCode==200){
        final res=jsonDecode(response.body);
        return res;
      }
      throw ServerFailure();
    }
    catch(e){
      rethrow;
    }
  }

}