
part of 'orders_bloc.dart';

class OrdersState{

  final List<OrderModel>orders;
  final States getArchivedOrdersState;
  final States getPendingOrdersState;
  final States accepteOrderState;
  final OrderModel orderModel;
  final String errorMsg;
  OrdersState({this.accepteOrderState=States.init,this.orderModel=const OrderModel(),this.getPendingOrdersState=States.init,this.orders=const[], this.getArchivedOrdersState=States.init,this.errorMsg=""});


  OrdersState copyWith({

    final List<OrderModel>?orders,
    final States ?getArchivedOrdersState,
    final String ?errorMsg,
    final States ?getPendingOrdersState,
    final OrderModel? orderModel,
    final States ?accepteOrderState,


}){


    return OrdersState(
      getArchivedOrdersState: getArchivedOrdersState??this.getArchivedOrdersState,
       orders: orders??this.orders,
      errorMsg: errorMsg??this.errorMsg,
        getPendingOrdersState: getPendingOrdersState??this.getPendingOrdersState,
      orderModel: orderModel??this.orderModel,
      accepteOrderState: accepteOrderState??this.accepteOrderState
    );

  }

}