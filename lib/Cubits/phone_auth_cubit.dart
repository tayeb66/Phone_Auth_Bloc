import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_bloc1/Cubits/phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? _verficationId;

  PhoneAuthCubit() : super(PhoneAuthInitialState());

  void codeSent(String? phoneNumber) async {
    emit(AuthLoadingState());
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber!,
      codeSent: (verificationId, forceResendingToken) {
        _verficationId = verificationId;
        emit(CodeSentState());
      },
      verificationCompleted: (phoneAuthCredential) {
        signInPhone(phoneAuthCredential);
      },
      verificationFailed: (error) {
        emit(AuthErrorState(errorMessage: error.message.toString()));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verficationId = verificationId;
      },
    );
  }

  void verifyCode(String? otp) async {
    emit(AuthLoadingState());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verficationId!, smsCode: otp!);
    signInPhone(credential);
  }

  void signInPhone(PhoneAuthCredential phoneAuthCredential) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithCredential(
          phoneAuthCredential);
      if(userCredential != null){
        emit(AuthLoginState(user: userCredential.user!));
      }
    }on FirebaseException catch(e){
      emit(AuthErrorState(errorMessage: e.message.toString()));
    }
  }
}
