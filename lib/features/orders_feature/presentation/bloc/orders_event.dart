part of 'orders_bloc.dart';
 abstract class OrdersEvent{}

class GetArchivedOrdersEvent extends OrdersEvent{}

class GetPendingOrdersEvent extends OrdersEvent{}

class AccepteOrderEvent extends OrdersEvent{

   final int index;
   final DateTime dateTime;
   AccepteOrderEvent(this.index, this.dateTime);
}

class RefreshPendingOrdersEvent extends OrdersEvent{
   final int orderId;
  RefreshPendingOrdersEvent(this.orderId, );
}