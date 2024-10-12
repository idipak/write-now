
import 'package:bhealth/features/auth/controllers/auth_controller.dart';
import 'package:bhealth/features/auth/presentation/screens/initializing_screen.dart';
import 'package:bhealth/features/feeds/data/models/enriched_post.dart';
import 'package:bhealth/features/feeds/presentation/screens/comment_screen.dart';
import 'package:bhealth/features/feeds/presentation/screens/feeds_display_page.dart';
import 'package:bhealth/features/feeds/presentation/screens/new_post_screen.dart';
import 'package:bhealth/features/feeds/presentation/screens/profile_other_user.dart';
import 'package:bhealth/features/feeds/presentation/screens/singl_feed_page.dart';
import 'package:bhealth/features/notifications/presentation/screens/auto_connect_notifications.dart';
import 'package:bhealth/features/notifications/presentation/screens/connection_request_notifications.dart';
import 'package:bhealth/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:bhealth/features/notifications/presentation/screens/reaction_notifications.dart';
import 'package:bhealth/features/profile/presentation/data/models/profile_response.dart';
import 'package:bhealth/features/profile/presentation/screens/my_connections.dart';
import 'package:bhealth/features/profile/presentation/screens/my_profile_screen.dart';
import 'package:bhealth/test_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/screens/otp_screen.dart';
import '../features/profile/presentation/screens/create_profile_screen.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider((ref) {
  final authController = ref.watch(authProvider);

  return GoRouter(
    navigatorKey: _navigatorKey,
      debugLogDiagnostics: true,
      initialLocation: FeedsDisplayPage.route,
      routes: [
        GoRoute(
          path: TestPage.route,
        builder: (context, state) => const TestPage()
        ),

        GoRoute(path: InitializingScreen.route,
          builder: (context, state) => const InitializingScreen()
        ),

        GoRoute(
            path: MyProfileScreen.route,
        builder: (context, state) => MyProfileScreen(data: state.extra as UserProfile,)),

        GoRoute(path: MyConnections.route,
        builder: (context, state) => const MyConnections()
        ),

        GoRoute(path: NotificationsScreen.route,
          builder: (context, state) => const NotificationsScreen()
        ),

        GoRoute(path: ReactionNotifications.route,
          builder: (context, state) => const ReactionNotifications()
        ),

        GoRoute(path: AutoConnectNotifications.route,
            builder: (context, state) => const AutoConnectNotifications()
        ),

        GoRoute(path: ConnectionRequestNotifications.route,
            builder: (context, state) => const ConnectionRequestNotifications()
        ),

        GoRoute(
            path: FeedsDisplayPage.route,
            builder: (context, state) => const FeedsDisplayPage(),
          routes: [
            GoRoute(
                name: CommentScreen.route,
                path: '${CommentScreen.route}/:postId',
            builder: (context, state) => CommentScreen(
              postId: state.pathParameters['postId'] as String,
            )),

            GoRoute(
                name: SingleFeedPage.route,
                path: SingleFeedPage.route,
            builder: (context, state) => SingleFeedPage(
                  postData: state.extra as EnrichedPost,
            ))
          ]
        ),

        GoRoute(path: ProfileOtherUser.route,
              builder: (context, state) => const ProfileOtherUser()
        ),

        GoRoute(path: NewPostScreen.route,
        builder: (context, state) => const NewPostScreen()
        ),

        GoRoute(
            path: OTPScreen.route,
            builder: (context, state) => const OTPScreen()
        ),

        GoRoute(
            path: CreateProfileScreen.route,
          builder: (context, state) => CreateProfileScreen(
            profileData: state.extra as UserProfile?,
          )
        )

      ],

    redirect: (context, state){
      if(authController is AuthLoading){
        return InitializingScreen.route;
      }

      if(authController is AuthLoggedIn && authController.userProfile == null){
        return CreateProfileScreen.route;
      }

      return null;
    }
  );
});