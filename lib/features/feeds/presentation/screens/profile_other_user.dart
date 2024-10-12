import 'package:bhealth/common/widgets/moksh_feed_selection_title.dart';
import 'package:bhealth/common/widgets/profile_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/svg_assets.dart';
import '../widgets/post_item_card.dart';

class ProfileOtherUser extends StatelessWidget {
  static const route = '/profile-other-user';
  const ProfileOtherUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MokshFeedTitleSelection(),
        actions: [
          ProfileIcon()
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 288,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('assets/temp/carousel-item.png',
                width: double.infinity,
                height: 288,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SliverList(delegate: SliverChildListDelegate([
            Container(
              color: Theme.of(context).cardColor,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Suvra Shaw', style: Theme.of(context).textTheme.titleLarge,),
                          Text('@suvra_', style: Theme.of(context).textTheme.bodySmall?.apply(
                              color: Theme.of(context).colorScheme.shadow.withOpacity(0.5)
                          ),),
                        ],
                      ),
                      const Spacer(),
                      IconButton(onPressed: (){
                      }, icon: SvgPicture.asset(SvgAssets.addUser, height: 28, width: 28,)),
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
                                leading: SvgPicture.asset(SvgAssets.flag),
                                title: Text('Remove Kaustav as a connection',
                                  style: Theme.of(context).textTheme.labelMedium,),
                              ),
                              ListTile(
                                leading: SvgPicture.asset(SvgAssets.flag),
                                title: Text('Mute Kaustav',
                                  style: Theme.of(context).textTheme.labelMedium,),
                              ),
                              ListTile(
                                leading: SvgPicture.asset(SvgAssets.flag),
                                title: Text('Block Kaustav',
                                  style: Theme.of(context).textTheme.labelMedium,),
                              ),
                              const SizedBox(height: 16,)
                            ],
                          );
                        });
                      }, icon: SvgPicture.asset(SvgAssets.menuDots))
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text('Nobody food shift hiring procrastinating your ground win-win-win an me. Canatics long pretend.',),
                  ),

                  TextButton.icon(
                      onPressed: (){},
                      icon: SvgPicture.asset(SvgAssets.userCheck, height: 20, width: 20,),
                      label: Text('13 mutual connections')),

                ],
              ),
            ),

          ])),

          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(delegate: SliverChildListDelegate([
              // PostItemCard(),
              // PostItemCard(),
            ])),
          )
        ],
      ),
    );
  }
}
