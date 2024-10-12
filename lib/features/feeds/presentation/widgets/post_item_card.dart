
import 'package:bhealth/features/feeds/data/feeds_services.dart';
import 'package:bhealth/features/feeds/data/models/enriched_post.dart';
import 'package:bhealth/features/feeds/presentation/screens/comment_screen.dart';
import 'package:bhealth/features/feeds/presentation/screens/singl_feed_page.dart';
import 'package:bhealth/features/feeds/presentation/widgets/feed_pictures_slider.dart';
import 'package:bhealth/features/feeds/presentation/widgets/feed_title_section.dart';
import 'package:bhealth/features/feeds/presentation/widgets/share_via_chat_section.dart';
import 'package:bhealth/utils/svg_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';


class PostItemCard extends StatelessWidget {
  final bool byAdmin;
  final EnrichedPost postData;
  PostItemCard({super.key, this.byAdmin = false, required this.postData});

  final ValueNotifier<bool> _isLiked = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    int likesCount = postData.postData.likes;

    return GestureDetector(
      onTap: (){
        context.goNamed(SingleFeedPage.route, extra: postData);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 24),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              byAdmin
                  ? Align(
                  alignment: Alignment.topLeft,
                  child: Text('moksha', style: Theme.of(context).textTheme.titleMedium,))
                  : FeedTitleSection(
                onTap: (){

                },
                name: postData.authorName,
                postTime: postData.postData.creationTimeDifference,
              ),

              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 12),
                child: Text(postData.postData.content, overflow: TextOverflow.ellipsis, maxLines: 3,),
              ),

              if(!byAdmin)
                SizedBox(
                  height: 210,
                  child: FeedPicturesSliders(),
                ),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Consumer(builder: (context, ref, _){
                    return ValueListenableBuilder(valueListenable: _isLiked,
                        builder: (context, liked, _){
                      return TextButton.icon(
                          onPressed: (){
                            if(!liked){
                              try{
                                likesCount += 1;
                                _isLiked.value = !_isLiked.value;
                                ref.read(feedsServicesProvider).likePost('10', postData.postData.postId);
                              }catch(e){
                                debugPrint(e.toString());
                              }
                            }
                            //   showModalBottomSheet(
                            //       context: context,
                            //       isScrollControlled: true,
                            //       builder: (context){
                            //     return Padding(
                            //       padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         mainAxisSize: MainAxisSize.min,
                            //         children: [
                            //           Text('Liked by 24 people', style: Theme.of(context).textTheme.bodyLarge,),
                            //           const SizedBox(height: 12,),
                            //           UserTile(),
                            //           UserTile(),
                            //           UserTile(),
                            //           UserTile(),
                            //           UserTile(),
                            //           UserTile(),
                            //         ],
                            //       ),
                            //     );
                            //   });
                          },
                          icon: SvgPicture.asset(SvgAssets.like,
                            color: liked ? Colors.greenAccent : null,),
                          label: Text('$likesCount'));
                    });
                  }),
                  TextButton.icon(
                      onPressed: (){
                        context.goNamed(CommentScreen.route,
                            pathParameters: {'postId': postData.postData.postId});
                      },
                      icon: SvgPicture.asset(SvgAssets.commentIcon), label: Text('${postData.postData.comments}')),
                  TextButton.icon(
                      onPressed: (){

                        showModalBottomSheet(
                          isScrollControlled: true,
                            enableDrag: true,
                            context: context,
                            builder: (context){
                          return const ShareViaChatSection();
                        });
                      },
                      icon: SvgPicture.asset(SvgAssets.share),
                      label: Text('${postData.postData.shares}')),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  const UserTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(bottom: 0),
      horizontalTitleGap: 8,
      leading: const CircleAvatar(
        radius: 16,
        backgroundImage: AssetImage('assets/temp/avatar.jpeg'),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Darrel Steward', style: Theme.of(context).textTheme.labelMedium,),
          Text('@darrrels', style: Theme.of(context).textTheme.bodySmall,)
        ],
      ),
    );
  }
}


