
import 'package:bhealth/common/widgets/moksh_feed_selection_title.dart';
import 'package:bhealth/common/widgets/profile_icon.dart';
import 'package:bhealth/features/auth/controllers/auth_controller.dart';
import 'package:bhealth/features/feeds/controllers/feeds_controller.dart';
import 'package:bhealth/features/feeds/data/feeds_services.dart';
import 'package:bhealth/features/feeds/data/models/enriched_post.dart';
import 'package:bhealth/features/feeds/presentation/widgets/feeds_shimmer.dart';
import 'package:bhealth/features/feeds/presentation/widgets/login_popup.dart';
import 'package:bhealth/utils/svg_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/login_popup_controller.dart';
import '../widgets/post_item_card.dart';

class FeedsDisplayPage extends StatelessWidget {
  static const route = '/feeds-display-page';
  const FeedsDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _){
      final feedsController = ref.watch(feedsProvider);
      return HookBuilder(
        builder: (context) {

          useEffect(() {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              final showLogin = ref.read(loginPopupProvider);
              if(showLogin){
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const LoginPopup();
                    });
              }
            });
            return null;
          }, [key]);

          return Scaffold(
            appBar: AppBar(
              title: MokshFeedTitleSelection(),
              actions: const [
                ProfileIcon()
              ],
            ),
            body: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                child: _buildBody(feedsController, context)
              // child: Column(
              //   children: [
              //     const SizedBox(height: 8,),
              //
              //     feedsController is FeedsLoaded
              //         ? Expanded(
              //         child: ListView(
              //           children: const [
              //             PostItemCard(),
              //             PostItemCard(byAdmin: true,),
              //             PostItemCard()
              //           ],
              //         ),
              //       )
              //         : const Expanded(
              //       child: SingleChildScrollView(
              //         child: Column(
              //           children: [
              //
              //           ],
              //         ),
              //       ),
              //     ),
              //
              //   ],
              // ),
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () async{
            //     final response = await ref.read(feedsServicesProvider).getComments('1');
            //     print(response[0].authorMobile);
            //     // context.push(NewPostScreen.route);
            //   },
            //   child: SvgPicture.asset(SvgAssets.postPen),
            // ),
          );
        }
      );
    });
  }

  Widget _buildBody(FeedsStates feedsStates, BuildContext context){
    if(feedsStates is FeedsLoading){
      return ListView(
        children: const [
          SizedBox(height: 6,),
          FeedsShimmer(),
          FeedsShimmer(hideImageBox: true,),
        ],
      );
    }

    if(feedsStates is FeedsLoaded){
      final List<EnrichedPost> feeds = feedsStates.posts;
      return ListView.builder(
        padding: const EdgeInsets.only(top: 8),
        itemCount: feeds.length,
          itemBuilder: (context, index){
        return PostItemCard(postData: feeds[index],);
      });
    }

    if(feedsStates is FeedsError){
      return Center(child: Text(feedsStates.msg),);
    }

    return const SizedBox();
  }
}
