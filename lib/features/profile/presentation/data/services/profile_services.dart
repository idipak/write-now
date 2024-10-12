
import 'dart:convert';

import 'package:bhealth/features/profile/presentation/data/models/profile_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../../../../../common/network/network_client.dart';

final profileServiceProvider = Provider((ref) {
  final client = ref.watch(networkClientProvider);
  return ProfileService(client);
});

class ProfileService {
  final NetworkClient _client;
  ProfileService(this._client);

  Future<UserProfile?>getProfile(String mobile)async{
    final response = await _client.getRequest('/bhealth/user', queryParameters: {'mob': mobile});
    final data = UserProfileResponse.fromJson(jsonDecode(response.body));
    return data.data;
  }

  Future saveProfile(String profileImage, Map<String, dynamic> data)async{
    final body = {
      'userInfo': jsonEncode(data)
    };
    final profileFile = await MultipartFile.fromPath('profilePicture', profileImage);
    await _client.multiPartRequest('/bhealth/user', [profileFile], body: body);
  }

}