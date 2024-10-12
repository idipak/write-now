
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ProfileTab {myPost, savedPost}
final tabProvider = StateProvider<ProfileTab>((ref) => ProfileTab.myPost);