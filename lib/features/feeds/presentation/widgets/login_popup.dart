
import 'package:bhealth/utils/svg_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/primary_button.dart';
import '../../../auth/presentation/screens/otp_screen.dart';

class LoginPopup extends StatelessWidget {
  const LoginPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(SvgAssets.illustration),

          const Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('To unlock all features, please log in!'),
              )),

          PrimaryButton(onPressed: (){
            Navigator.pop(context);
            context.push(OTPScreen.route);
          }, buttonTitle: 'Log In')
        ],
      ),
    );
  }
}
