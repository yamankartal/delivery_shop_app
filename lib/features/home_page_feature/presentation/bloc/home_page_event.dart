part of 'home_page_bloc.dart';



abstract class HomePageEvent{}

class ChangeScreenIndex extends HomePageEvent{
  final int index;
  ChangeScreenIndex(this.index);
}