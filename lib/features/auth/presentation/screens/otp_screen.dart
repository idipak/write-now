import 'package:bhealth/common/widgets/moksh_feed_selection_title.dart';
import 'package:bhealth/common/widgets/primary_button.dart';
import 'package:bhealth/common/widgets/profile_icon.dart';
import 'package:bhealth/features/auth/controllers/mobile_login_controller.dart';
import 'package:bhealth/features/auth/controllers/phone_code_controller.dart';
import 'package:bhealth/utils/colors.dart';
import 'package:bhealth/utils/phone_validator.dart';
import 'package:bhealth/utils/svg_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';

import '../../../../common/widgets/custom_text_form_fields.dart';
import '../widgets/country_list.dart';

class OTPScreen extends ConsumerWidget {
  static const route = '/otp-screen';
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginController = ref.watch(mobileLoginProvider);
    ref.listen(mobileLoginProvider, (previous, next) {
      print(next.toString());
      if(next is MobileLoginError){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.msg)));
      }
      if(next is MobileVerified){
        if(context.mounted){
          Navigator.of(context).pop();
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MokshFeedTitleSelection(),
        actions: const [
          ProfileIcon()
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 0),
          child: Column(
            children: [

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('moksh', style: Theme.of(context).textTheme.titleMedium,),
                      Text(lorem(paragraphs: 2, words: 50))
                    ],
                  ),
                ),
              ),

             AnimatedSwitcher(
                 duration: const Duration(milliseconds: 600),
               transitionBuilder: (Widget child, Animation<double> animation){
                   return ScaleTransition(scale: animation, child: child,);
               },
               child: loginController is MobileLoginInitialState
                   ? const MobileInputSection()
                   : const OTPInputSection()
             ),

            ],

          ),
        ),
      ),
    );
  }
}

class MobileInputSection extends ConsumerWidget {
  const MobileInputSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter your mobile number', style: Theme.of(context).textTheme.bodyLarge,),

            Form(
              key: ref.read(mobileLoginProvider.notifier).formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextFormFieldFilled(
                  filledColor: kWhit100,
                  hintText: 'XXXXX XXXXX',
                  controller: ref.read(mobileLoginProvider.notifier).mobileController,
                  keyboardType: TextInputType.number,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Required field'),
                    PhoneValidator(errorText: 'Invalid mobile number')
                  ]),
                  leadingIcon: GestureDetector(
                    onTap: (){
                      showModalBottomSheet(context: context, builder: (context){
                        return SizedBox(
                          height: 400,
                          child: Consumer(
                            builder: (context, ref, _){
                              final selectedDialCode = ref.watch(phoneCodeProvider);
                              return  Column(
                                children: [
                                  Expanded(
                                    child: CountryList(groupValue: selectedDialCode, onSelection: (dialCode, flagImage){
                                      ref.read(phoneCodeProvider.notifier).state = dialCode;
                                      ref.read(flagUrlProvider.notifier).state = flagImage;
                                      Navigator.of(context).pop();
                                    },),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 4,),
                        Consumer(builder: (context, ref, _){
                          final flagImage = ref.watch(flagUrlProvider);
                          return CircleAvatar(
                            radius: 14,
                            backgroundImage: AssetImage(flagImage, package: 'country_list_pick',),
                          );
                        }),
                        const Icon(Icons.keyboard_arrow_down, color: kAppBlue, size: 20,)
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Consumer(builder: (context, ref, _){
              final controller = ref.watch(mobileLoginProvider);

              if(controller is MobileLoginLoading){
                return const Center(child: CircularProgressIndicator());
              }

              return PrimaryButton(
                  onPressed: (){
                    FocusManager.instance.primaryFocus?.unfocus();
                    ref.read(mobileLoginProvider.notifier).sendOtp();
                  },
                  buttonIcon: SvgPicture.asset(SvgAssets.sendOtp),
                  buttonTitle: 'Send OTP');
            })

          ],
        ),
      ),
    );
  }
}



class OTPInputSection extends ConsumerWidget {
  const OTPInputSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultPinTheme = PinTheme(
      height: 40,
      width: 44,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Please enter OTP below', style: Theme.of(context).textTheme.bodyLarge,),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Pinput(
                controller: ref.read(mobileLoginProvider.notifier).otpController,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                preFilledWidget: const Text('-'),
                defaultPinTheme: defaultPinTheme,
                length: 6,
              ),
            ),

            Consumer(builder: (context, ref, _){
              final controller = ref.watch(mobileLoginProvider);

              if(controller is MobileLoginLoading){
                return const Center(child: CircularProgressIndicator());
              }

              return Row(
                children: [
                  TextButton.icon(onPressed: (){
                    ref.read(mobileLoginProvider.notifier).sendOtp(resend: true);
                  },
                      icon: SvgPicture.asset(SvgAssets.reload),
                      label: const Text('Resend')),

                  Expanded(child: PrimaryButton(onPressed: (){
                    ref.read(mobileLoginProvider.notifier).verifyOtp();
                  },
                    buttonIcon: SvgPicture.asset(SvgAssets.otpConfirm),
                    buttonTitle: 'Confirm OTP', ))
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}

