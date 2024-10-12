import 'dart:io';

import 'package:bhealth/common/widgets/custom_text_form_fields.dart';
import 'package:bhealth/common/widgets/primary_button.dart';
import 'package:bhealth/features/feeds/controllers/media_selection_controller.dart';
import 'package:bhealth/features/feeds/controllers/new_post_controller.dart';
import 'package:bhealth/utils/phone_validator.dart';
import 'package:bhealth/utils/svg_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewPostScreen extends ConsumerWidget {
  static const route = '/new-post-screen';
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const maxPostLength = 340;
    ref.listen(newPostProvider, (_, next) {
      if(next is NewPostError){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.msg)));
      }

      if(next is NewPostSuccess){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Post created successfully!')));
        if(context.mounted){
          Navigator.of(context).pop();
        }
      }

    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pour your heart out!'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Form(
                    key: ref.read(newPostProvider.notifier).formKey,
                    child: TextFormFieldFilled(
                      controller: ref.read(newPostProvider.notifier).postTextController,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Cannot be empty'),
                      MaxLengthValidator(maxPostLength, errorText: 'Reduce some text')
                    ]),
                    maxLines: 13,
                    helperText: '',
                    hintText: 'Type here...',
                    onChanged: (val){
                      ref.read(postCharacterCounterProvider.notifier).state = val.length;
                    },
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),),
                  Positioned(
                      bottom: 28,
                      right: 12,
                      child: Opacity(
                        opacity: 0.6,
                        child: Consumer(
                          builder: (context, ref, _){
                            final counter = ref.watch(postCharacterCounterProvider);
                            return Text('$counter/$maxPostLength',
                              style: counter <= maxPostLength
                                  ? Theme.of(context).textTheme.bodySmall
                                  : Theme.of(context).textTheme.bodySmall?.apply(color: Colors.red),);
                          },
                        )
                      ))
                ],
              ),

              const MediaSelectionSection(),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
        child: Consumer(
          builder: (context, ref, _){
            final controller = ref.watch(newPostProvider);

            if(controller is NewPostLoading){
              return const SizedBox(
                  height: 48,
                  width: 48,
                  child: Center(child: CircularProgressIndicator()));
            }

            return PrimaryButton(
                height: 48,
                onPressed: (){
                  ref.read(newPostProvider.notifier).createPost();
                }, buttonTitle: 'Create');
          },
        )
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Expanded(child: SizedBox(
        //         height: 34,
        //         child: Center(
        //             child: TextButton(
        //           onPressed: (){
        //
        //           },
        //           child: Text('Find', style: Theme.of(context).textTheme.titleMedium,),
        //         )))),
        //
        //     SizedBox(
        //         width: 196,
        //         child: PrimaryButton(onPressed: (){
        //           ref.read(newPostProvider.notifier).createPost();
        //         }, buttonTitle: 'Create'))
        //   ],
        // ),
      ),
    );
  }
}


class MediaSelectionSection extends ConsumerWidget {
  const MediaSelectionSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<File> mediaList = ref.watch(mediaSelectionProvider);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text('Add Media', style: Theme.of(context).textTheme.bodySmall,),
            ),
            // Row(
            //   children: [
            //     const Spacer(),
            //     TextButton(onPressed: (){
            //       ref.read(mediaSelectionProvider.notifier).pickMultipleFiles();
            //     },
            //         child: Text('View Gallery',
            //             style: Theme.of(context).textTheme.titleMedium))
            //   ],
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: _MediaSelectionButton(
                    title: 'Capture a moment',
                    svgPath: SvgAssets.camera,
                    onTap: (){
                      ref.read(mediaSelectionProvider.notifier).captureMoment();
                    },
                  ),
                ),
                const SizedBox(width: 12,),
                Expanded(
                  child: _MediaSelectionButton(
                    title: 'Add from Gallery',
                    svgPath: SvgAssets.imageAdd,
                    onTap: (){
                      ref.read(mediaSelectionProvider.notifier).addFromGallery();
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12,),

            if(mediaList.isNotEmpty)
            SizedBox(
              height: 92,
              child: ListView.builder(
                  itemCount: mediaList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    final media = mediaList[index];
                    return Container(
                      height: 92,
                      width: 92,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(image: FileImage(media), fit: BoxFit.cover)
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Spacer(),
                              InkWell(
                                onTap: (){
                                  ref.read(mediaSelectionProvider.notifier).deleteMedia(media);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: CircleAvatar(
                                    backgroundColor: Theme.of(context).primaryColor,
                                    radius: 12,
                                    child: SvgPicture.asset(SvgAssets.deleteMediaBin, height: 12,),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      // child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(8),
                      //     child: Image.file(media)),

                    );
                  }),
            ),

            // Row(
            //   children: [
            //     GestureDetector(
            //       onTap: (){
            //         ref.read(mediaSelectionProvider.notifier).pickMedia();
            //       },
            //       child: Container(
            //         height: 92,
            //         width: 92,
            //         margin: const EdgeInsets.only(right: 8),
            //         decoration: BoxDecoration(
            //             color: Theme.of(context).scaffoldBackgroundColor,
            //             borderRadius: BorderRadius.circular(8)
            //         ),
            //         child: Center(
            //           child: Icon(Icons.camera_alt),
            //         ),
            //       ),
            //     ),
            //
            //     Expanded(child: SizedBox(
            //       height: 92,
            //       child: ListView.builder(
            //           itemCount: mediaList.length,
            //           scrollDirection: Axis.horizontal,
            //           itemBuilder: (context, index){
            //             final media = mediaList[index];
            //             return Container(
            //               height: 92,
            //               width: 92,
            //               margin: const EdgeInsets.only(right: 8),
            //               decoration: BoxDecoration(
            //                   color: Theme.of(context).scaffoldBackgroundColor,
            //                   borderRadius: BorderRadius.circular(8),
            //                 image: DecorationImage(image: FileImage(media))
            //               ),
            //               child: Column(
            //                 children: [
            //                   Row(
            //                     children: [
            //                       const Spacer(),
            //                       Padding(
            //                         padding: const EdgeInsets.all(4.0),
            //                         child: CircleAvatar(
            //                           backgroundColor: Theme.of(context).primaryColor,
            //                           radius: 14,
            //                           child: Icon(Icons.delete_outline, color: Colors.white, size: 14,),
            //                         ),
            //                       )
            //                     ],
            //                   )
            //                 ],
            //               ),
            //               // child: ClipRRect(
            //               //     borderRadius: BorderRadius.circular(8),
            //               //     child: Image.file(media)),
            //
            //             );
            //           }),
            //     ),)
            //   ],
            // ),


            // const SizedBox(height: 8,),
            // Text('*applicable for creation only',
            //   style: Theme.of(context).textTheme.labelSmall?.apply(color: kDarkGrey),)

          ],
        ),
      ),
    );
  }
}

class _MediaSelectionButton extends StatelessWidget {
  final String title;
  final String svgPath;
  final VoidCallback onTap;
  const _MediaSelectionButton({
    // super.key,
    required this.title,
  required this.svgPath,
  required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: ShapeDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.28),
          ),
        ),
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(svgPath, height: 20, width: 20,),
            const SizedBox(width: 4),
            Text(title,
                style: Theme.of(context).textTheme.titleSmall
            ),
          ],
        ),
      ),
    );
  }
}

