
import 'package:flutter_riverpod/flutter_riverpod.dart';

final phoneCodeProvider = StateProvider<String>((ref) => '+91');
final flagUrlProvider = StateProvider<String>((ref) => 'flags/in.png');