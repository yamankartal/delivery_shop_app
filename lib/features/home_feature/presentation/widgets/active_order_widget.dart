import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_delivery/features/delivering_feature/presentation/screens/in_shop_screen.dart';
import 'package:shop_delivery/features/delivering_feature/presentation/screens/to_shop_screen.dart';
import 'package:shop_delivery/features/home_feature/data/model/home_model.dart';

import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/enums.dart';
import '../../../../injection.dart';
import '../../../delivering_feature/presentation/bloc/delivering_bloc.dart';
import '../../../delivering_feature/presentation/screens/to_customer_screen.dart';
import '../bloc/home_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/responsive.dart';
class ActiveOrdersWidget extends StatelessWidget {
  final HomeBloc homeBloc;
  final HomeModel homeModel;
  const ActiveOrdersWidget({Key? key, required this.homeBloc, required this.homeModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Res.padding*0.6,horizontal: Res.font*0.7),
      decoration: BoxDecoration(
          color: AppColor.primaryColors,
          borderRadius: BorderRadius.circular(Res.padding)
      ),
      margin: EdgeInsets.symmetric(horizontal: Res.padding,vertical: Res.font),
      child:InkWell(
        onTap: () {
          if (homeModel.deliveryOrderStage == 0) {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => MultiBlocProvider(providers: [

                    BlocProvider(create: (_) => sl<DeliveringBloc>(), ),
                    BlocProvider.value(value: homeBloc, ),
                  ], child: ToShopScreen(orderId: homeModel.orderId!,
                  ),)
              ),
            );
          } else if (homeModel.deliveryOrderStage == 1) {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => MultiBlocProvider(providers: [

                    BlocProvider(create: (_) => sl<DeliveringBloc>(), ),
                    BlocProvider.value(value: homeBloc, ),
                  ], child: InShopScreen(
                    orderId: homeModel.orderId!,

                  ),)
              ),
            );
          } else if (homeModel.deliveryOrderStage == 2) {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => MultiBlocProvider(providers: [

                    BlocProvider(create: (_) => sl<DeliveringBloc>(), ),
                    BlocProvider.value(value: homeBloc, ),
                  ], child: ToCustomerScreen(
                    orderId: homeModel.orderId!,

                  ),)
              ),
            );
          }
        },
        child:Row(
          children: [
            Text(
              "Active Order ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Res.font * 0.9),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.white,
              size: Res.font *0.9,
            ),

          ],
        ),
      )
    );




  }
}
