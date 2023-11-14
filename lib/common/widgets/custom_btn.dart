import 'package:flutter/material.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/text_style.dart';

class CustomBtn extends StatelessWidget {
  final void Function()? onTap;
  final double height;
  final double width;
  final Color? boxDecoColor;
  final Color borderColor;
  final String text;
  final Color textStyleColor;
  const CustomBtn({
    super.key,
    required this.onTap,
    required this.height,
    required this.width,
    required this.boxDecoColor,
    required this.borderColor,
    required this.text,
    required this.textStyleColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: boxDecoColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(width: 1, color: borderColor),
        ),
        child: Center(
          child: ReusableText(
            text: text,
            style: appstyle(
              18,
              textStyleColor,
              FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
