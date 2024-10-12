
import 'package:bhealth/features/profile/presentation/data/models/profile_response.dart';
import 'package:bhealth/features/profile/presentation/data/services/profile_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProfileProvider = FutureProvider<UserProfile?>((ref) async{
  final service = ref.watch(profileServiceProvider);
  return await service.getProfile('7892641450');
});

final profileEditProvider = StateNotifierProvider<ProfileEditController, ProfileEditState>((ref){
  final service = ref.watch(profileServiceProvider);
  return ProfileEditController(service);
});

class ProfileEditController extends StateNotifier<ProfileEditState>{
  final ProfileService _service;
  ProfileEditController(this._service):super(ProfileInitial());


  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  updateUser(UserProfile? profile){
    nameController.text = profile?.userName ?? '';
    userController.text = profile?.userHandle ?? '';
    bioController.text = profile?.bio ?? '';
  }

  saveProfile({
    required String phone,
    required bool autoAccept,
    required String profileImagePath
  }) async{
    try{
      state = ProfileLoading();
      final data = {
        "userName": nameController.text,
        "userHandle": userController.text,
        "mob": phone,
        "gender":"M",
        "age":"10",
        "bio": bioController.text,
        "auto_accept":autoAccept};
      await _service.saveProfile(profileImagePath, data);
      // print(data);
      // await Future.delayed(const Duration(seconds: 5));
      state = ProfileSavedSuccess();
    }catch(e){
      state = ProfileError(e.toString());
    }
  }

}

abstract class ProfileEditState{}

class ProfileInitial extends ProfileEditState{}

class ProfileLoading extends ProfileEditState{}

class ProfileError extends ProfileEditState{
  final String msg;
  ProfileError(this.msg);
}

class ProfileSavedSuccess extends ProfileEditState{}

