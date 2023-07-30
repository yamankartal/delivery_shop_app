part of 'home_page_bloc.dart';


class HomePageState{
  final int homeScreenIndex;
  HomePageState({this.homeScreenIndex=0});

  HomePageState copyWith({
    final int? homeScreenIndex,
  }){
    return HomePageState(
      homeScreenIndex: homeScreenIndex??this.homeScreenIndex,
    );
  }
}