import 'package:bhealth/features/profile/presentation/data/models/profile_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/sample_data.dart';
import '../../profile/presentation/data/services/profile_services.dart';

final authProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  // final authServe = ref.watch(authServiceProvider);
  final profileService = ref.watch(profileServiceProvider);
  return AuthController(profileService);
});

class AuthController extends StateNotifier<AuthState> {
  // final AuthService _service;
  final ProfileService _profileService;

  AuthController(this._profileService) : super(AuthInitialState()) {
    init();
  }

  Future<void> init() async {
    try {
      state = AuthLoading();
      await Future.delayed(const Duration(milliseconds: 500));
      state = AuthUnAuthenticated();
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  void login() {
    state = AuthLoggedIn(User(), testUser);
  }

  logout() async {
    state = AuthUnAuthenticated();
  }
}

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoggedIn extends AuthState {
  final User user;
  final UserProfile? userProfile;

  AuthLoggedIn(this.user, this.userProfile);
}

class AuthUnAuthenticated extends AuthState {}

class AuthError extends AuthState {
  final String msg;

  AuthError(this.msg);
}

class User {}
