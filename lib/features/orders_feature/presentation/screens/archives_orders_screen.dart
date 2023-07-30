import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_delivery/core/constants/constants.dart';

import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/widgets.dart';
import '../bloc/orders_bloc.dart';
import '../widgets/order_item_widget.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/responsive.dart';
class ArchivedOrdersScreen extends StatefulWidget {
  const ArchivedOrdersScreen({Key? key}) : super(key: key);

  @override
  State<ArchivedOrdersScreen> createState() => _ArchivedOrdersScreenState();
}

class _ArchivedOrdersScreenState extends State<ArchivedOrdersScreen> {
  late OrdersBloc ordersBloc;

  @override
  void initState() {
    screen=Screen.archive;
    ordersBloc = BlocProvider.of<OrdersBloc>(context);
    ordersBloc.add(GetArchivedOrdersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
        buildWhen: (p, c) =>
            p.getArchivedOrdersState != c.getArchivedOrdersState,
        builder: (_, state) {
          if (state.getArchivedOrdersState == States.loading) {
            return circularProgressIndicatorWidget();
          } else if (state.getArchivedOrdersState == States.loaded) {
            return Container(
              margin: EdgeInsets.only(top: Res.height*0.075),
              width: Res.width,
              height: Res.height,
              child: Column(
                children: [
                  Text("Archive",style: TextStyle(color: AppColor.primaryColors,fontSize: Res.font*1.2,fontWeight: FontWeight.bold),),
                  Container(
                    height: Res.height*0.9,
                    child:ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: Res.font*0.6,horizontal: Res.font*0.6),
                        itemBuilder: (_, index) => OrderItemWidget(
                          index: index,
                          ordersBloc: ordersBloc,
                          orderModel: state.orders[index],
                        ),
                        separatorBuilder: (_, index) => SizedBox(
                          height: Res.padding,
                        ),
                        itemCount: state.orders.length),

                  ),
                ],
              ),
            );
          } else if (state.getArchivedOrdersState == States.error) {
            return errorWidget(state.errorMsg);
          }

          return Container();
        });
  }
}
