import 'dart:convert';

import 'package:bhealth/common/network/network_client.dart';
import 'package:bhealth/features/feeds/data/models/post_comments.dart';
import 'package:bhealth/utils/sample_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'models/enriched_post.dart';

final feedsServicesProvider = Provider((ref) {
  final client = ref.watch(networkClientProvider);
  return FeedsServices(client);
});

class FeedsServices {
  final NetworkClient _client;

  FeedsServices(this._client);

  Future<void> delay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<List<EnrichedPost>> getEnrichedPost(String mobId) async {
    await delay();
    return samplePosts;
  }

  Future<void> postComment(String comment, postId, authorId) async {
    try {
      await delay();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CommentData>> getComments(String postId) async {
    try {
      await delay();
      return sampleComments;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> likePost(String userId, String postId) async {
    try {
      await delay();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> createPost(String filePath, content, authorId) async {
    await delay();
  }
}
