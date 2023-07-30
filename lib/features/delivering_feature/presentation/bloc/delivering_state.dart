part of 'delivering_bloc.dart';

class DeliveringState {
  final ToShopModel toShopModel;
  final InShopModel inShopModel;
  final ToCustomerModel toCustomerModel;

  final States toShopState;
  final States inShopState;
  final States toCustomerState;
  final States arrivingShopStageState;
  final States leavingShopStageState;
  final States doneStageState;

  final States getCurrentLocationState;
  final Position? position;
  final List<Marker>markers;
  final String errorMsg;

  final States getPolyLineState;
  final Set<Polyline> polyLines;

  DeliveringState(
      {this.toShopModel=const ToShopModel(),
      this.inShopModel=const InShopModel(),
      this.toCustomerModel=const ToCustomerModel(),
      this.toShopState=States.init,
      this.inShopState=States.init,
      this.toCustomerState=States.init,
      this.arrivingShopStageState=States.init,
      this.leavingShopStageState=States.init,
      this.doneStageState=States.init,
      this.errorMsg="",
      this.getCurrentLocationState=States.init,
      this.position,
        this.markers=const[],
        this.getPolyLineState=States.init,
        this.polyLines=const{}
      });


  DeliveringState copyWith({

    final ToShopModel ?toShopModel,
    final InShopModel? inShopModel,
    final ToCustomerModel? toCustomerModel,

    final States? toShopState,
    final States? inShopState,
    final States? toCustomerState,
    final States ?arrivingShopStageState,
    final States ?leavingShopStageState,
    final States ?doneStageState,
    final String? errorMsg,
    final States ?getCurrentLocationState,
    final Position? position,
    final List<Marker>?markers,
    final States? getPolyLineState,
    final Set<Polyline> ?polyLines,


}){

    return DeliveringState(
      toShopModel:toShopModel??this.toShopModel,
      inShopModel: inShopModel??this.inShopModel,
      toCustomerModel: toCustomerModel??this.toCustomerModel,
      toShopState: toShopState??this.toShopState,
      inShopState: inShopState??this.inShopState,
      toCustomerState: toCustomerState??this.toCustomerState,
      arrivingShopStageState: arrivingShopStageState??this.arrivingShopStageState,
      leavingShopStageState: leavingShopStageState??this.leavingShopStageState,
      doneStageState: doneStageState??this.doneStageState,
      getCurrentLocationState: getCurrentLocationState??this.getCurrentLocationState,
      position: position??this.position,
      errorMsg: errorMsg??this.errorMsg,
      markers: markers??this.markers,
      getPolyLineState: getPolyLineState??this.getPolyLineState,
      polyLines: polyLines??this.polyLines,




    );

  }
}
