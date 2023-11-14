import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/custom_btn.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.kHeight,
      width: AppConstants.kWidth,
      color: AppConstants.kbkDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Image.asset(
              'assets/images/todo.png',
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          CustomBtn(
            onTap: () {},
            height: AppConstants.kHeight * 0.13,
            width: AppConstants.kWidth * 0.9,
            borderColor: AppConstants.kLight,
            text: 'Login with a phone number',
            boxDecoColor: null,
            textStyleColor: AppConstants.kLight,
          )
        ],
      ),
    );
  }
}
