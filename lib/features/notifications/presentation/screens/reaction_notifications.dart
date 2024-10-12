import 'package:flutter/material.dart';

import '../widgets/notification_cards.dart';

class ReactionNotifications extends StatelessWidget {
  static const route = '/reaction-notifications';
  const ReactionNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reactions'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
            itemCount: 8,
            itemBuilder: (context, index){
          return NotificationCardGeneral();
        }),
      ),
    );
  }
}
