import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? buttonIcon;
  final String buttonTitle;
  final double height;
  final bool disabled;
  const PrimaryButton({super.key,
    required this.onPressed,
    this.buttonIcon,
    required this.buttonTitle,
    this.height = 44,
    this.disabled = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: ShapeDecoration(
        color: disabled ? kGrey200 : null,
          gradient: !disabled ? const RadialGradient(
            center: Alignment(1.10, 0.46),
            radius: 0.43,
            colors: [Color(0xFF3454B4), kAppBlue],
          ) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
      child: MaterialButton(
        onPressed: disabled ? null : onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(buttonIcon != null)
              buttonIcon!,
            if(buttonIcon != null)
              const SizedBox(width: 6,),

            Text(buttonTitle, style: Theme.of(context).textTheme.titleSmall?.apply(color: Colors.white),)
          ],
        ),
      ),
    );
  }
}
