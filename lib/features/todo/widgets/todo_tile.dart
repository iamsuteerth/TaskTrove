import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/text_style.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    this.color,
    this.title,
    this.description,
    this.start,
    this.end,
    this.editWidget,
    this.delete,
    this.switcher,
  });
  final Color? color;
  final String? title;
  final String? description;
  final String? start, end;
  final Widget? editWidget, switcher;
  final void Function()? delete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(8.h),
            width: AppConstants.kWidth,
            decoration: BoxDecoration(
              color: AppConstants.kGreyLight,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  AppConstants.kRadius,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 80,
                      width: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            AppConstants.kRadius,
                          ),
                        ),
                        // To be made dynamic
                        color: color ?? AppConstants.kRed,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Padding(
                      padding: EdgeInsets.all(8.h),
                      child: SizedBox(
                        width: AppConstants.kWidth * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: title ?? 'Title of Todo',
                              style: appstyle(
                                18,
                                AppConstants.kLight,
                                FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            ReusableText(
                              text: description ?? 'Description of ToDO',
                              style: appstyle(
                                12,
                                AppConstants.kLight,
                                FontWeight.normal,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: AppConstants.kWidth * 0.3,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.3,
                                        color: AppConstants.kGreyDk),
                                    color: AppConstants.kbkDark,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(AppConstants.kRadius),
                                    ),
                                  ),
                                  child: Center(
                                    child: ReusableText(
                                      text: "$start | $end",
                                      style: appstyle(
                                        12,
                                        AppConstants.kLight,
                                        FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20.w),
                                Row(
                                  children: [
                                    SizedBox(child: editWidget),
                                    SizedBox(width: 20.w),
                                    GestureDetector(
                                      onTap: delete,
                                      child: const Icon(
                                          MaterialCommunityIcons.delete_circle),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 0.h),
                  child: switcher,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
