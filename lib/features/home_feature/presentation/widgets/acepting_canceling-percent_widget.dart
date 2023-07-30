import 'package:flutter/material.dart';
import 'package:shop_delivery/features/home_feature/data/model/home_model.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/responsive.dart';

class AcceptingCancelingPercentWidget extends StatelessWidget {
  final HomeModel homeModel;

  const AcceptingCancelingPercentWidget({Key? key, required this.homeModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Res.padding),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Res.padding * 0.7)),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Res.padding * 0.7),
              border: Border.all(color: Colors.grey.withOpacity(0.3))),
          padding: EdgeInsets.symmetric(
            vertical: Res.font * 0.9,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "Accepting",
                    style:
                        TextStyle(color: Colors.grey, fontSize: Res.font * 0.7),
                  ),
                  Text(
                    "${homeModel.deliveryAcceptingPercent}%",
                    style: TextStyle(
                        color: AppColor.primaryColors,
                        fontWeight: FontWeight.bold,
                        fontSize: Res.font * 0.8,
                        height: Res.tinyFont * 0.7),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: Res.font * 1.5),
                height: Res.padding,
                width: Res.width * 0.5,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(Res.padding)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColor.primaryColors,
                          borderRadius: BorderRadius.circular(Res.padding)),
                      width: calculatePerecent(
                          homeModel.deliveryAcceptingPercent!),
                      height: Res.font,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    "Canceling",
                    style:
                        TextStyle(color: Colors.grey, fontSize: Res.font * 0.7),
                  ),
                  Text(
                    "${homeModel.deliveryCancelingPercent}%",
                    style: TextStyle(
                        color: AppColor.primaryColors,
                        fontWeight: FontWeight.bold,
                        fontSize: Res.font * 0.8,
                        height: Res.tinyFont * 0.7),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
