// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enriched_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnrichedPostResponse _$EnrichedPostResponseFromJson(
        Map<String, dynamic> json) =>
    EnrichedPostResponse(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => EnrichedPost.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$EnrichedPostResponseToJson(
        EnrichedPostResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

EnrichedPost _$EnrichedPostFromJson(Map<String, dynamic> json) => EnrichedPost(
      postData:
          EnrichedPostData.fromJson(json['postDTO'] as Map<String, dynamic>),
      authorName: json['author_name'] as String,
      authorMobile: json['author_mob'] as String,
      authorProfileImage: json['author_profile'] as String?,
    );

Map<String, dynamic> _$EnrichedPostToJson(EnrichedPost instance) =>
    <String, dynamic>{
      'postDTO': instance.postData,
      'author_name': instance.authorName,
      'author_profile': instance.authorProfileImage,
      'author_mob': instance.authorMobile,
    };

EnrichedPostData _$EnrichedPostDataFromJson(Map<String, dynamic> json) =>
    EnrichedPostData(
      postId: json['postId'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      authorId: json['authorId'] as String,
      creationTime: DateTimeHelper.fromEpoch(json['creationTime'] as int),
      likes: json['likes'] as int,
      shares: json['shares'] as int,
      saves: json['saves'] as int,
      comments: json['comments'] as int,
      postPicture: json['postPicture'] as String?,
    );

Map<String, dynamic> _$EnrichedPostDataToJson(EnrichedPostData instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'title': instance.title,
      'content': instance.content,
      'authorId': instance.authorId,
      'creationTime': DateTimeHelper.toEpoch(instance.creationTime),
      'likes': instance.likes,
      'shares': instance.shares,
      'saves': instance.saves,
      'comments': instance.comments,
      'postPicture': instance.postPicture,
    };
