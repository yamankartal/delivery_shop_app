part of 'auth_bloc.dart';

class AuthState {

  final bool isSignIn;
  final States signInState;
  final States isSignInState;
  final States signOutState;
  final String errorMsg;

  AuthState(
      {this.isSignIn=false,
        this.signInState = States.init,
      this.isSignInState = States.init,
      this.signOutState = States.init,
      this.errorMsg = ""});

  AuthState copyWith({
    final States ?signInState,
    final States ?isSignInState,
    final States ?signOutState,
    final String ?errorMsg,
    final bool? isSignIn,


  }){


    return AuthState(
      isSignIn: isSignIn??this.isSignIn,
      signInState: signInState??this.signInState,
      signOutState: signOutState??this.signOutState,
      isSignInState: isSignInState??this.isSignInState,
      errorMsg: errorMsg??this.errorMsg,
    );


  }

}
