part of 'auth_bloc.dart';

abstract class AuthEvent{}

class SignInEvent extends AuthEvent{
  final String verifyCode;
  SignInEvent(this.verifyCode);
}

class SignOutEvent extends AuthEvent{}

class IsSignInEvent extends AuthEvent{}