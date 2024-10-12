
import 'package:bhealth/common/widgets/custom_text_form_fields.dart';
import 'package:bhealth/common/widgets/primary_button.dart';
import 'package:bhealth/features/auth/controllers/auth_controller.dart';
import 'package:bhealth/features/auth/service/auth_service.dart';
import 'package:bhealth/features/profile/presentation/controllers/auto_connect_controller.dart';
import 'package:bhealth/features/profile/presentation/controllers/profile_picture_controller.dart';
import 'package:bhealth/features/profile/presentation/controllers/user_profile_controller.dart';
import 'package:bhealth/features/profile/presentation/data/models/profile_response.dart';
import 'package:bhealth/features/profile/presentation/widgets/profile_picture_section.dart';
import 'package:bhealth/utils/colors.dart';
import 'package:bhealth/utils/phone_validator.dart';
import 'package:bhealth/utils/svg_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateProfileScreen extends ConsumerWidget {
  static const route = '/crete-profile-screen';
  final UserProfile? profileData;
  CreateProfileScreen({super.key, this.profileData});

  final formKey = GlobalKey<FormState>(debugLabel: 'PROFILE_FORM_KEY');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(profileData != null){
        ref.read(profileEditProvider.notifier).updateUser(profileData);
        ref.read(autoConnectProvider.notifier).state = profileData?.autoAccept ?? false;
      }
    });

    ref.listen(profileEditProvider, (previous, next) {
      if(next is ProfileError){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.msg)));
      }

      if(next is ProfileSavedSuccess){
        ref.read(authProvider.notifier).init();
        // Navigator.popUntil(context, (route) => route.isFirst);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(

          children: [
            const ProfilePictureSection(),

            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    labelText('Name'),
                    TextFormFieldFilled(
                      hintText: 'Enter your name',
                      validator: RequiredValidator(errorText: 'Name required'),
                      controller: ref.read(profileEditProvider.notifier).nameController,
                    ),

                    const SizedBox(height: 16,),

                    Row(
                      children: [
                        labelText('Username'),
                        const Text('*', style: TextStyle(color: Colors.redAccent),)
                      ],
                    ),
                    TextFormFieldFilled(
                      hintText: 'Enter a unique username',
                      validator: MultiValidator([RequiredValidator(errorText: 'Username required'), MinLengthValidator(3, errorText: 'Username too short')]),
                      controller: ref.read(profileEditProvider.notifier).userController,
                    ),

                    const SizedBox(height: 16,),

                    labelText('Bio'),
                    TextFormFieldFilled(
                      maxLines: 3,
                      validator: RequiredValidator(errorText: 'Bio required'),
                      controller: ref.read(profileEditProvider.notifier).bioController,
                      hintText: 'Enter a bio',),

                    const SizedBox(height: 16,),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(SvgAssets.userCheck, height: 20, color: kDarkGrey,),
                          const SizedBox(width: 8,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Auto Connects', style: TextStyle(fontWeight: FontWeight.w700),),
                                Text('Requests will not be automatically accepted.',
                                  style: Theme.of(context).textTheme.labelSmall?.apply(color: kDarkGrey),)
                              ],
                            ),
                          ),

                          Consumer(builder: (context, ref, _){
                            final connectValue = ref.watch(autoConnectProvider);
                            return Switch.adaptive(value: connectValue, onChanged: (val){
                              ref.read(autoConnectProvider.notifier).state = val;
                            });
                          })

                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(SvgAssets.playback),
                          const SizedBox(width: 8,),
                          const Text('Autoplay Videos', style: TextStyle(fontWeight: FontWeight.w700),),
                          const Spacer(),

                          Consumer(builder: (context, ref, _){
                            final connectValue = ref.watch(autoPlayProvider);
                            return Switch.adaptive(value: connectValue, onChanged: (val){
                              ref.read(autoPlayProvider.notifier).state = val;
                            });
                          })

                        ],
                      ),
                    ),

                    ListTile(
                      horizontalTitleGap: 6,
                      titleTextStyle: Theme.of(context).textTheme.titleMedium,
                      contentPadding: const EdgeInsets.all(0),
                      leading: SvgPicture.asset(SvgAssets.info),
                      title: Text('About'),
                    ),

                    ListTile(
                      horizontalTitleGap: 6,
                      titleTextStyle: Theme.of(context).textTheme.titleMedium,
                      contentPadding: const EdgeInsets.all(0),
                      leading: SvgPicture.asset(SvgAssets.question),
                      title: Text('Help'),
                    ),

                    ListTile(
                      onTap: () => _advanceSettings(context),
                      horizontalTitleGap: 6,
                      titleTextStyle: Theme.of(context).textTheme.titleMedium,
                      contentPadding: const EdgeInsets.all(0),
                      leading: SvgPicture.asset(SvgAssets.settingsLinear),
                      title: Text('Advance Settings'),
                    ),


                    const SizedBox(height: 16,),
                    Consumer(builder: (context, ref, _){
                      final controller = ref.watch(profileEditProvider);

                      if(controller is ProfileLoading){
                        return Center(child: const CircularProgressIndicator());
                      }

                      return Row(
                        children: [
                          TextButton.icon(
                              onPressed: (){},
                              icon: SvgPicture.asset(SvgAssets.close),
                              label: Text('Discard')),
                          const SizedBox(width: 16,),
                          Expanded(child: PrimaryButton(
                              height: 48,
                              onPressed: (){
                                // final auth = ref.read(authServiceProvider);
                                // final phone = auth.getLoggedInUser()!.phoneNumber!;
                                final picture = ref.read(profilePictureProvider);
                                if(picture is ProfilePictureLoadedState){
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if(!formKey.currentState!.validate()){
                                    return;
                                  }
                                  // ref.read(profileEditProvider.notifier).saveProfile(
                                  //     phone: phone,
                                  //     profileImagePath: picture.selectedPicture.path,
                                  //     autoAccept: ref.read(autoConnectProvider.notifier).state
                                  // );
                                }else{
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(content: Text('Select a profile picture')));
                                }

                              }, buttonTitle: 'Save Profile'))
                        ],
                      );
                    }),


                  ],
                ),
              ),
            )


          ],
        ),
      ),
    );
  }

  Widget labelText(String text){
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700),),
    );
  }

  _advanceSettings(BuildContext context){
    showModalBottomSheet(context: context, builder: (context){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 16),
            child: Text('Advanced Settings', style: Theme.of(context).textTheme.bodyLarge,),
          ),

          ListTile(
            onTap: () => _logoutDialog(context),
            leading: SvgPicture.asset(SvgAssets.logout),
            title: Text('Logout', style: Theme.of(context).textTheme.labelMedium,),
          ),
          ListTile(
            leading: SvgPicture.asset(SvgAssets.trashBin),
            title: Text('Delete Account', style: Theme.of(context).textTheme.labelMedium,),
          ),

        ],
      );
    });
  }

  _logoutDialog(BuildContext context){
    showDialog(context: context, builder: (context){
      return Consumer(builder: (context, ref, _){
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Are you sure?', style: Theme.of(context).textTheme.bodyLarge,),
            ],
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).popUntil((route) => route.isFirst);
              ref.read(authProvider.notifier).logout();
            }, child: const Text('Yes, Logout')),
            SizedBox(
              width: 140,
              child: PrimaryButton(height: 40, onPressed: (){
                Navigator.of(context).pop();
              }, buttonTitle: 'No'),
            )
          ],
        );
      });
    });
  }

}




