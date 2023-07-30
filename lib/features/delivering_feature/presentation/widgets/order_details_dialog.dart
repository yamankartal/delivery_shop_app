import 'package:flutter/material.dart';
import 'package:shop_delivery/features/delivering_feature/presentation/bloc/delivering_bloc.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/convert.dart';
import '../../../../core/constants/responsive.dart';
import '../../data/model/to_customer_model.dart';

class OrderDetailsDialog extends StatelessWidget {
  final ToCustomerModel toCustomerModel;
  final DeliveringBloc deliveringBloc;
  final int orderId;
  const OrderDetailsDialog({Key? key, required this.toCustomerModel, required this.deliveringBloc, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(

      child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              width: Res.width,
              height: Res.font*2,
              color: AppColor.primaryColors,
              child: Text("Order details",style: TextStyle(color: Colors.white,fontSize: Res.font),),
            ),
            DefaultTextStyle(style:TextStyle(color:Colors.black,fontSize: Res.font,height: Res.tinyFont), child:Column(
              children: [
               Padding(padding: EdgeInsets.all(Res.font),
               child: Column(
                 children: [

                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("City : "),
                       Text(toCustomerModel.addressDetails!,style: TextStyle(color: AppColor.primaryColors,fontSize: Res.font),)
                     ],
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("street : "),
                       Text(toCustomerModel.addressStreet!,style: TextStyle(color: AppColor.primaryColors,fontSize: Res.font),)
                     ],
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("floor : "),
                       Text(toCustomerModel.addressFloor!,style: TextStyle(color: AppColor.primaryColors,fontSize: Res.font),)
                     ],
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("phone : "),
                       Text(toCustomerModel.addressPhone.toString(),style: TextStyle(color: AppColor.primaryColors,fontSize: Res.font),)
                     ],
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("pay methode : "),
                       Text(convertIntoPaymentMethode(toCustomerModel.orderPaymentMethode!),style: TextStyle(color: AppColor.primaryColors,fontSize: Res.font),)
                     ],
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Details : "),
                       Text(toCustomerModel.addressDetails!,style: TextStyle(color: AppColor.primaryColors,fontSize: Res.font),)
                     ],
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Received : "),
                       Text(toCustomerModel.orderPaymentMethode==1?"0 \$":"${toCustomerModel.orderTotalPrice!.roundToDouble()} \$",style: TextStyle(color: AppColor.primaryColors,fontSize: Res.font),)
                     ],
                   ),
                 ],
               )
               )
              ],
            )),



           SlideAction(
                  height: Res.font*2.5,

                  borderRadius:0,
                  outerColor: AppColor.primaryColors,
                  onSubmit: () {
                    deliveringBloc.add(DoneStageEvent(
                        orderId,DateTime.now()));
                  },
                  sliderRotate: false,
                  innerColor: AppColor.primaryColors,
                  text: "             Done delivery",
                  textStyle: TextStyle(
                    fontSize: Res.font ,
                    color: Colors.white,
                  ),
                  sliderButtonIcon: Row(
                    children: [
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: Res.font*0.8,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: Res.font*0.8,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: Res.font*0.8,
                      ),
                    ],
                  ),
                ),
          ],
        ),
    );
  }
}
