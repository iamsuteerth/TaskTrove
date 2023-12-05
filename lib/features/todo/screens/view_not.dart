import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/text_style.dart';

class NotificationsPage extends StatelessWidget {
  final String? payload;
  const NotificationsPage({super.key, this.payload});

  @override
  Widget build(BuildContext context) {
    var title = payload?.split('|')[0];
    var desc = payload?.split('|')[1];
    var start = payload?.split('|')[3];
    var finish = payload?.split('|')[4];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none, // We want to overlap
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Container(
                width: AppConstants.kWidth,
                height: AppConstants.kHeight * 0.7,
                decoration: BoxDecoration(
                  color: AppConstants.kBkLight,
                  borderRadius: BorderRadius.circular(AppConstants.kRadius),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: 'Reminder',
                        style: appstyle(
                          40,
                          AppConstants.kLight,
                          FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        width: AppConstants.kWidth,
                        padding: const EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          color: AppConstants.kYellow,
                          borderRadius: BorderRadius.circular(9.h),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: 'Today',
                              style: appstyle(
                                14,
                                AppConstants.kbkDark,
                                FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 15.w),
                            ReusableText(
                              text: 'From $start to $finish',
                              style: appstyle(
                                15,
                                AppConstants.kbkDark,
                                FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      ReusableText(
                        text: title ?? '',
                        style: appstyle(
                          30,
                          AppConstants.kbkDark,
                          FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        desc ?? '',
                        maxLines: 8,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        style: appstyle(
                          16,
                          AppConstants.kLight,
                          FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 12.w,
              top: -10,
              child: Image.asset(
                'assets/images/bell.png',
                width: 70.w,
                height: 70.h,
              ),
            ),
            Positioned(
              bottom: -AppConstants.kHeight * 0.142,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/notification.png',
                width: AppConstants.kWidth * 0.8,
                height: AppConstants.kHeight * 0.6,
              ),
            )
          ],
        ),
      ),
    );
  }
}
