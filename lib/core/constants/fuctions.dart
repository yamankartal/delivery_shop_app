

import 'package:shop_delivery/core/constants/widgets.dart';
import 'package:shop_delivery/features/home_feature/presentation/bloc/home_bloc.dart';

changeStatus(HomeBloc homeBloc,val,status,context){
  if(val==false){
    if(status==1){
      showSnackBar(context,"you can not turn off your status until you complete your orders");
    }
    else {
      homeBloc.add(CloseStatusEvent());
    }
  }
  else{

    if(status==-1){
      showSnackBar(context,"you can not activate because your status is freezing");
    }
    else  {
      homeBloc.add(OpenStatusEvent());
    }
  }
}