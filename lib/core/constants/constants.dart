
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_delivery/core/constants/responsive.dart';

import 'enums.dart';
import 'failures.dart';

final  GlobalKey<NavigatorState>navigatorKey=GlobalKey();

const String apiKey="AIzaSyBWNYOLMc9NK_vZtMFYJWIkBlkole8kQa8";
const String serverKey="AAAAXYpuka4:APA91bG7l-RlP3d6tJTbsvhY3zvt0XuzC3VwvccwH_DMWOkyrPVEtP8ftKURXr2NthQnE5HC4lCJhKUTjrrRKDJbMsrcULYboZ9fFH64Xfu89z4xjGARBDbnaX_1rfSoCby89BfLblwz";
const String token="ckBOYR9AT86CwyU8SCF4nj:APA91bEik_FRJ5SdgRklASf-4I6vS7QGUr-LYVT0oqlxsKQTAmKqlAB6Hwn6j_UbibCE8szOWG6TdUMNwf8uIIUywgVezVkOzkLDY1mtw6uvVYxBPfIJzGWJhZscpBb2SfwI6d8lN2CZ";


Screen screen=Screen.other;


String errorMsg( Failure errorType){
  if(errorType is ServerFailure){
    return "server failure, please try again later";
  }
  else if(errorType is ConnectionFailure){
    return "no internet connection";
  }
  else if(errorType is BackendFailure) {
    return errorType.errorMsg;
  }
  return "";
}

calculatePerecent(int percent){
  return Res.width*0.5*percent/100;
}





