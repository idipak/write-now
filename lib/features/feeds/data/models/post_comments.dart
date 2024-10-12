
import 'package:json_annotation/json_annotation.dart';

import '../../../../utils/date_time_helper.dart';
part 'post_comments.g.dart';

@JsonSerializable()
class PostCommentResponse{
  final String? message;
  final List<CommentData> data;

  PostCommentResponse({
    this.message,
    required this.data
});

  factory PostCommentResponse.fromJson(Map<String, dynamic> json) => _$PostCommentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostCommentResponseToJson(this);
}

@JsonSerializable()
class CommentData{
  final Comment comment;
  @JsonKey(name: 'author_name', defaultValue: 'Untitled')
  final String authorName;
  @JsonKey(name: 'author_profile')
  final String? authorProfile;
  @JsonKey(name: 'author_mob')
  final String authorMobile;

  CommentData({
    required this.comment,
    required this.authorName,
    this.authorProfile,
    required this.authorMobile
});

  factory CommentData.fromJson(Map<String, dynamic> json) => _$CommentDataFromJson(json);

  Map<String, dynamic> toJson() => _$CommentDataToJson(this);
}

@JsonSerializable()
class Comment{
  final String commentId;
  final String content;
  final String postId;
  final String authorId;
  @JsonKey(toJson: DateTimeHelper.toEpoch, fromJson: DateTimeHelper.fromEpoch)
  final DateTime creationTime;

  Comment({
   required this.commentId,
   required this.content,
   required this.postId,
   required this.authorId,
   required this.creationTime
});

  String get creationTimeDifference {
    final now = DateTime.now().add(const Duration(seconds: 4));
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

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

}