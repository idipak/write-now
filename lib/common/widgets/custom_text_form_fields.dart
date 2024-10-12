import 'package:flutter/material.dart';


class TextFormFieldFilled extends StatelessWidget {
  final Color filledColor;
  final String? hintText;
  final Widget? leadingIcon;
  final int? maxLines;
  final EdgeInsetsGeometry contentPadding;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final void Function(PointerDownEvent)? onTapOutside;
  final double borderRadius;
  final TextStyle? textStyle;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? helperText;
  const TextFormFieldFilled({
    super.key,
    this.filledColor = Colors.white,
    this.hintText,
    this.leadingIcon,
    this.maxLines,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    this.onChanged,
    this.controller,
    this.validator,
    this.keyboardType,
    this.focusNode,
    this.onTapOutside,
    this.borderRadius = 8.0,
    this.textStyle,
    this.readOnly = false,
    this.helperText,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      onChanged: onChanged,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      onTapOutside: onTapOutside,
      style: textStyle,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
          fillColor: filledColor,
          filled: true,
          hintText: hintText,
          prefixIcon: leadingIcon,
          contentPadding: contentPadding,
          helperText: helperText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide.none
          )
      ),
    );
  }
}

