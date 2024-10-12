//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// final loginProvider = StateNotifierProvider<LoginController, LoginStates>((ref) => LoginController());
//
// class LoginController extends StateNotifier<LoginStates>{
//   LoginController():super(LoginInitialState());
//
//   sendOtp(){
//     state = OTPSentState();
//   }
//
//   setInitialState(){
//     state = LoginInitialState();
// }
//
// }
//
// abstract class LoginStates{}
//
// class LoginInitialState extends LoginStates{}
//
// class OTPSentState extends LoginStates{}
