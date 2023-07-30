import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_delivery/features/home_page_feature/presentation/bloc/home_page_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/responsive.dart';

class BottomNavigationBarItemWidget extends StatelessWidget {

  final HomePageBloc homePageBloc;
  final int index;
  final String label;
  final IconData iconData;
  const BottomNavigationBarItemWidget({Key? key, required this.homePageBloc, required this.index, required this.label, required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomePageBloc,HomePageState>(builder:(_,state)=>
        InkWell(
          borderRadius: BorderRadius.circular(Res.font),
          onTap: (){
            homePageBloc.add(ChangeScreenIndex(index));
          },
          child:  Column(
            children: [
              Icon(iconData,color:state.homeScreenIndex==index?AppColor.primaryColors:Colors.black54,size:Res.font*1.2,),
              Text(label,style: TextStyle(fontSize:Res.font*0.7,color:state.homeScreenIndex==index?AppColor.primaryColors:Colors.black54),)
            ],
          ),
        )
    );
  }
}
