import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/constants.dart';
import '../../data/model/profile_model.dart';

class AcceptingCancelingPercentProfileWidget extends StatelessWidget {
  final ProfileModel profileModel;

  const AcceptingCancelingPercentProfileWidget({Key? key, required this.profileModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: Res.padding),
      child: Card(
        elevation: Res.padding,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Res.padding,
            vertical: Res.font
          ),
          child:Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Accepting percent",style: TextStyle(color: AppColor.primaryColors,fontSize: Res.font*0.9,fontWeight: FontWeight.bold),),
                  Text("${profileModel.deliveryAcceptingPercent}%",style: TextStyle(color: AppColor.primaryColors,fontWeight: FontWeight.bold,fontSize: Res.font*0.9),),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: Res.padding*0.7),
                width: Res.width * 0.9,
                height: Res.padding*0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Res.padding),
                    color: Colors.grey[200]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Res.padding*0.9,
                      width: Res.width *
                          0.9 *
                          profileModel.deliveryAcceptingPercent!/100,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(Res.padding),
                        color: AppColor.primaryColors.withOpacity(0.9),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                "Affected by number of orders accepted or ignored",
                style:TextStyle(fontSize: Res.font*0.6,height: Res.tinyFont*0.8,color: Colors.black54),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Canceling percent",style: TextStyle(color: AppColor.primaryColors,fontSize: Res.font*0.9,fontWeight: FontWeight.bold,height: Res.tinyFont),),
                  Text("${profileModel.deliveryCancelingPercent}%",style: TextStyle(color: AppColor.primaryColors,fontWeight: FontWeight.bold,fontSize: Res.font*0.9,height: Res.tinyFont),),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: Res.padding*0.7),
                width: Res.width * 0.9,
                height: Res.padding*0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Res.padding),
                    color: Colors.grey[200]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Res.padding*0.9,
                      width: Res.width *
                          0.9 *
                          profileModel.deliveryCancelingPercent!/100,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(Res.padding),
                        color: AppColor.primaryColors.withOpacity(0.9),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                "Affected by number of orders canceled after accepte",
                style:TextStyle(fontSize: Res.font*0.55,height: Res.tinyFont*0.8,color: Colors.black54),
              ),
            ],
          ),
        )
      ),
    );
  }
}
