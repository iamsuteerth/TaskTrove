import 'package:flutter/material.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/text_style.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  const CustomTextField({
    super.key,
    this.keyboardType,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.hintStyle,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.kWidth * 0.9,
      decoration: BoxDecoration(
        color: AppConstants.kLight,
        borderRadius: BorderRadius.all(
          Radius.circular(AppConstants.kRadius),
        ),
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        cursorHeight: 25,
        onChanged: onChanged,
        style: appstyle(
          18,
          AppConstants.kbkDark,
          FontWeight.w700,
        ),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon != null
              ? CircleAvatar(
                  // Fix because otherwise, the widget was not aligning properly
                  radius: AppConstants.kWidth * 0.08,
                  backgroundColor: Colors.transparent,
                  child: prefixIcon,
                )
              : null,
          suffixIconColor: AppConstants.kbkDark,
          hintStyle: hintStyle,
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppConstants.kRed, width: 0.5),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.transparent, width: 0.5),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppConstants.kRed, width: 0.5),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppConstants.kGreyDk, width: 0.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppConstants.kbkDark, width: 0.5),
          ),
        ),
      ),
    );
  }
}
