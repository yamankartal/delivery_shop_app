part of 'home_bloc.dart';

class HomeState {
  final HomeModel homeModel;
  final Position? position;
  final States openStatus;
  final States closeStatus;
  final States getDateState;
  final States getPositionState;
  final String errorMsg;

  HomeState({
      this.position,
      this.homeModel=const HomeModel(),
      this.openStatus=States.init,
      this.closeStatus=States.init,
      this.getDateState=States.init,
      this.getPositionState=States.init,
      this.errorMsg="",
  });


  HomeState copyWith(

  {
    final Position? position,
    final HomeModel ?homeModel,
    final States ? openStatus,
    final States ? closeStatus,
    final States  ?getDateState,
    final States ? getPositionState,
    final String? errorMsg,
}




      ){

    return HomeState(

      closeStatus: closeStatus??this.closeStatus,
      openStatus: openStatus??this.openStatus,
      getDateState: getDateState??this.getDateState,
      getPositionState: getPositionState??this.getPositionState,
      homeModel: homeModel??this.homeModel,
      position: position??this.position,
      errorMsg: errorMsg??this.errorMsg,
    );


  }

}
