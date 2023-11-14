import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/text_style.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

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
            height: 100,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ReusableText(
                text: 'TaskTrove by DRB',
                style: appstyle(
                  30,
                  AppConstants.kLight,
                  FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Text(
                  'Welcome! Do you want to start your trove?',
                  textAlign: TextAlign.center,
                  style: appstyle(
                    16,
                    AppConstants.kGreyLight,
                    FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
