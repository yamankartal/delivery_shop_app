import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_delivery/core/constants/widgets.dart';
import 'package:shop_delivery/features/delivering_feature/presentation/screens/in_shop_screen.dart';
import 'package:shop_delivery/features/home_feature/presentation/bloc/home_bloc.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../injection.dart';
import '../bloc/delivering_bloc.dart';

class ToShopScreen extends StatefulWidget {
  final int orderId;

  const ToShopScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<ToShopScreen> createState() => _ToShopScreenState();
}

class _ToShopScreenState extends State<ToShopScreen> {
  late DeliveringBloc deliveringBloc;
  late HomeBloc homeBloc;
  late StreamSubscription<Position>   positionStream;

  @override
  void initState() {
    positionStream= Geolocator.getPositionStream().listen((Position? position) {
      deliveringBloc.add(UpdateLocationEvent(position!.latitude, position.longitude));
    });

    deliveringBloc = BlocProvider.of<DeliveringBloc>(context);
    homeBloc = BlocProvider.of<HomeBloc>(context);
    deliveringBloc.add(ToShopEvent());
    deliveringBloc.add(GetCurrentLocationEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveringBloc, DeliveringState>(
      buildWhen: (p, c) => p.toShopState != c.toShopState,
      builder: (_, state) {
        if (state.toShopState == States.loading) {
          return Scaffold(body: circularProgressIndicatorWidget());
        } else if (state.toShopState == States.loaded) {

          return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                    leading: Text(""),
                  titleSpacing: -Res.font*1.5,
                  title: Text("order number : ${widget.orderId}"),
                ),
                body:  BlocConsumer<DeliveringBloc,DeliveringState>(
                  listenWhen: (p,c)=>p.getCurrentLocationState!=c.getCurrentLocationState,
                  listener: (_,state){
                  },
                  buildWhen: (p,c)=>p.getCurrentLocationState!=c.getCurrentLocationState,
                  builder: (_,state){
                    if(state.getCurrentLocationState==States.loading){
                      return circularProgressIndicatorWidget();
                    }


                    else if(state.getCurrentLocationState==States.loaded) {
                        deliveringBloc.add(GetPolyLineEvent(state.position!.latitude, state.position!.longitude, state.toShopModel.shopLat!, state.toShopModel.shopLong!));
                      return BlocBuilder<DeliveringBloc,DeliveringState>(
                        buildWhen: (p,c)=>p.markers!=c.markers||p.getPolyLineState!=c.getPolyLineState,
                        builder: (_,state){
                          print("length)))))))))))))))))))))))))))))");
                          print(state.polyLines.length);
                          print(state.polyLines);
                         return Stack(
                           children: [
                             GoogleMap(
                               polylines: state.polyLines,
                                 onMapCreated: (val){
                                   deliveringBloc.googleMapController=val;
                                 },
                                 mapType: MapType.normal,
                                 markers: state.markers.toSet(),
                                 initialCameraPosition: CameraPosition(
                                     zoom: 12,
                                     target: LatLng(state.position!.latitude,state.position!.longitude)
                                 )),
                             Positioned(
                                 bottom: Res.font*1.5,
                                 left: Res.padding,
                                 child:InkWell(
                                   onTap : (){
                                     deliveringBloc.add(GoToLocationEvent());
                                   },
                                   child: Card(
                                     shadowColor: Colors.white,
                                     elevation: Res.font,
                                     shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(Res.font*2)
                                     ),
                                     color: AppColor.primaryColors,
                                     child:Padding(
                                         padding: EdgeInsets.all(Res.padding),
                                         child:  Icon(Icons.my_location_outlined,color: Colors.white,size: Res.font*1.2,)
                                     ),
                                   ),
                                 )),
                           ],
                         );
                    });
                    }


                    return Container();
                  },
                ),
                bottomNavigationBar: SizedBox(
                height: Res.font * 3,
                child: BlocConsumer<DeliveringBloc, DeliveringState>(
                  buildWhen: (p, c) =>
                      p.arrivingShopStageState != c.arrivingShopStageState,
                  listenWhen: (p, c) =>
                      p.arrivingShopStageState != c.arrivingShopStageState,
                  builder: (_, state) {
                    if (state.arrivingShopStageState == States.loading) {
                      return circularProgressIndicatorWidget();
                    }
                    return SlideAction(
                      borderRadius: 0,
                      outerColor: AppColor.primaryColors,
                      onSubmit: () {
                        deliveringBloc.add(ArrivingShopStageEvent());
                      },
                      sliderRotate: false,
                      innerColor: AppColor.primaryColors,
                      text: "                Slide after arriving to shop",
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
                    );
                  },
                  listener: (_, state) {
                    if (state.arrivingShopStageState == States.error) {
                      showSnackBar(context, state.errorMsg);
                    } else if (state.arrivingShopStageState == States.loaded) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (_) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (_) => sl<DeliveringBloc>(),
                                    ),
                                    BlocProvider.value(
                                      value: homeBloc,
                                    ),
                                  ],
                                  child: InShopScreen(
                                    orderId: widget.orderId,
                                  ),
                                )),
                      );
                      homeBloc.add(GetDateEvent());
                    }
                  },
                )),
          ));
        } else if (state.toShopState == States.error) {
          return Scaffold(
            body: errorWidget(state.errorMsg),
          );
        }
        return Container();
      },
    );
  }
  @override
  void dispose() {
    positionStream.cancel();
    super.dispose();
  }
}
