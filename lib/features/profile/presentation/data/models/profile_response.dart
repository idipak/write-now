
class UserProfileResponse {
  final String? message;
  final UserProfile? data;

  UserProfileResponse({
    this.message,
    required this.data,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) => UserProfileResponse(
    message: json["message"],
    data: json["data"] == null ? null : UserProfile.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
  };
}

class UserProfile {
  String userId;
  String userName;
  String userHandle;
  String mob;
  String gender;
  String age;
  String? bio;
  String? profilePhoto;
  bool autoAccept;

  UserProfile({
    required this.userId,
    required this.userName,
    required this.userHandle,
    required this.mob,
    required this.gender,
    required this.age,
    this.bio,
    this.profilePhoto,
    required this.autoAccept,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    userId: json["userId"],
    userName: json["userName"],
    userHandle: json["userHandle"],
    mob: json["mob"],
    gender: json["gender"],
    age: json["age"],
    bio: json["bio"],
    profilePhoto: json["profile_photo"],
    autoAccept: json["auto_accept"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "userName": userName,
    "userHandle": userHandle,
    "mob": mob,
    "gender": gender,
    "age": age,
    "bio": bio,
    "profile_photo": profilePhoto,
    "auto_accept": autoAccept,
  };
}
