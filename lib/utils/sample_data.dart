import 'package:flutter_lorem/flutter_lorem.dart';

import '../features/feeds/data/models/enriched_post.dart';
import '../features/feeds/data/models/post_comments.dart';
import '../features/profile/presentation/data/models/profile_response.dart';

final testUser = UserProfile(
    userId: "1",
    userName: 'Dipak',
    userHandle: 'dipak',
    mob: '9999123456',
    gender: "Male",
    age: "29",
    autoAccept: true);

final samplePosts = [
  EnrichedPost(
      postData: EnrichedPostData(
          postId: "postId",
          title: lorem(words: 5),
          content: lorem(words: 100),
          authorId: "authorId",
          creationTime: DateTime.now().subtract(const Duration(hours: 2)),
          likes: 20,
          shares: 22,
          saves: 30,
          comments: 35),
      authorName: "Dipak",
      authorMobile: "authorMobile"),
  EnrichedPost(
      postData: EnrichedPostData(
          postId: "postId",
          title: lorem(words: 5),
          content: lorem(words: 50),
          authorId: "authorId",
          creationTime: DateTime.now().subtract(const Duration(days: 1)),
          likes: 130,
          shares: 220,
          saves: 30,
          comments: 60),
      authorName: "Dipak",
      authorMobile: "authorMobile")
];

final sampleComments = [
  CommentData(
      comment: Comment(
          commentId: "2",
          content: lorem(paragraphs: 1, words: 20),
          postId: "0",
          authorId: "authorId",
          creationTime: DateTime.now()),
      authorName: "authorName",
      authorMobile: "9999342345")
];
