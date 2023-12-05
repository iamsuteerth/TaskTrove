import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/text_style.dart';

showAlertDialog(
    {required BuildContext context,
    required String message,
    required String? btmText}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: ReusableText(
          text: message,
          style: appstyle(
            18,
            AppConstants.kLight,
            FontWeight.w600,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 20.h,
          horizontal: 20.w,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              btmText ?? "OK",
              style: appstyle(
                18,
                AppConstants.kLight,
                FontWeight.w600,
              ),
            ),
          )
        ],
      );
    },
  );
}
