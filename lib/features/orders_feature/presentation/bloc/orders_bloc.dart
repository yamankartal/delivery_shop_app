import 'package:bloc/bloc.dart';
import 'package:shop_delivery/core/constants/responsive.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/enums.dart';
import '../../data/model/orders_model.dart';
import '../../domain/use_case/accepte_order_case.dart';
import '../../domain/use_case/get_archived_orders_case.dart';
import '../../domain/use_case/get_pending_orders_case.dart';

part 'orders_event.dart';

part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetArchivedOrdersCase getArchivedOrdersCase;
  final GetPendingOrdersCase getOrderCase;
  final AccepteOrderCase accepteOrderCase;
  OrdersBloc(this.getArchivedOrdersCase, this.getOrderCase, this.accepteOrderCase) : super(OrdersState()) {


    on<GetArchivedOrdersEvent>((event, emit) async {
      emit(state.copyWith(getArchivedOrdersState: States.loading));
      final res = await getArchivedOrdersCase(ParamGetArchivedOrders());
      res.fold(
        (l) => emit(
          state.copyWith(
            getArchivedOrdersState: States.error,
            errorMsg: errorMsg(l),
          ),
        ),
        (r) => emit(
          state.copyWith(
            getArchivedOrdersState: States.loaded,
            orders: List.of(r),
          ),
        ),
      );
    });


    on<GetPendingOrdersEvent>((event, emit) async {
      emit(state.copyWith(getPendingOrdersState: States.loading));
      final res = await getOrderCase(ParamGetPendingOrders());
      res.fold(
        (l) => emit(
          state.copyWith(
            getPendingOrdersState: States.error,
            errorMsg: errorMsg(l),
          ),
        ),
        (r) {
          emit(
            state.copyWith(
              getPendingOrdersState: States.loaded,
              orders: List.of(r)
            ),
          );
        },
      );
    });


    on<AccepteOrderEvent>((event, emit) async {
      emit(state.copyWith(accepteOrderState: States.loading));
      final res = await accepteOrderCase(ParamAccepteOrderCase(state.orders[event.index].orderId!,event.dateTime));
      res.fold(
        (l) => emit(
          state.copyWith(
            accepteOrderState: States.error,
            errorMsg: errorMsg(l),
          ),
        ),
        (r) {
          emit(
            state.copyWith(
              accepteOrderState: States.loaded,
              //orders: List.of(state.orders)..removeWhere((element) => element.orderId==state.orders[event.index].orderId)
            ),
          );
        },
      );
    });

    on<RefreshPendingOrdersEvent>((event, emit){
      emit(state.copyWith(orders: List.of(state.orders)..removeWhere((element) => element.orderId==event.orderId,)));
    });



  }
}
