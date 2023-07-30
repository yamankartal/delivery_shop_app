import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_delivery/core/constants/fuctions.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/convert.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/widgets.dart';
import '../bloc/home_bloc.dart';

class HomeTitleWidget extends StatelessWidget {
  final HomeBloc homeBloc;

  const HomeTitleWidget({Key? key, required this.homeBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocConsumer<HomeBloc,HomeState>(
          bloc: homeBloc,
          listenWhen: (p,c)=>p.openStatus!=c.openStatus||p.closeStatus!=c.closeStatus,
          listener: (_,state){
            if(state.closeStatus==States.error||state.openStatus==States.error){
              showSnackBar(context, state.errorMsg);
            }
            if(state.openStatus==States.loaded){
              showSnackBar(context,"status has been activate successfully");
            }
            if(state.closeStatus==States.loaded){
              showSnackBar(context,"status has been turn off");
            }

          },
          buildWhen: (p,c)=>p.openStatus!=c.openStatus||p.closeStatus!=c.closeStatus,
          builder:(_,state){
            return  Expanded(
                child: Row(
                  children: [
                    Switch(
                        inactiveTrackColor: Colors.grey[300],
                        activeColor:AppColor.primaryColors,
                        activeTrackColor:AppColor.primaryColors,
                        inactiveThumbColor: Colors.grey[400],
                        value:state.homeModel.deliveryStatus==-1?false:true,
                        onChanged: (val){
                         changeStatus(homeBloc, val, state.homeModel, context);
                        }
                    ),
                    Text(convertIntoDeliveryStatus(state.homeModel.deliveryStatus!),style:TextStyle(color:state.homeModel.deliveryStatus==-1?Colors.grey:AppColor.primaryColors,fontSize:Res.font*0.7),),
                  ],
                )
            );
          },),
        Text("BEE",style:Theme.of(context).textTheme.bodyText1,),
        Text("DRIVER",style:Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColor.primaryColors),),
      ],
    );
  }
}
