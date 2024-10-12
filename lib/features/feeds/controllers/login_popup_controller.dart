

import 'package:bhealth/features/auth/controllers/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginPopupProvider = StateProvider<bool>((ref) {
  final authController = ref.watch(authProvider);
  if(authController is AuthUnAuthenticated){
    return true;
  }
  return false;
});