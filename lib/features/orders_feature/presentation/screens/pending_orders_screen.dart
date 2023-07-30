import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/widgets.dart';
import '../bloc/orders_bloc.dart';
import '../widgets/order_item_widget.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/responsive.dart';
class PendingOrdersScreen extends StatefulWidget {
  const PendingOrdersScreen({Key? key}) : super(key: key);

  @override
  State<PendingOrdersScreen> createState() => _PendingOrdersScreenState();
}

class _PendingOrdersScreenState extends State<PendingOrdersScreen> {
  late OrdersBloc ordersBloc;

  @override
  void initState() {
    screen=Screen.pending;
    ordersBloc = BlocProvider.of<OrdersBloc>(context);
    ordersBloc.add(GetPendingOrdersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
        buildWhen: (p, c) =>
        p.getPendingOrdersState != c.getPendingOrdersState,
        builder: (_, state) {
          if (state.getPendingOrdersState == States.loading) {
            return circularProgressIndicatorWidget();
          } else if (state.getPendingOrdersState == States.loaded) {
            return  BlocConsumer<OrdersBloc,OrdersState>(
                buildWhen: (p,c)=>p.accepteOrderState!=c.accepteOrderState,
                listenWhen: (p,c)=>p.accepteOrderState!=c.accepteOrderState,
                builder: (_,state){
              if(state.accepteOrderState==States.loading){
                return circularProgressIndicatorWidget();
              }
              return BlocBuilder<OrdersBloc,OrdersState>(
                  buildWhen: (p,c)=>p.orders!=c.orders,
                  builder: (_,state){
               return Container(
                  margin: EdgeInsets.only(top: Res.height*0.075),
                  width: Res.width,
                  height: Res.height,
                  child: Column(
                    children: [
                      Text("Pending",style: TextStyle(color: AppColor.primaryColors,fontSize: Res.font*1.2,fontWeight: FontWeight.bold),),
                      SizedBox(
                        height: Res.height*0.9,
                        child:ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: Res.font*0.6,horizontal: Res.font*0.6),
                            itemBuilder: (_, index) => OrderItemWidget(
                              index: index,
                              ordersBloc: ordersBloc,
                              fromScreen: FromScreen.pending,
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
              });

            }, listener: (_,state){
                  if(state.accepteOrderState==States.error){
                    showSnackBar(context, state.errorMsg);
                  }
            });
          } else if (state.getPendingOrdersState == States.error) {
            return errorWidget(state.errorMsg);
          }

          return Container();
        });
  }
}
