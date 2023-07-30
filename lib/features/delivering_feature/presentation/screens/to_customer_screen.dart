import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_delivery/features/delivering_feature/presentation/widgets/order_details_dialog.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/widgets.dart';
import '../../../home_feature/presentation/bloc/home_bloc.dart';
import '../../data/model/to_customer_model.dart';
import '../bloc/delivering_bloc.dart';

class ToCustomerScreen extends StatefulWidget {
  final int orderId;

  const ToCustomerScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<ToCustomerScreen> createState() => _ToCustomerScreenState();
}

class _ToCustomerScreenState extends State<ToCustomerScreen> {
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
    deliveringBloc.add(ToCustomerEvent(widget.orderId));
    deliveringBloc.add(GetCurrentLocationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveringBloc, DeliveringState>(
      buildWhen: (p, c) => p.toCustomerState != c.toCustomerState,
      builder: (_, state) {
        if (state.toCustomerState == States.loading) {
          return Scaffold(body: circularProgressIndicatorWidget());
        } else if (state.toCustomerState == States.loaded) {
          return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  leading: Text(""),
                  titleSpacing: -Res.font * 1.5,
                  title: Text("order number : ${widget.orderId}"),
                ),
                body: BlocConsumer<DeliveringBloc, DeliveringState>(
                  builder: (_, state) {
                    if (state.doneStageState == States.loading) {
                      return circularProgressIndicatorWidget();
                    }
                    return BlocBuilder<DeliveringBloc, DeliveringState>(
                      buildWhen: (p, c) =>
                          p.getCurrentLocationState !=
                          c.getCurrentLocationState,
                      builder: (_, state) {
                        if (state.getCurrentLocationState == States.loading) {
                        } else if (state.getCurrentLocationState ==
                            States.loaded) {
                          deliveringBloc.add(GetPolyLineEvent(
                              state.position!.latitude,
                              state.position!.longitude,
                              state.toCustomerModel.addressLat!,
                              state.toCustomerModel.addressLong!));
                          return BlocBuilder<DeliveringBloc, DeliveringState>(
                            buildWhen: (p, c) =>
                                p.markers != c.markers ||
                                p.getPolyLineState != c.getPolyLineState,
                            builder: (_, state) {
                              print("length)))))))))))))))))))))))))))))");
                              print(state.polyLines.length);
                              print(state.polyLines);
                              return Stack(
                                children: [
                                  GoogleMap(
                                      polylines: state.polyLines,
                                      onMapCreated: (val) {
                                        deliveringBloc.googleMapController =
                                            val;
                                      },
                                      mapType: MapType.normal,
                                      markers: state.markers.toSet(),
                                      initialCameraPosition: CameraPosition(
                                          zoom: 12,
                                          target: LatLng(
                                              state.position!.latitude,
                                              state.position!.longitude))),
                                  Positioned(
                                    bottom: Res.font * 1.5,
                                    left: Res.padding,
                                    child: InkWell(
                                      onTap: () {
                                        deliveringBloc.add(GoToLocationEvent());
                                      },
                                      child: Card(
                                        shadowColor: Colors.white,
                                        elevation: Res.font,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                Res.font * 2)),
                                        color: AppColor.primaryColors,
                                        child: Padding(
                                          padding: EdgeInsets.all(Res.padding),
                                          child: Icon(
                                            Icons.my_location_outlined,
                                            color: Colors.white,
                                            size: Res.font * 1.2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }

                        return Container();
                      },
                    );
                  },
                  listener: (_, state) {
                    if (state.doneStageState == States.error) {
                      showSnackBar(context, state.errorMsg);
                    } else if (state.doneStageState == States.loaded) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      homeBloc.add(GetDateEvent());
                    }
                  },
                  buildWhen: (p, c) => p.doneStageState != c.doneStageState,
                  listenWhen: (p, c) => p.doneStageState != c.doneStageState,
                ),
                bottomNavigationBar: InkWell(
                  child: Container(
                    color: AppColor.primaryColors,
                    height: Res.height * 0.07,
                    alignment: Alignment.center,
                    child: Text(
                      "Details",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Res.font,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () {
                    final ToCustomerModel toCustomerModel =
                        state.toCustomerModel;
                    showDialog(
                        context: context,
                        builder: (_) => OrderDetailsDialog(
                            toCustomerModel: toCustomerModel,
                            deliveringBloc: deliveringBloc,
                            orderId: widget.orderId));
                  },
                )),
          );
        } else if (state.toCustomerState == States.error) {
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
