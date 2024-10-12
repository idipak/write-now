
import 'package:bhealth/features/notifications/presentation/screens/auto_connect_notifications.dart';
import 'package:bhealth/features/notifications/presentation/screens/connection_request_notifications.dart';
import 'package:bhealth/features/notifications/presentation/screens/reaction_notifications.dart';
import 'package:bhealth/utils/svg_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../widgets/notification_cards.dart';

class NotificationsScreen extends StatelessWidget {
  static const route = '/notifications-screen';
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // NotificationCardGeneral(),
              NotificationTitleButton(title: 'Reactions', onTap: (){
                context.push(ReactionNotifications.route);
              },),
              NotificationCardGeneral(),
              NotificationCardGeneral(),
              NotificationCardGeneral(),
              NotificationCardGeneral(),

              NotificationTitleButton(title: 'Connection Request', onTap: (){
                context.push(ConnectionRequestNotifications.route);
              },),
              NotificationsCardFriendRequest(trailingWidgets: [
                IconButton(onPressed: (){}, icon: SvgPicture.asset(SvgAssets.userCheck)),
                IconButton(onPressed: (){}, icon: SvgPicture.asset(SvgAssets.userCross)),
              ],),

              NotificationTitleButton(title: 'New Connects', onTap: (){
                context.push(AutoConnectNotifications.route);
              },),
              NotificationCardGeneral()

            ],
          ),
        ),
      ),
    );
  }
}

class NotificationTitleButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const NotificationTitleButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyLarge,),
        const Spacer(),
        TextButton(
            onPressed: onTap,
            child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('See All'),
            Icon(Icons.chevron_right_sharp, size: 20,)
          ],
            )
        )
      ],
    );
  }
}

