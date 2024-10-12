import 'package:bhealth/common/widgets/moksh_feed_selection_title.dart';
import 'package:bhealth/features/feeds/data/models/enriched_post.dart';
import 'package:bhealth/features/feeds/presentation/screens/profile_other_user.dart';
import 'package:bhealth/features/feeds/presentation/widgets/feed_title_section.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:go_router/go_router.dart';

import '../widgets/comment_tex_field.dart';

class SingleFeedPage extends StatelessWidget {
  static const route = 'single-fee-page';
  final EnrichedPost postData;
  const SingleFeedPage({super.key, required this.postData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MokshFeedTitleSelection(),
      ),
      body: Card(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FeedTitleSection(
                onTap: (){
                  context.push(ProfileOtherUser.route);
                },
                name: postData.authorName,
                profileImage: postData.authorProfileImage,
                postTime: '12 min ago',
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(postData.postData.content),
              ),

              // if(postData.postData.postPicture != null)
              //   CachedNetworkImage(imageUrl: postData.postData.postPicture!,
              //     width: double.infinity,
              //     fit: BoxFit.cover,
              //   ),

              Image.asset('assets/temp/carousel-item.png',
                width: double.infinity,
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CommentTextField(postId: postData.postData.postId,),
      ),
    );
  }
}
