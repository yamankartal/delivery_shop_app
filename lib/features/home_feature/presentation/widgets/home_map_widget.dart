import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/widgets.dart';
import '../bloc/home_bloc.dart';

class HomeMapWidget extends StatelessWidget {
  const HomeMapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc,HomeState>(
        buildWhen: (p,c)=>p.getPositionState!=c.getPositionState,
        builder: (_,state){
          if(state.getPositionState==States.loading){
            return SizedBox(
              height:state.homeModel.deliveryStatus!>0?Res.height*0.45:Res.height*0.52,
              width: Res.width,
              child: circularProgressIndicatorWidget(),
            );
          }else if(state.getPositionState==States.loaded){
            return Container(
              margin: EdgeInsets.only(top:Res.font*0.7),
              height:state.homeModel.deliveryStatus!>0?Res.height*0.45:Res.height*0.52,
              width: Res.width,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(Res.padding*0.5),
                  child:GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition:CameraPosition(
                      target: LatLng(state.position!.latitude,state.position!.longitude),
                      zoom:10,
                    ),
                  )
              ),
            );
          }

          return Container();
        });
  }
}
