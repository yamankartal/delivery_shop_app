import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_delivery/features/auth_feature/presentation/bloc/auth_bloc.dart';
import 'package:shop_delivery/features/orders_feature/presentation/bloc/orders_bloc.dart';
import 'package:shop_delivery/features/splash_feature/screens/splash_screen.dart';

import '../../../../features/home_page_feature/presentation/bloc/home_page_bloc.dart';
import '../../../../features/home_page_feature/presentation/screens/home_page.dart';
import '../../../../injection.dart';
import '../../../constants/colors.dart';
import '../../../constants/constants.dart';
import '../../../constants/responsive.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OrdersBloc>(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: AppColor.primaryColors,
              titleTextStyle: TextStyle(fontSize: Res.font)),
          primaryColor: AppColor.primaryColors,
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: Res.font,
              color: Colors.black,
              fontWeight: FontWeight.normal
            ),
            bodyText2: TextStyle(fontSize: Res.font * 0.8, color: Colors.black),
          ),
        ),
        home: BlocProvider(
          create: (_)=>sl<AuthBloc>(),
          child:const SplashScreen()
        ),
      ),
    );
  }
}
