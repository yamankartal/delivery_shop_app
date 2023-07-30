part of 'home_bloc.dart';
abstract class HomeEvent{}

class CloseStatusEvent extends HomeEvent{}
class GetDateEvent extends HomeEvent{}
class GetPositionEvent extends HomeEvent{}
class OpenStatusEvent extends HomeEvent{}