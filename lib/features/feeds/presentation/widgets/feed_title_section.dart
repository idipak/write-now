import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/svg_assets.dart';

class FeedTitleSection extends StatelessWidget {
  final VoidCallback? onTap;
  final String? profileImage;
  final String name;
  final String postTime;
  const FeedTitleSection({
    super.key,
    this.onTap,
    this.profileImage,
    required this.name,
    required this.postTime
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          // onTap: (){
          //   context.push(ProfileOtherUser.route);
          // },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 22,
                backgroundImage: AssetImage('assets/temp/avatar.jpeg'),
              ),
              const SizedBox(width: 6,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.titleSmall,),
                  Text(postTime, style: Theme.of(context).textTheme.labelSmall,)
                ],
              )
            ],
          ),
        ),

        const Spacer(),

        IconButton(onPressed: (){}, icon: SvgPicture.asset(SvgAssets.addUser)),
        IconButton(
          onPressed: (){
            showModalBottomSheet(context: context, builder: (context){
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: SvgPicture.asset(SvgAssets.feedbackSad),
                    title: Text('Not interested in this type of post',
                      style: Theme.of(context).textTheme.labelMedium,),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(SvgAssets.flag),
                    title: Text('Report this post',
                      style: Theme.of(context).textTheme.labelMedium,),
                  ),
                  const SizedBox(height: 16,)
                ],
              );
            });
          },
          icon: SvgPicture.asset(SvgAssets.menuDots),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        )
      ],
    );
  }
}
