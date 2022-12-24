import 'package:firebase_auth/firebase_auth.dart';

abstract class PhoneAuthState{}

class PhoneAuthInitialState extends PhoneAuthState{}

class CodeSentState extends PhoneAuthState{}

class VerifyCodeState extends PhoneAuthState{}

class AuthLoginState extends PhoneAuthState{
  User? user;
  AuthLoginState({this.user});
}

class AuthLogoutState extends PhoneAuthState{}

class AuthErrorState extends PhoneAuthState{
  String? errorMessage;
  AuthErrorState({this.errorMessage});
}

class AuthLoadingState extends PhoneAuthState{}