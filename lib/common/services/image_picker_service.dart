
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePickerServiceProvider = Provider((ref) => ImagePickerService());

class ImagePickerService{

  final ImagePicker picker = ImagePicker();

  Future<File?> pickImageFromGallery() async{
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      return File(image.path);
    }
    return null;
  }

  Future<File?> takePhoto() async{
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if(image != null){
      return File(image.path);
    }
    return null;
  }

  Future<File?> takeVideo()async{
    final XFile? video = await picker.pickVideo(source: ImageSource.camera);
    if(video != null){
      return File(video.path);
    }
    return null;
  }


  Future<List<File>> pickMultiMediaFile() async{
    final List<XFile> medias = await picker.pickMultipleMedia();
    return medias.map((e) => File(e.path)).toList();
  }

}