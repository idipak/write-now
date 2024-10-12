import 'package:bhealth/features/feeds/controllers/comments_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/svg_assets.dart';

class CommentTextField extends ConsumerWidget {
  final String postId;
  const CommentTextField({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(postCommentProvider);
    
    return TextFormField(
      controller: ref.read(postCommentProvider.notifier).commentTextController,
      decoration: InputDecoration(
          prefixIcon: IconButton(
            onPressed: (){
              _commentChoiceDialog(context);
            },
            icon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(SvgAssets.global),
                const Icon(Icons.keyboard_arrow_down, size: 20, color: kAppBlue,)
              ],
            ),
          ),
          suffixIcon: IconButton(
              onPressed: (){
                if(controller is PostCommentProgress){
                  return;
                }
                FocusManager.instance.primaryFocus?.unfocus();
                //TODO: Remove constant authorID
                ref.read(postCommentProvider.notifier).postComment(postId, '10').then((value){
                  ref.invalidate(commentListProvider);
                });
              },
              icon: SvgPicture.asset(SvgAssets.sendButton,
                // color: Colors.redAccent,
                colorFilter: controller is PostCommentProgress
                ?  const ColorFilter.mode(Colors.grey, BlendMode.srcATop)
                    : null,
              )),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintText: 'Type a Comment...',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: kAppBlue)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: kAppBlue)
          )
      ),
    );
  }

  _commentChoiceDialog(BuildContext context){
    showModalBottomSheet(context: context, builder: (context){
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 16),
            child: Text('How do you want to comment?', style: Theme.of(context).textTheme.bodyLarge,),
          ),

          _commentTypeSelectionTile(context, 'Leave a public comment', SvgAssets.global),
          _commentTypeSelectionTile(context, 'Send a private message via Chat', SvgAssets.msgText),
          const SizedBox(height: 16,)

        ],
      );
    });
  }

  _commentTypeSelectionTile(BuildContext context, String title, String iconPath){
    return RadioListTile(
      dense: true,
      controlAffinity: ListTileControlAffinity.trailing,
      value: 'value', groupValue: 'groupValue', onChanged: (val){},
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(iconPath),
          const SizedBox(width: 8,),
          Text(title, style: Theme.of(context).textTheme.labelMedium,)
        ],
      ),
    );
  }


}
