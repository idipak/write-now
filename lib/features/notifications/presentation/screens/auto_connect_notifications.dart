import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/svg_assets.dart';
import '../widgets/notification_cards.dart';

enum PopupOptions {option1, option2, option3}

class AutoConnectNotifications extends StatelessWidget {
  static const route = '/auto-connects';
  const AutoConnectNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auto Connects'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4)
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
              margin: const EdgeInsets.only(bottom: 12),
              child: InkWell(child: Text('Most Recent', style: Theme.of(context).textTheme.titleSmall,), onTap: (){
                showModalBottomSheet(context: context, builder: (context){
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: SvgPicture.asset(SvgAssets.feedbackSad),
                        title: Text('Most Recent',
                          style: Theme.of(context).textTheme.labelMedium,),
                      ),

                      ListTile(
                        leading: SvgPicture.asset(SvgAssets.feedbackSad),
                        title: Text('Alphabetical',
                          style: Theme.of(context).textTheme.labelMedium,),
                      ),

                    ],
                  );
                });
              }, ),
            ),

            Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index){
                    return NotificationsCardFriendRequest(
                      showTime: false,
                      trailingWidgets: [
                        IconButton(onPressed: (){}, icon: Icon(Icons.person)),
                        IconButton(onPressed: (){
                          showModalBottomSheet(context: context, builder: (context){
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: SvgPicture.asset(SvgAssets.feedbackSad),
                                  title: Text('Share Kaustav’s Profile',
                                    style: Theme.of(context).textTheme.labelMedium,),
                                ),

                                ListTile(
                                  leading: SvgPicture.asset(SvgAssets.feedbackSad),
                                  title: Text('Remove Kaustav as a connection',
                                    style: Theme.of(context).textTheme.labelMedium,),
                                ),

                                ListTile(
                                  leading: SvgPicture.asset(SvgAssets.feedbackSad),
                                  title: Text('Block Kaustav',
                                    style: Theme.of(context).textTheme.labelMedium,),
                                ),
                              ],
                            );
                          });
                        }, icon: SvgPicture.asset(SvgAssets.menuDots)),
                      ],);
                  }),
            )

          ],
        ),
      ),
    );
  }
}
