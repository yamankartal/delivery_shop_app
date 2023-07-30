import 'package:bloc/bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/enums.dart';
import '../../data/model/home_model.dart';
import '../../domain/use_case/close_status.dart';
import '../../domain/use_case/get_data.dart';
import '../../domain/use_case/get_position_case.dart';
import '../../domain/use_case/open_status_case.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CloseStatusCase closeStatusCase;
  final GetDateCase getDateCase;
  final GetPositionCase getPositionCase;
  final OpenStatusCase openStatusCase;

  HomeBloc(
      this.closeStatusCase,
      this.getDateCase,
      this.getPositionCase,
      this.openStatusCase)
      : super(HomeState()) {
    on<OpenStatusEvent>((event, emit) async {
      emit(
        state.copyWith(
          openStatus: States.loading,
          homeModel: state.homeModel.copyWith(deliveryStatus: 0),
        ),
      );
      final res = await openStatusCase(OpenStatusParam());
      res.fold(
            (l) => emit(
          state.copyWith(
            openStatus: States.error,
            homeModel: state.homeModel.copyWith(deliveryStatus: -1),
            errorMsg: errorMsg(l),
          ),
        ),
            (r) => emit(
          state.copyWith(
            openStatus: States.loaded,
          ),
        ),
      );
      emit(state.copyWith(openStatus: States.init));
    });

    on<CloseStatusEvent>((event, emit) async {
      final int deliveryStatus=state.homeModel.deliveryStatus!;
      emit(state.copyWith(
          closeStatus: States.loading,
          homeModel: state.homeModel.copyWith(deliveryStatus:-1)));
      final res = await closeStatusCase(CloseStatusParam());
      res.fold(
            (l) => emit(
          state.copyWith(

            closeStatus: States.error,
            errorMsg: errorMsg(l,),
            homeModel: state.homeModel.copyWith(deliveryStatus: deliveryStatus)
          ),
        ),
            (r) => emit(
          state.copyWith(
            closeStatus: States.loaded,
          ),
        ),
      );
      emit(state.copyWith(closeStatus: States.init));
    });

    on<GetDateEvent>((event, emit) async {
      emit(state.copyWith(getDateState: States.loading));
      final res = await getDateCase(ParamGetData());
      res.fold(
        (l) => emit(
          state.copyWith(
            getDateState: States.error,
            errorMsg: errorMsg(l, ),
          ),
        ),
        (r) => emit(
          state.copyWith(getDateState: States.loaded, homeModel: r),
        ),
      );
    });

    on<GetPositionEvent>((event, emit) async {
      emit(state.copyWith(getPositionState: States.loading));
      final res = await getPositionCase(ParamGetPosition());
      res.fold(
        (l) => emit(
          state.copyWith(
            getPositionState: States.error,
            errorMsg: errorMsg(l, ),
          ),
        ),
        (r) => emit(
          state.copyWith(getPositionState: States.loaded, position: r),
        ),
      );
    });

  }
}
