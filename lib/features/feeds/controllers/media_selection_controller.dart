

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/services/image_picker_service.dart';

final mediaSelectionProvider = StateNotifierProvider<MediaSelectionController, List<File>>((ref) {
  final pickerService = ref.watch(imagePickerServiceProvider);
  return MediaSelectionController(pickerService);
});

class MediaSelectionController extends StateNotifier<List<File>>{
  final ImagePickerService _picker;
  MediaSelectionController(this._picker):super([]);


  captureMoment()async{
    final file = await _picker.takePhoto();
    if(file != null){
      state = [file, ...state];
    }
  }

  addFromGallery()async{
    final file = await _picker.pickImageFromGallery();
    if(file != null){
      state = [file, ...state];
    }
  }

  deleteMedia(File file){
    state = [
      for(final f in state)
        if(f.path != file.path) f,

    ];
  }

  pickMultipleFiles() async{
    final files = await _picker.pickMultiMediaFile();
    if(files.isNotEmpty){
      state = [...files, ...state];
    }
  }

}