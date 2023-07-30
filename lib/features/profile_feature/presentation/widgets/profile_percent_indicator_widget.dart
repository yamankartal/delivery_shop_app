import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/constants.dart';
import '../../data/model/profile_model.dart';

class ProfilePercentIndicatorWidget extends StatelessWidget {

  final ProfileModel profileModel;
  const ProfilePercentIndicatorWidget({Key? key, required this.profileModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: Res.width,
       height: Res.height*0.41,
      margin: EdgeInsets.only(top: Res.padding),
      child:Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Res.padding)),
          elevation: Res.padding,
          child:Padding(
            padding: EdgeInsets.symmetric(vertical:Res.font*0.8),
            child: Column(
              children: [
                CircularPercentIndicator(
                  radius: Res.height * 0.12,
                  lineWidth: Res.padding * 0.9,
                  percent: (profileModel.deliveryOrdersCount! %
                      profileModel.ordersRewardNumber!) /
                      10,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (profileModel.deliveryOrdersCount! %
                            profileModel.ordersRewardNumber!)
                            .toString(),
                        style: TextStyle(
                            fontSize: Res.font,
                            fontWeight: FontWeight.bold,
                            height: Res.tinyFont * 0.8,
                            color: AppColor.primaryColors),
                      ),
                      Text(
                        "orders",
                        style: TextStyle(
                            fontSize: Res.font * 0.8,
                            height: Res.tinyFont * 0.8),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  progressColor: AppColor.primaryColors,
                ),
                Text("complete ${profileModel.ordersRewardNumber! - profileModel.deliveryOrdersCount! % 10} orders to earn ",
                  style: TextStyle(
                    fontSize: Res.font, fontWeight: FontWeight.bold,height: Res.tinyFont*0.8),
                ),

                    Text(
                      "${profileModel.deliveryReward} \$  ",
                      style: TextStyle(
                          height: Res.tinyFont * 0.7,
                          fontWeight: FontWeight.bold,
                          fontSize: Res.font,
                          color: AppColor.primaryColors),
                    ),
              ],
            ),
          )
      ),
    );
  }
}
