//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../models/auth_service_interface.dart';
//
// final authServiceProvider = Provider<AuthService>((ref) {
//   return AuthService(FirebaseAuth.instance);
// });
//
// class AuthService extends AutServiceInterface{
//   final FirebaseAuth _firebaseAuth;
//   AuthService(this._firebaseAuth);
//
//   @override
//   User? getLoggedInUser() => _firebaseAuth.currentUser;
//
//
//   @override
//   Future<void> logOut()async{
//     await _firebaseAuth.signOut();
//   }
//
//
//   Future<void> deleteAccount(String currentPassword)async{
//     try{
//       await _firebaseAuth.currentUser?.delete();
//     }on FirebaseException catch(e){
//       throw e.message ?? e.code;
//     }catch(_){
//       rethrow;
//     }
//   }
//
//   String? _verificationId;
//
//   Future<void> phoneAuthentication(String mobile, Function(UserCredential, PhoneAuthCredential) completion, VoidCallback codeSent, Function(FirebaseException) verificationFailed)async{
//     try{
//       await _firebaseAuth.verifyPhoneNumber(
//           phoneNumber: mobile,
//           verificationCompleted: (PhoneAuthCredential credential) async{
//             debugPrint('VERIFICATION COMPLETED');
//             final userCredential = await _firebaseAuth.signInWithCredential(credential);
//             completion(userCredential, credential);
//           },
//           verificationFailed: verificationFailed,
//           codeSent: (String verificationId, int? resendCode){
//             debugPrint('CODE SENT');
//             _verificationId = verificationId;
//             codeSent();
//           },
//           codeAutoRetrievalTimeout: (String verificationId){
//
//           });
//
//     }on FirebaseException catch(e){
//       debugPrint('EXCEPTION FIRE');
//       throw e.message ?? e.code;
//     }catch(e){
//       debugPrint(e.toString());
//       rethrow;
//     }
//   }
//
//   Future<UserCredential> verifyOtp(String otp) async{
//     try{
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: otp);
//       final userCredential = await _firebaseAuth.signInWithCredential(credential);
//       return userCredential;
//     }on FirebaseException catch(e){
//       throw e.message ?? e.code;
//     }catch(e){
//       rethrow;
//     }
//   }
//
//
// }