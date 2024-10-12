import 'package:bhealth/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:bhealth/features/profile/presentation/controllers/tab_selection_controller.dart';
import 'package:bhealth/features/profile/presentation/controllers/user_profile_controller.dart';
import 'package:bhealth/features/profile/presentation/data/models/profile_response.dart';
import 'package:bhealth/features/profile/presentation/screens/my_connections.dart';
import 'package:bhealth/utils/colors.dart';
import 'package:bhealth/utils/svg_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../feeds/presentation/widgets/post_item_card.dart';
import 'create_profile_screen.dart';

class MyProfileScreen extends ConsumerWidget {
  static const route = '/my-profile-screen';
  final UserProfile data;
  const MyProfileScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        actions: [
          IconButton(onPressed: (){
            context.push(NotificationsScreen.route);
          }, icon: SvgPicture.asset(SvgAssets.bell))
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

          SliverList(
              delegate: SliverChildListDelegate([
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
                              Text(data.userName, style: Theme.of(context).textTheme.titleLarge,),
                              Text(data.userHandle, style: Theme.of(context).textTheme.bodySmall?.apply(
                                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.5)
                              ),),
                            ],
                          ),
                          const Spacer(),
                          IconButton(onPressed: (){
                            context.push(CreateProfileScreen.route, extra: data);
                          }, icon: SvgPicture.asset(SvgAssets.settingMinimalist))
                        ],
                      ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(data.bio ?? ''),
                        ),
                      ),

                      TextButton.icon(
                          onPressed: (){
                            context.push(MyConnections.route);
                          },
                          icon: SvgPicture.asset(SvgAssets.userCheck, height: 20, width: 20,),
                          label: Text('13 connections')),

                    ],
                  ),
                ),

                Consumer(builder: (context, ref, _){
                  final tabController = ref.watch(tabProvider);
                  return Row(
                    children: [
                      Expanded(
                          child: ProfileTabButton(
                            active: tabController == ProfileTab.myPost,
                            titleText: 'My Posts',
                            countText: '39',
                            svgPath: SvgAssets.postPen,
                            onTap: (){
                              ref.read(tabProvider.notifier).state = ProfileTab.myPost;
                            },
                          )
                      ),

                      Expanded(child: ProfileTabButton(
                        active: tabController  == ProfileTab.savedPost,
                        titleText: 'Saved Posts',
                        countText: '13',
                        svgPath: SvgAssets.bookmark,
                        onTap: (){
                          ref.read(tabProvider.notifier).state = ProfileTab.savedPost;
                        },
                      ))
                    ],
                  );
                }),
              ])),

          Consumer(builder: (context, ref, _){
            final tabController = ref.watch(tabProvider);
            if(tabController == ProfileTab.myPost){
              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                sliver: SliverList(delegate: SliverChildListDelegate([
                  // PostItemCard(),
                  // PostItemCard(),
                ])),
              );
            }else{
              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                sliver: SliverList(delegate: SliverChildListDelegate([
                  // PostItemCard(byAdmin: true,),
                  // PostItemCard(),
                ])),
              );
            }

          }),


        ],
      )
      // body: Column(
      //   children: [

          // GestureDetector(
          //   onTap: (){
          //     context.push(CreateProfileScreen.route);
          //   },
          //   child: Card(
          //     child: Padding(
          //       padding: const EdgeInsets.all(12.0),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text('Suvra Shaw', style: Theme.of(context).textTheme.titleLarge,),
          //           Text('@suvra_', style: Theme.of(context).textTheme.bodySmall,),
          //           const SizedBox(height: 12,),
          //
          //           Image.asset('assets/temp/carousel-item.png', height: 304, fit: BoxFit.fill,),
          //
          //           Padding(
          //             padding: const EdgeInsets.symmetric(vertical: 12.0),
          //             child: Text(lorem(paragraphs: 1, words: 12)),
          //           ),
          //
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               TextButton.icon(onPressed: (){}, icon: Icon(Icons.person), label: Text('234')),
          //               TextButton.icon(onPressed: (){}, icon: Icon(Icons.bookmark), label: Text('55')),
          //               TextButton.icon(onPressed: (){}, icon: Icon(Icons.doorbell), label: Text('22')),
          //             ],
          //           )
          //
          //         ],
          //       ),
          //     ),
          //   ),
          // )
      //   ],
      // ),
    );
  }
}

class ProfileTabButton extends StatelessWidget {
  final bool active;
  final String titleText;
  final String countText;
  final String svgPath;
  final VoidCallback onTap;
  const ProfileTabButton({super.key,
    this.active = false,
    required this.titleText,
    required this.countText,
    required this.svgPath,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: active
          ? Theme.of(context).scaffoldBackgroundColor
          : Theme.of(context).cardColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
              color: active
                  ? Theme.of(context).cardColor
                  : Theme.of(context).scaffoldBackgroundColor,
              borderRadius: active
                  ? const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))
                  : const BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(svgPath,
                color: active ? Theme.of(context).primaryColor : kDarkGrey,
              ),
              const SizedBox(width: 8,),
              Text.rich(TextSpan(
                  style: Theme.of(context).textTheme.titleSmall?.apply(
                      color: active ? Theme.of(context).primaryColor : kDarkGrey),
                  text: '$titleText  ',
                  children: [
                    TextSpan(text: countText, style: const TextStyle(fontWeight: FontWeight.w400))
                  ]
              )),
            ],
          ),
        ),
      ),
    );
  }
}

