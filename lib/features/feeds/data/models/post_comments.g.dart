// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCommentResponse _$PostCommentResponseFromJson(Map<String, dynamic> json) =>
    PostCommentResponse(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>)
          .map((e) => CommentData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostCommentResponseToJson(
        PostCommentResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

CommentData _$CommentDataFromJson(Map<String, dynamic> json) => CommentData(
      comment: Comment.fromJson(json['comment'] as Map<String, dynamic>),
      authorName: json['author_name'] as String? ?? 'Untitled',
      authorProfile: json['author_profile'] as String?,
      authorMobile: json['author_mob'] as String,
    );

Map<String, dynamic> _$CommentDataToJson(CommentData instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'author_name': instance.authorName,
      'author_profile': instance.authorProfile,
      'author_mob': instance.authorMobile,
    };

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      commentId: json['commentId'] as String,
      content: json['content'] as String,
      postId: json['postId'] as String,
      authorId: json['authorId'] as String,
      creationTime: DateTimeHelper.fromEpoch(json['creationTime'] as int),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'commentId': instance.commentId,
      'content': instance.content,
      'postId': instance.postId,
      'authorId': instance.authorId,
      'creationTime': DateTimeHelper.toEpoch(instance.creationTime),
    };
