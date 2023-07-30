import 'package:bloc/bloc.dart';
import 'package:shop_delivery/core/constants/constants.dart';
import 'package:shop_delivery/features/auth_feature/domain/use_case/is_sign_in_case.dart';
import 'package:shop_delivery/features/auth_feature/domain/use_case/sign_in_case.dart';
import 'package:shop_delivery/features/auth_feature/domain/use_case/sign_out_case.dart';

import '../../../../core/constants/enums.dart';

part 'auth_event.dart';
part 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent,AuthState>{
  final SignInCase signInCase;
  final IsSignInCase isSignInCase;
  final SignOutCase signOutCase;
  AuthBloc(this.signInCase, this.isSignInCase, this.signOutCase) : super(AuthState()){


    on<SignInEvent>((event, emit)async{
      emit(state.copyWith(signInState: States.loading));
      final res=await signInCase(ParamSignIn(event.verifyCode));
      res.fold((l) => emit(state.copyWith(signInState: States.error,errorMsg: errorMsg(l))), (r) => emit(state.copyWith(signInState: States.loaded)));
    });

    on<SignOutEvent>((event, emit)async{
      emit(state.copyWith(signOutState: States.loading));
      final res=await signOutCase(ParamSignOut());
      res.fold((l) => emit(state.copyWith(signOutState: States.error,errorMsg: errorMsg(l))), (r) => emit(state.copyWith(signOutState: States.loaded)));
    });

    on<IsSignInEvent>((event, emit)async{
      emit(state.copyWith(isSignInState:  States.loading));
      final res=await isSignInCase(ParamIsSignIn());
      res.fold((l) => emit(state.copyWith(isSignInState: States.error,errorMsg: errorMsg(l))), (r) => emit(state.copyWith(isSignInState: States.loaded,isSignIn: r)));
    });





  }
}