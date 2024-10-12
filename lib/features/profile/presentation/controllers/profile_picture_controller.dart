
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/services/image_picker_service.dart';

final profilePictureProvider = StateNotifierProvider<ProfilePictureController, ProfilePictureStates>((ref) {
  return ProfilePictureController();
});

class ProfilePictureController extends StateNotifier<ProfilePictureStates>{
  ProfilePictureController():super(ProfilePictureInitialState());

  chooseFromGallery()async{
    final File? image = await ImagePickerService().pickImageFromGallery();
    if(image != null){
      state = ProfilePictureLoadedState(image);
    }
  }

  takePhoto()async{
    final File? image = await ImagePickerService().takePhoto();
    if(image != null){
      state = ProfilePictureLoadedState(image);
    }
  }

}

abstract class ProfilePictureStates{}

class ProfilePictureInitialState extends ProfilePictureStates{}

class ProfilePictureLoadedState extends ProfilePictureStates{
  final File selectedPicture;
  ProfilePictureLoadedState(this.selectedPicture);
}