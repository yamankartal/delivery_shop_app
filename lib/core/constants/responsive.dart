
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter/material.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:shop_delivery/features/home_feature/presentation/bloc/home_bloc.dart';
import 'package:shop_delivery/features/home_feature/presentation/screens/home_screen.dart';


import '../../features/orders_feature/presentation/bloc/orders_bloc.dart';
import '../../features/orders_feature/presentation/screens/archives_orders_screen.dart';
import '../../features/orders_feature/presentation/screens/pending_orders_screen.dart';
import '../../features/profile_feature/presentation/bloc/profile_bloc.dart';
import '../../features/profile_feature/presentation/screens/profile_screen.dart';
import '../../injection.dart';
import 'enums.dart';


class Res{
  static double width=0;
  static double height=0;
  static double fullHeight=0;
  static double get font=>width*0.06;
  static double get  padding=>font/2;
  static double get  tinyFont=>font*0.1;
  static double get  tinyPadding=>padding*0.1;
}

void responsive(context){
  Res.width = MediaQuery.of(context).size.width;
  Res.fullHeight = MediaQuery.of(context).size.height;
  Res.height = Res.fullHeight -
      AppBar().preferredSize.height -
      MediaQuery.of(context).padding.top;
}



