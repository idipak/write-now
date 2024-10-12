
import 'package:bhealth/features/feeds/presentation/widgets/comment_tex_field.dart';
import 'package:bhealth/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/comments_controller.dart';

class CommentScreen extends ConsumerWidget {
  static const route = 'comment-screen';
  final String postId;
  const CommentScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentListController = ref.watch(commentListProvider(postId));

    return commentListController.when(
        data: (data){
          return Scaffold(
            appBar: AppBar(
              title: Text('${data.length} comments'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                  itemCount: data.length,
                  itemBuilder: (context, index){
                    final commentData = data[index];

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage('assets/temp/avatar.jpeg'),
                          ),
                        ),
                        const SizedBox(width: 8,),
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(commentData.authorName, style: Theme.of(context).textTheme.titleSmall,),
                                      const SizedBox(width: 8,),
                                      Text(commentData.comment.creationTimeDifference, style: kFont12Grey,)
                                    ],
                                  ),

                                  const SizedBox(height: 8,),

                                  RichText(
                                      text: TextSpan(
                                          style: kFont12Blue700,
                                          text: '',
                                          // text: 'Sara Finkle ',
                                          children: [
                                            TextSpan(
                                                style: kFont12Blue500,
                                                text: commentData.comment.content
                                            )
                                          ]
                                      ))
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CommentTextField(postId: postId,),
            ),
          );
        },
        error: (error, stack){
          return Scaffold(
            body: Center(child: Text(error.toString()),),
          );
        },
        loading: (){
      return const Scaffold(body: Center(child: CircularProgressIndicator(),));
    });
  }

}
