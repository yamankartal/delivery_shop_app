import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_delivery/core/constants/responsive.dart';

import 'colors.dart';
import 'constants.dart';


Widget circularProgressIndicatorWidget(){
  return const Center(child: CircularProgressIndicator(
    color: AppColor.primaryColors,
  ));
}




Widget errorWidget(String errorMsg){
  return  Center(child:Text(
      errorMsg,

  ));
}


showSnackBar(context,text,[ tex2]){
  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      duration: Duration(seconds: 2),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Res.padding)
      ),
      backgroundColor: Colors.black87.withOpacity(0.8),
      margin: EdgeInsets.symmetric(horizontal: Res.font,vertical: Res.font),
      behavior: SnackBarBehavior.floating,
      content:Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Res.padding),
        ),
        child:
        tex2==null?
        Text(text,textAlign: TextAlign.center,style:TextStyle(fontSize:Res.font*0.7),):
        Column(
          children: [
            Text(text),
            Text(tex2),
          ],
        ),
      )));
}

