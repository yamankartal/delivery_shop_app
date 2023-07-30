part of 'delivering_bloc.dart';


abstract class DeliveringEvent{}


class ToShopEvent extends DeliveringEvent{}


class InShopEvent extends DeliveringEvent{
  final int orderId;
  InShopEvent(this.orderId);
}


class ToCustomerEvent extends DeliveringEvent{
  final int orderId;
  ToCustomerEvent(this.orderId);
}

class ArrivingShopStageEvent extends DeliveringEvent{}

class LeavingShopStageEvent extends DeliveringEvent{
  final int orderId;
  LeavingShopStageEvent(this.orderId);
}

class DoneStageEvent extends DeliveringEvent{
  final int orderId;
  final DateTime dateTime;
  DoneStageEvent(this.orderId, this.dateTime);
}

class GetCurrentLocationEvent extends DeliveringEvent{}

class GoToLocationEvent extends DeliveringEvent{}

class UpdateLocationEvent extends DeliveringEvent{
  final double lat;
  final double long;
  UpdateLocationEvent(this.lat, this.long);
}

class GetPolyLineEvent extends DeliveringEvent{
  final double lat;
  final double long;
  final double destLat;
  final double destLong;

  GetPolyLineEvent(this.lat, this.long, this.destLat, this.destLong);
}
