
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:shop_delivery/core/constants/constants.dart';

import '../../features/orders_feature/presentation/bloc/orders_bloc.dart';
import 'enums.dart';

listenToNotification(final OrdersBloc ordersBloc){


  FirebaseMessaging.onMessage.listen((event) {
    print("###################################");

    final Map map=event.data;
    if(map['pagename']=="pending" && screen==Screen.pending){
      print("not");
      final body=jsonDecode(map['body']);
      ordersBloc.add(RefreshPendingOrdersEvent(int.parse(body['order_id']),));
    }
   else if(map['pagename']=="archived" && screen==Screen.archive){
      ordersBloc.add(GetArchivedOrdersEvent());
    }
   else if(map['pagename']=="tracking"){
     print("yesk");
    }
   else{
      FlutterRingtonePlayer.playNotification(volume:3);
    }



  });
}




initFireBaseMessaging()async{
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );
}





