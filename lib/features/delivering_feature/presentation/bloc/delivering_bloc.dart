import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/enums.dart';
import '../../data/model/in_shop_model.dart';
import '../../data/model/to_customer_model.dart';
import '../../data/model/to_shop_model.dart';
import '../../domain/use_case/arriving_to_shop_stage_case.dart';
import '../../domain/use_case/done_order_stage_case.dart';
import '../../domain/use_case/get_current_location.dart';
import '../../domain/use_case/get_polyline_case.dart';
import '../../domain/use_case/in_shop_case.dart';
import '../../domain/use_case/leaving_shop_stage_case.dart';
import '../../domain/use_case/to_customer_case.dart';
import '../../domain/use_case/to_shop_case.dart';
import '../../domain/use_case/update_location_case.dart';

part 'delivering_event.dart';

part 'delivering_state.dart';

class DeliveringBloc extends Bloc<DeliveringEvent, DeliveringState> {
  final ToShopCase toShopCase;
  final InShopCase inShopCase;
  final ToCustomerCase toCustomerCase;
  final ArrivingShopStageCase arrivingShopStageCase;
  final LeavingShopStageCase leavingShopStageCase;
  final DoneOrderStageCase doneStageCase;
  final GetCurrentLocationCase getCurrentLocationCase;
  final UpdateLocationCase updateLocationCase;
  final GetPolyLineCase getPolyLineCase;

  late GoogleMapController googleMapController;

  DeliveringBloc(
      this.toShopCase,
      this.inShopCase,
      this.toCustomerCase,
      this.arrivingShopStageCase,
      this.leavingShopStageCase,
      this.doneStageCase,
      this.getCurrentLocationCase,
      this.updateLocationCase,
      this.getPolyLineCase)
      : super(DeliveringState()) {
    on<ToShopEvent>(
      (event, emit) async {
        emit(state.copyWith(toShopState: States.loading));
        final res = await toShopCase(ParamToShop());
        res.fold(
          (l) => emit(
            state.copyWith(
              toShopState: States.error,
              errorMsg: errorMsg(l),
            ),
          ),
          (r) => emit(
            state.copyWith(
              toShopState: States.loaded,
              toShopModel: r,
              markers: List.of(state.markers)
                ..add(
                  Marker(
                    markerId: const MarkerId("shop"),
                    position: LatLng(r.shopLat!, r.shopLong!),
                  ),
                ),
            ),
          ),
        );
      },
    );

    on<InShopEvent>((event, emit) async {
      emit(state.copyWith(inShopState: States.loading));
      final res = await inShopCase(ParamInShop(event.orderId));
      res.fold(
        (l) => emit(
          state.copyWith(
            inShopState: States.error,
            errorMsg: errorMsg(l),
          ),
        ),
        (r) => emit(
          state.copyWith(inShopState: States.loaded, inShopModel: r),
        ),
      );
    });

    on<ToCustomerEvent>((event, emit) async {
      emit(state.copyWith(toCustomerState: States.loading));
      final res = await toCustomerCase(ParamToCustomer(event.orderId));
      res.fold(
        (l) => emit(
          state.copyWith(
            toCustomerState: States.error,
            errorMsg: errorMsg(l),
          ),
        ),
        (r) => emit(
          state.copyWith(
            toCustomerState: States.loaded,
            toCustomerModel: r,
            markers: List.of(state.markers)
              ..add(
                Marker(
                  markerId: const MarkerId("customer"),
                  position: LatLng(r.addressLat!, r.addressLong!),
                ),
              ),
          ),
        ),
      );
    });

    on<ArrivingShopStageEvent>((event, emit) async {
      emit(state.copyWith(arrivingShopStageState: States.loading));
      final res = await arrivingShopStageCase(ParamArrivingToShopStage());
      res.fold(
        (l) => emit(
          state.copyWith(
            arrivingShopStageState: States.error,
            errorMsg: errorMsg(l),
          ),
        ),
        (r) => emit(
          state.copyWith(arrivingShopStageState: States.loaded),
        ),
      );
    });

    on<LeavingShopStageEvent>((event, emit) async {
      emit(state.copyWith(leavingShopStageState: States.loading));
      final res =
          await leavingShopStageCase(ParamLeavingShopStage(event.orderId));
      res.fold(
        (l) => emit(
          state.copyWith(
            leavingShopStageState: States.error,
            errorMsg: errorMsg(
              l,
            ),
          ),
        ),
        (r) => emit(
          state.copyWith(leavingShopStageState: States.loaded),
        ),
      );
    });

    on<DoneStageEvent>((event, emit) async {
      emit(state.copyWith(doneStageState: States.loading));
      final res = await doneStageCase(
          ParamDoneOrderStage(event.orderId, event.dateTime));
      res.fold(
        (l) => emit(
          state.copyWith(
            doneStageState: States.error,
            errorMsg: errorMsg(
              l,
            ),
          ),
        ),
        (r) => emit(
          state.copyWith(doneStageState: States.loaded),
        ),
      );
    });

    on<GetCurrentLocationEvent>((event, emit) async {
      emit(state.copyWith(getCurrentLocationState: States.loading));
      final res = await getCurrentLocationCase(ParamGetCurrentLocation());
      res.fold((l) {}, (r) {
        emit(
          state.copyWith(
              getCurrentLocationState: States.loaded,
              position: r,
              markers: List.of(state.markers)
                ..add(Marker(
                  markerId: const MarkerId("delivery"),
                  position: LatLng(r.latitude, r.longitude),
                ))),
        );
      });
    });

    on<UpdateLocationEvent>((event, emit) async {
      final res =
          await updateLocationCase(ParamUpdateLocation(event.lat, event.long));
      if (state.markers.isNotEmpty) {
        state.markers
            .removeWhere((element) => element.markerId.value == 'delivery');
      }
      emit(
        state.copyWith(
          markers: List.of(state.markers)
            ..add(
              Marker(
                markerId: const MarkerId("delivery"),
                position: LatLng(event.lat, event.long),
              ),
            ),
        ),
      );
    });

    on<GoToLocationEvent>((event, emit) async {
      final res = await getCurrentLocationCase(ParamGetCurrentLocation());
      res.fold((l) {}, (r) {
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(r.latitude, r.longitude), zoom: 17)));
        if (state.markers.isNotEmpty) {
          state.markers
              .removeWhere((element) => element.markerId.value == "delivery");
          emit(state.copyWith(
              markers: List.of(state.markers)
                ..add(Marker(
                    markerId: MarkerId("delivery"),
                    position: LatLng(r.latitude, r.longitude)))));
        }
      });
    });

    on<GetPolyLineEvent>((event, emit) async {
      emit(state.copyWith(getPolyLineState: States.loading));
      final res = await getPolyLineCase(ParamGetPolyLine(
          lat: event.lat,
          long: event.long,
          destLat: event.destLat,
          destLong: event.destLong));
      res.fold(
        (l) => emit(state.copyWith(getPolyLineState: States.error)),
        (r) => emit(
          state.copyWith(
            getPolyLineState: States.loaded,
            polyLines: Set.of(r),
          ),
        ),
      );
    });
  }
}
