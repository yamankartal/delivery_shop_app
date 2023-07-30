import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_delivery/core/constants/widgets.dart';
import 'package:shop_delivery/features/delivering_feature/presentation/screens/to_customer_screen.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../injection.dart';
import '../../../home_feature/data/model/home_model.dart';

import '../../../../core/constants/enums.dart';
import '../../../home_feature/presentation/bloc/home_bloc.dart';
import '../bloc/delivering_bloc.dart';

class InShopScreen extends StatefulWidget {

  final int orderId;




  const InShopScreen({Key? key, required this.orderId, }) : super(key: key);

  @override
  State<InShopScreen> createState() => _InShopScreenState();
}

class _InShopScreenState extends State<InShopScreen> {
  late DeliveringBloc deliveringBloc;
  late HomeBloc homeBloc;
  @override
  void initState() {
    deliveringBloc = BlocProvider.of<DeliveringBloc>(context);
    deliveringBloc.add(InShopEvent(widget.orderId));
    homeBloc = BlocProvider.of<HomeBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveringBloc, DeliveringState>(
      buildWhen: (p, c) => p.inShopState != c.inShopState,
      builder: (_, state) {
        if (state.inShopState == States.loading) {
          return Scaffold(
            body: circularProgressIndicatorWidget(),
          );
        } else if (state.inShopState == States.loaded) {
          return SafeArea(

              child: Scaffold(
                  appBar: AppBar(
                    leading: Text(""),
                    titleSpacing: -Res.font*1.5,
                    title: Text("order number : ${widget.orderId}"),
                  ),
            bottomNavigationBar: SizedBox(
                height: Res.font * 3,
                child: SlideAction(
                  borderRadius: 0,
                  outerColor: AppColor.primaryColors,
                  onSubmit: () {
                    deliveringBloc.add(LeavingShopStageEvent(widget.orderId!));
                  },
                  sliderRotate: false,
                  innerColor: AppColor.primaryColors,
                  text: "           Slide after verify items",
                  textStyle: TextStyle(
                    fontSize: Res.font * 0.9,
                    color: Colors.white,
                  ),
                  sliderButtonIcon: Row(
                    children: [
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: Res.font,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: Res.font,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: Res.font,
                      ),
                    ],
                  ),
                )),
            body: BlocConsumer<DeliveringBloc,DeliveringState>(
              listener:(_,state){
                if(state.leavingShopStageState==States.error){
                  showSnackBar(context, state.errorMsg);
                }

                else if(state.leavingShopStageState==States.loaded){
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (_) => MultiBlocProvider(providers: [

                          BlocProvider(create: (_) => sl<DeliveringBloc>(), ),
                          BlocProvider.value(value: homeBloc, ),
                        ], child: ToCustomerScreen(orderId: widget.orderId,

                        ),)
                    ),
                  );
                  homeBloc.add(GetDateEvent());
                }
              },
              builder:(_,state){
                if(state.arrivingShopStageState==States.loading){
                  return circularProgressIndicatorWidget();

                }

                return SizedBox(
                  width: Res.width,
                  height: Res.fullHeight,
                  child: Column(
                    children: [
                      SizedBox(height: Res.font,),
                      Padding(padding: EdgeInsets.symmetric(horizontal: Res.font),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("product name",style: TextStyle(fontSize: Res.font*0.9,fontWeight: FontWeight.bold),),
                            Text("product quantity",style: TextStyle(fontSize: Res.font*0.9,fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(height: Res.padding,),
                      const Divider(color: Colors.grey),
                      Expanded(
                          child: ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: Res.padding,horizontal: Res.padding),
                              itemBuilder: (_, index) => ListTile(
                                title: Text(state.inShopModel.orderItems![index].productName.toString(),style: TextStyle(
                                    fontSize: Res.font*0.9
                                ),),
                                trailing: Text(state.inShopModel.orderItems![index].cartProductQuantity.toString(),
                                  style: TextStyle(
                                      fontSize: Res.font,
                                      color: AppColor.primaryColors,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              separatorBuilder: (_, index) =>
                                  SizedBox(height: Res.padding),
                              itemCount: state.inShopModel.orderItems!.length)),
                       Padding(padding: EdgeInsets.symmetric(vertical: Res.padding,horizontal: Res.padding),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text("Amount paid : ",style: TextStyle(fontSize: Res.font,fontWeight: FontWeight.bold),),
                           Text("${state.inShopModel.orderPrice!.orderPrice} \$",style: TextStyle(color: AppColor.primaryColors,fontWeight: FontWeight.bold,fontSize: Res.font),),
                         ],
                       ),
                       )
                    ],
                  ),
                );


              },
              listenWhen:(p,c)=>p.leavingShopStageState!=c.leavingShopStageState,
              buildWhen: (p,c)=>p.leavingShopStageState!=c.leavingShopStageState,
            )
          ));
        } else if (state.inShopState == States.error) {
          return Scaffold(
            body: errorWidget(state.errorMsg),
          );
        }

        return Container();
      },
    );
  }
}
