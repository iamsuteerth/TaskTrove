import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/text_style.dart';
import 'package:todo/features/todo/controllers/todo_provider.dart';

class BottomTitles extends StatelessWidget {
  const BottomTitles({
    super.key,
    required this.text,
    required this.text2,
    this.color,
  });
  final String text;
  final String text2;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConstants.kWidth,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer(
              builder: (context, ref, child) {
                var color =
                    ref.read(todoStateProvider.notifier).getRandomColor();
                return Container(
                  height: 80,
                  width: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        AppConstants.kRadius,
                      ),
                    ),
                    // To be made dynamic
                    color: color,
                  ),
                );
              },
            ),
            SizedBox(width: 15.w),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: text,
                    style: appstyle(
                      22,
                      AppConstants.kLight,
                      FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ReusableText(
                    text: text2,
                    style: appstyle(
                      12,
                      AppConstants.kLight,
                      FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
