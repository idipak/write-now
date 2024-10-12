
import 'dart:async';

import 'package:bhealth/features/auth/controllers/auth_controller.dart';
import 'package:bhealth/features/auth/controllers/phone_code_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

import '../service/auth_service.dart';


final mobileLoginProvider = StateNotifierProvider.autoDispose((ref){
  var link = ref.keepAlive();
  Timer(const Duration(seconds: 2),(){
    link.close();
  });

  // final authService = ref.watch(authServiceProvider);
  return MobileLoginController(ref);
});

class MobileLoginController extends StateNotifier{
  // final AuthService _service;
  final Ref _ref;
  MobileLoginController(this._ref):super(MobileLoginInitialState());

  final formKey = GlobalKey<FormState>();
  final mobileController = TextEditingController();

  final otpController = TextEditingController();

  sendOtp({bool resend = false})async{
    try{
      if(resend || formKey.currentState!.validate()){
        state = MobileLoginLoading();
        final countryCode = _ref.read(phoneCodeProvider);
        final mobile = "$countryCode${mobileController.text}";
        print("MOBILE WITHOUT COUNTRY : ${mobileController.text}");
        print("MOBILE NUMBER = $mobile");
        await Future.delayed(const Duration(milliseconds: 500));
        _handleCodeSent();
        // await _service.phoneAuthentication(
        //     mobile,
        //     _handlePhoneVerified,
        //     _handleCodeSent,
        //     _handleVerificationFailed);
      }
    }catch(e){
      state = MobileLoginError(e.toString());
    }
  }

  void _handlePhoneVerified(String smsCode){
    otpController.setText(smsCode);
    state = MobileVerified();
  }

  void _handleCodeSent(){
    state = OtpSentState();
  }

  void _handleVerificationFailed(e){
    state = MobileLoginError("$e");
  }

  verifyOtp()async{
    try{
      state = MobileLoginLoading();
      await Future.delayed(const Duration(milliseconds: 500));
      _ref.read(authProvider.notifier).login();
      state = MobileVerified();
    }catch(e){
      state = MobileLoginError(e.toString());
    }
  }


  @override
  void dispose() {
    super.dispose();
    mobileController.dispose();
    otpController.dispose();
    debugPrint("SIGNUP CONTROLLER DISPOSED");
  }

}

abstract class MobileLoginState{}

class MobileLoginInitialState extends MobileLoginState{}

class MobileLoginLoading extends MobileLoginState{}

class OtpSentState extends MobileLoginState{}

class MobileLoginError extends MobileLoginState{
  final String msg;
  MobileLoginError(this.msg);
}

class MobileVerified extends MobileLoginState{}