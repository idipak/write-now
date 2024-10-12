
import 'package:bhealth/common/widgets/custom_text_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/feeds/presentation/screens/new_post_screen.dart';

class MokshFeedTitleSelection extends StatelessWidget {
  MokshFeedTitleSelection({super.key});

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textController.text = 'Write now...';
    return TextFormFieldFilled(
      hintText: 'Create what you want!',
      borderRadius: 12,
      readOnly: true,
      controller: textController,
      textStyle: Theme.of(context).textTheme.labelLarge,
      onTap: (){
        context.push(NewPostScreen.route);
      },
      // onTapOutside: (pointer){
      //   FocusManager.instance.primaryFocus?.unfocus();
      // },
    );
    // return SizedBox(
    //   width: double.infinity,
    //   child: Card(
    //     margin: const EdgeInsets.only(right: 0),
    //     child: Padding(
    //       padding: const EdgeInsets.all(12.0),
    //       child: Text.rich(
    //         TextSpan(
    //           style: Theme.of(context).textTheme.labelMedium,
    //           children: [
    //             const TextSpan(text: 'choose your ',),
    //             TextSpan(text: 'moksh',
    //               style: Theme.of(context).textTheme.labelLarge,
    //             ),
    //             const TextSpan(text: ' feed',),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
