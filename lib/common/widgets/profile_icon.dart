import 'package:bhealth/features/auth/controllers/auth_controller.dart';
import 'package:bhealth/features/profile/presentation/screens/my_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/feeds/presentation/widgets/login_popup.dart';

class ProfileIcon extends ConsumerWidget {
  final EdgeInsets margin;

  const ProfileIcon(
      {super.key, this.margin = const EdgeInsets.only(right: 12)});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    return GestureDetector(
      onTap: () {
        if (auth is AuthLoggedIn && auth.userProfile != null) {
          context.push(MyProfileScreen.route, extra: auth.userProfile);
        } else {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return const LoginPopup();
              });
        }
      },
      child: Container(
        width: 48,
        height: 48,
        margin: margin,
        padding: const EdgeInsets.all(4),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
        ),
        child: auth is AuthLoggedIn
            ? Image.asset(
                "assets/temp/avatar.jpeg",
                height: 46,
                width: 46,
                fit: BoxFit.fill,
              )
            : const Icon(
          size: 46,
            Icons.account_circle),
      ),
    );
  }
}
