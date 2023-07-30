import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_delivery/core/constants/enums.dart';
import 'package:shop_delivery/features/orders_feature/presentation/bloc/orders_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/responsive.dart';
import '../../data/model/orders_model.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderModel orderModel;
  final FromScreen fromScreen;
   final OrdersBloc ordersBloc;
   final int index;
  const OrderItemWidget(
      {Key? key,
      required this.orderModel,
      this.fromScreen = FromScreen.archive, required this.ordersBloc, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime? dateTime=fromScreen==FromScreen.pending?orderModel.orderDateTime:orderModel.orderAccepteTime;
    return SizedBox(
      width: Res.width,
      child: Card(
        shadowColor: AppColor.primaryColors.withOpacity(0.3),
        elevation: Res.padding,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Res.padding)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Res.padding, horizontal: Res.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Order Number : ",
                    style: TextStyle(
                        fontSize: Res.font, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${orderModel.orderId}",
                    style: TextStyle(
                      color: AppColor.primaryColors,
                      fontWeight: FontWeight.bold,
                      fontSize: Res.font,
                    ),
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: Res.font * 0.8,
                      height: Res.tinyFont),
                  children: [
                    const TextSpan(
                        text: "receive Date :",
                        style: TextStyle(color: Colors.black45)),
                    TextSpan(
                        text: " ${dateTime!.day}/"
                            "${dateTime.month}/"
                            "${dateTime.year}\n",
                        style: const TextStyle(color: AppColor.primaryColors)),
                     TextSpan(
                        text: fromScreen==FromScreen.pending?"receive time : ":"Accepting time : ",
                        style: TextStyle(color: Colors.black45)),
                    TextSpan(
                      text:
                      "${dateTime!.hour >= 10 ?dateTime!.hour : "0${dateTime!.hour}"}:"
                          "${dateTime!.minute >= 10 ? dateTime!.minute : "0${dateTime!.minute}"}"
                          "\n",
                      style: const TextStyle(color: AppColor.primaryColors),
                    ),
                    const TextSpan(
                        text: "order distance : ",
                        style: TextStyle(color: Colors.black45)),
                    TextSpan(
                      text:"${orderModel.orderDistance} Km \n",
                      style: const TextStyle(color: AppColor.primaryColors),
                    ),
                    const TextSpan(
                        text: "kilometer earning : ",
                        style: TextStyle(color: Colors.black45)),
                    TextSpan(
                      text:"${orderModel.deliveryKilometerEarning} \$",
                      style: const TextStyle(color: AppColor.primaryColors),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    "order earning : ",
                    style: TextStyle(
                        color: Colors.black45,
                        height: fromScreen == FromScreen.pending
                            ? 0
                            : Res.tinyFont * 0.9),
                  ),
                  Text("${orderModel.deliveryEarning!.roundToDouble()} \$",
                      style: TextStyle(
                          color: AppColor.primaryColors,
                          height: fromScreen == FromScreen.pending
                              ? 0
                              : Res.tinyFont)),
                  const Spacer(),
                  if (fromScreen == FromScreen.pending)
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Res.padding * 0.5)),
                      color: AppColor.primaryColors,
                      onPressed: () {

                        ordersBloc.add(AccepteOrderEvent(index,DateTime.now()));
                      },
                      child: const Text(
                        "Accepte",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
