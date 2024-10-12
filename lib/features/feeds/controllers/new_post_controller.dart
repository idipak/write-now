
import 'package:bhealth/features/auth/controllers/auth_controller.dart';
import 'package:bhealth/features/feeds/controllers/media_selection_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/feeds_services.dart';

final postCharacterCounterProvider = StateProvider.autoDispose<int>((ref) => 0);

final newPostProvider = StateNotifierProvider((ref) {
  final services = ref.watch(feedsServicesProvider);
  return NewPostController(services, ref);
});

class NewPostController extends StateNotifier<NewPostState>{
  final FeedsServices _services;
  final Ref _ref;
  NewPostController(this._services, this._ref):super(NewPostInitial());

  final TextEditingController postTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  createPost()async{
    if(!formKey.currentState!.validate()){
      return;
    }

    try{
      final media = _ref.read(mediaSelectionProvider);
      if(media.isNotEmpty){
        state = NewPostLoading();
        final auth = _ref.read(authProvider);
        final userId = (auth as AuthLoggedIn).userProfile!.userId;
        await _services.createPost(media.first.path, postTextController.text, userId);
        state = NewPostSuccess();
        _resetFields();
      }else{
        // await _services.createPost(null);
        state = NewPostError('Add at least one media');
      }
    }catch(e){
      print(e.toString());
      state = NewPostError(e.toString());
    }
  }

  _resetFields(){
    _ref.read(mediaSelectionProvider.notifier).state = [];
    postTextController.clear();
  }

}

abstract class NewPostState{}

class NewPostInitial extends NewPostState{}

class NewPostLoading extends NewPostState{}

class NewPostError extends NewPostState{
  final String msg;
  NewPostError(this.msg);
}

class NewPostSuccess extends NewPostState{}