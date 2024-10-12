

import 'package:flutter_riverpod/flutter_riverpod.dart';

final autoConnectProvider = StateProvider<bool>((ref) => false);

final autoPlayProvider = StateProvider<bool>((ref) => false);