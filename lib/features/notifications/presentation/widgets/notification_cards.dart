import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/app_theme.dart';
import '../../../../utils/colors.dart';


class NotificationsCardFriendRequest extends StatelessWidget {
  final bool showTime;
  final List<Widget> trailingWidgets;
  const NotificationsCardFriendRequest({
    super.key,
    this.showTime = true,
    this.trailingWidgets = const []
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/temp/avatar.jpeg'),
                ),

                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 10,
                      child: SvgPicture.asset('assets/svg/add_user.svg')
                  ),
                )
              ],
            ),

            const SizedBox(width: 8,),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kaustav Roy', style: Theme.of(context).textTheme.titleMedium,),
                  Row(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 8,
                            backgroundImage: AssetImage('assets/temp/avatar.jpeg'),
                          ),
                          Positioned(
                            right: -10,
                            child: CircleAvatar(
                              radius: 8,
                              backgroundImage: AssetImage('assets/temp/avatar.jpeg'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16,),
                      Text('13 mutual connections ', style: Theme.of(context).textTheme.bodySmall,),
                    ],
                  ),

                  if(showTime)
                    Text('1h ago',
                      style: Theme.of(context).textTheme.labelSmall?.apply(color: kDarkBlue),)
                ],
              ),
            ),

            // const Spacer(),
            ...trailingWidgets
          ],
        ),
      ),
    );
  }
}


class NotificationCardGeneral extends StatelessWidget {
  const NotificationCardGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/temp/avatar.jpeg'),
                ),

                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 10,
                      child: SvgPicture.asset('assets/svg/add_user.svg')
                  ),
                )
              ],
            ),

            const SizedBox(width: 8,),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          style: kFont14Blue700,
                          text: 'Kaustav Roy ',
                          children: [
                            TextSpan(
                                style: Theme.of(context).textTheme.bodyMedium,
                                text: 'and 10 others liked your post'
                            )
                          ]
                      )),

                  Text('1h ago',
                    style: Theme.of(context).textTheme.labelSmall?.apply(color: kDarkBlue),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

