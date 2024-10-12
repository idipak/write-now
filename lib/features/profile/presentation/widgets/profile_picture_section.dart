
import 'package:bhealth/features/profile/presentation/controllers/profile_picture_controller.dart';
import 'package:bhealth/utils/svg_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/widgets/primary_button.dart';
import '../../../../utils/colors.dart';

class ProfilePictureSection extends ConsumerWidget {
  const ProfilePictureSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(profilePictureProvider);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 260,
          width: double.infinity,
          color: Colors.white,
          child: controller is ProfilePictureLoadedState
              ? Image.file(controller.selectedPicture, fit: BoxFit.cover,)
              : pictureUploadButtons(context, ref),
        ),

        if(controller is ProfilePictureLoadedState)
        Positioned(
            bottom: -26,
            right: 20,
            child: IconButton(
              onPressed: (){
                ref.read(profilePictureProvider.notifier).chooseFromGallery();
              },
              icon: Container(
                height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)
                    ),
                    gradient: const RadialGradient(
                      center: Alignment(1.10, 0.46),
                      radius: 0.43,
                      colors: [Color(0xFF3454B4), Color(0xFF4169E1)],
                    ),
                  ),
                  child: SvgPicture.asset(SvgAssets.galleryEdit)),
            ))
      ],
    );
  }

  Widget pictureUploadButtons(BuildContext context, WidgetRef ref){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          profileImageButton(context, 'Take a photo', SvgAssets.camera,
                  (){
            ref.read(profilePictureProvider.notifier).takePhoto();
          }),
          profileImageButton(context, 'View Gallery', SvgAssets.imageAdd, (){
            ref.read(profilePictureProvider.notifier).chooseFromGallery();
          }),
        ],
      ),
    );
  }

  Widget cameraAccessPermission(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Add a profile photo'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Allow moksha to access your device storage so it can upload a profile photo. You can always change this in your device\'s settings.',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: kGrey200,),
              textAlign: TextAlign.center,
            ),
          ),
          PrimaryButton(
              onPressed: (){},
              height: 32,
              buttonTitle: 'Allow access')
        ],
      ),
    );
  }

  Widget profileImageButton(BuildContext context, String title, String iconUrl, VoidCallback onTap){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).scaffoldBackgroundColor
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconUrl),
            const SizedBox(height: 16,),
            Text(title, style: Theme.of(context).textTheme.labelMedium,)
          ],
        ),
      ),
    );
  }

}
