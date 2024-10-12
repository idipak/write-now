

import 'package:bhealth/features/feeds/data/feeds_services.dart';
import 'package:bhealth/features/feeds/data/models/post_comments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commentListProvider = FutureProvider.family<List<CommentData>, String>((ref, postId) async{
  final service = ref.watch(feedsServicesProvider);
  return await service.getComments(postId);
});

final postCommentProvider = StateNotifierProvider.autoDispose((ref){
  final services = ref.watch(feedsServicesProvider);
  return PostCommentController(services);
});

class PostCommentController extends StateNotifier<PostCommentState>{
  final FeedsServices _services;
  PostCommentController(this._services):super(PostCommentInitial());

  final TextEditingController commentTextController = TextEditingController();

  Future<void> postComment(String postId, String authorId)async{
    print("COMMENT: ${commentTextController.text}");
    if(commentTextController.text.isEmpty){
      state = PostCommentError('Comment text cannot be empty!');
      return;
    }
    try{
      state = PostCommentProgress();
      await _services.postComment(commentTextController.text, postId, authorId);
      commentTextController.clear();
      state = PostCommentInitial();
    }catch(e){
      state = PostCommentError(e.toString());
    }
  }

}

abstract class PostCommentState{}

class PostCommentInitial extends PostCommentState{}

class PostCommentProgress extends PostCommentState{}

class PostCommentError extends PostCommentState{
  final String msg;
  PostCommentError(this.msg);
}