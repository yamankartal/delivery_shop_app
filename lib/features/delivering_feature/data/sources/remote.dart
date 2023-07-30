import 'dart:convert';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shop_delivery/core/constants/failures.dart';

import '../../../../core/constants/backend_url.dart';
import '../../../../core/constants/colors.dart';
import '../model/in_shop_model.dart';
import '../model/to_customer_model.dart';
import '../model/to_shop_model.dart';

class DeliveringRemote{

  Future<ToShopModel?>toShop(int deliveryId)async{
    try{
      final response=await http.post(Uri.parse(toShopLink),body: {"delivery_id":deliveryId.toString()});
      if(response.statusCode==200){

        final res=jsonDecode(response.body);
        if(res['success']){
          final Map<String,dynamic>map=res['to_shop'];
          return ToShopModel.fromJson(map);
        }


        return null;


      }

      throw ServerFailure();
    }
        catch(e){
      throw ServerFailure();
        }



  }

  Future<InShopModel?>inShop(int orderId)async{
    try{
      final response=await http.post(Uri.parse(inShopLink),body: {"order_id":orderId.toString()});
      if(response.statusCode==200){

        final res=jsonDecode(response.body);
        if(res['success']){
          final Map<String,dynamic>map=res['in_shop'];
          return InShopModel.fromJson(map);
        }


        return null;


      }

      throw ServerFailure();
    }
        catch(e){
      throw ServerFailure();
        }



  }

  Future<ToCustomerModel?>toCustomer(int orderId)async{
    try{
      final response=await http.post(Uri.parse(toCustomerLink),body: {"order_id":orderId.toString()});
      if(response.statusCode==200){

        final res=jsonDecode(response.body);
        if(res['success']){
          final Map<String,dynamic>map=res['to_customer'];
          return ToCustomerModel.fromJson(map);
        }


        return null;


      }

      throw ServerFailure();
    }
        catch(e){
      throw ServerFailure();
        }



  }

  Future<bool>arrivingToShopStage(int deliveryId)async{
    try{
      final response=await http.post(Uri.parse(arriveToShopStageLink),body: {"delivery_id":deliveryId.toString()});
      if(response.statusCode==200){
        final res=jsonDecode(response.body);
         return res['success'];
      }

      throw ServerFailure();
    }
    catch(e){
      throw ServerFailure();
    }
  }

  Future<bool>leavingShopStage(int deliveryId,int orderId)async{
    try{
      final response=await http.post(Uri.parse(leaveShopStageLink),body: {"delivery_id":deliveryId.toString(),"order_id":orderId.toString()});
      if(response.statusCode==200){
        final res=jsonDecode(response.body);
        return res['success'];
      }

      throw ServerFailure();
    }
    catch(e){
      throw ServerFailure();
    }
  }

  Future<bool>doneOrderStage(int deliveryId,int orderId,Map<String,dynamic>data)async{
    try{
      final response=await http.post(Uri.parse(doneOrderStageLink),body: data..addAll({"delivery_id":deliveryId.toString(),"order_id":orderId.toString()}));
      if(response.statusCode==200){
        final res=jsonDecode(response.body);
         return res['success'];
      }

      throw ServerFailure();
    }
    catch(e){
     rethrow;
    }
  }

  Future<Position>getCurrentLocation()async{
    try{
      final Position position= await Geolocator.getCurrentPosition();
      return position;
    }
        catch(e){
      throw ServerFailure();
        }
  }

  Future<void>updateLocation(Map<String, dynamic> data,int deliveryId)async{
    try{
      final res=await http.post(Uri.parse(updateLocationLink),body:data..addAll({'delivery_id':deliveryId.toString()}));
      if(res.statusCode!=200){
        throw ServerFailure();
      }
    }
        catch(e){
      throw ServerFailure();
        }
  }





  Future<Set<Polyline>>decodePolyline(Map<String,dynamic>data)async {

    final lat=data['lat'];
    final long=data['long'];
    final destLat=data['dest_lat'];
    final destLong=data['dest_long'];

    Set<Polyline>polyLines={};
    List<LatLng>polyLineCo=[];
    PolylinePoints polylinePoints=PolylinePoints();

    String googleMapLink = "https://maps.googleapis.com/maps/api/directions/json?origin=$lat,$long&destination=$destLat,$destLong&key=AIzaSyCF2yprt_fS2tkMSiJr0LxOlAjERb4Qb0E";

    print(googleMapLink);

    final response = await http.post(Uri.parse(googleMapLink));
    final res = jsonDecode(response.body);

    if (res['status'] == 'OK') {
      final point = res['routes'][0]['overview_polyline']['points'];
      final distance = res['routes'][0]['legs'][0]['distance']['text'];
      print("###################################");
      print(res);
      List<PointLatLng> result = polylinePoints.decodePolyline(point);
      if (result.isNotEmpty) {
        for (var element in result) {
          polyLineCo.add(LatLng(element.latitude, element.longitude));
        }
      }
      Polyline polyline = Polyline(polylineId: const PolylineId("polyline"),
          color: AppColor.primaryColors,
          width: 5,
          points: polyLineCo);
      polyLines.add(polyline);
       print("not empty");
      return polyLines;
    }
    else{
      print("empty");
      return {};
    }
  }





}