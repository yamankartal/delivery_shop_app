import 'package:bloc/bloc.dart';
import 'package:shop_delivery/core/constants/responsive.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/enums.dart';
import '../../data/model/profile_model.dart';
import '../../domain/use_case/get_profile_case.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileCase getProfileCase;

  ProfileBloc(this.getProfileCase) : super(ProfileState()) {


    on<GetProfileEvent>((event, emit) async {
      print("e");
        emit(state.copyWith(getProfileState: States.loading));
        final res = await getProfileCase(ParamGetProfile());
        res.fold(
          (l) => emit(
            state.copyWith(
              getProfileState: States.error,
              errorMsg: errorMsg(l),
            ),
          ),
          (r) => emit(
            state.copyWith(getProfileState: States.loaded, profileModel: r),
          ),
        );
      });


  }
}
