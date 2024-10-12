

import 'package:bhealth/utils/date_time_helper.dart';
import 'package:json_annotation/json_annotation.dart';

part 'enriched_post.g.dart';

@JsonSerializable(explicitToJson: true)
class EnrichedPostResponse{
  final String? message;
  @JsonKey(defaultValue: [])
  final List<EnrichedPost> data;

  EnrichedPostResponse({
    required this.message,
    required this.data
});

  factory EnrichedPostResponse.fromJson(Map<String, dynamic> json) => _$EnrichedPostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EnrichedPostResponseToJson(this);
}

@JsonSerializable()
class EnrichedPost{
  @JsonKey(name: 'postDTO')
  final EnrichedPostData postData;
  @JsonKey(name: 'author_name')
  final String authorName;
  @JsonKey(name: 'author_profile')
  final String? authorProfileImage;
  @JsonKey(name: 'author_mob')
  final String authorMobile;

  EnrichedPost({
    required this.postData,
    required this.authorName,
    required this.authorMobile,
    this.authorProfileImage
});

  factory EnrichedPost.fromJson(Map<String, dynamic> json) => _$EnrichedPostFromJson(json);

  Map<String, dynamic> toJson() => _$EnrichedPostToJson(this);
}

@JsonSerializable()
class EnrichedPostData{
  final String postId;
  final String title;
  final String content;
  final String authorId;
  @JsonKey(toJson: DateTimeHelper.toEpoch, fromJson: DateTimeHelper.fromEpoch)
  final DateTime creationTime;
  final int likes;
  final int shares;
  final int saves;
  final int comments;
  final String? postPicture;

  String get creationTimeDifference {
    final now = DateTime.now();
    int seconds = now.difference(creationTime).inSeconds;
    if (seconds < 60){
      return '$seconds seconds ago';
    } else if (seconds >= 60 && seconds < 3600){
      final minuteDiff = now.difference(creationTime).inMinutes.abs();
      return '$minuteDiff minute${minuteDiff > 1 ? 's': ''} ago';
    } else if (seconds >= 3600 && seconds < 86400){
      final hourDiff = now.difference(creationTime).inHours;
      return '$hourDiff hour${hourDiff > 1 ? 's':''} ago';
    } else{
      final daysDiff = now.difference(creationTime).inDays;
      return '$daysDiff day${daysDiff > 1 ? 's': 's'} ago';
    }
  }

  EnrichedPostData({
    required this.postId,
    required this.title,
    required this.content,
    required this.authorId,
    required this.creationTime,
    required this.likes,
    required this.shares,
    required this.saves,
    required this.comments,
    this.postPicture
});

  factory EnrichedPostData.fromJson(Map<String, dynamic> json) => _$EnrichedPostDataFromJson(json);

  Map<String, dynamic> toJson() => _$EnrichedPostDataToJson(this);
}