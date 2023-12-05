import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:todo/common/routes/routes.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/custom_btn.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/text_style.dart';
import 'package:todo/features/auth/controllers/auth_controller.dart';

class OtpScreen extends ConsumerWidget {
  const OtpScreen({
    super.key,
    required this.smsCodeId,
    required this.phone,
  });
  final String smsCodeId;
  final String phone;

  void veriftOtpCode(BuildContext context, WidgetRef ref, String smsCode) {
    ref.read(authControllerProvider).verifyOtpCode(
          context: context,
          smsCodeId: smsCodeId,
          smsCode: smsCode,
          mounted: true,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppConstants.kHeight * 0.15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                  ),
                  child: Image.asset(
                    'assets/images/todo.png',
                    width: AppConstants.kWidth * 0.5,
                  ),
                ),
                SizedBox(
                  height: 26.h,
                ),
                ReusableText(
                  text: "Enter OTP",
                  style: appstyle(
                    18,
                    AppConstants.kLight,
                    FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 26.h,
                ),
                Pinput(
                  length: 6,
                  showCursor: true,
                  onCompleted: (value) {
                    if (value.length == 6) {
                      return veriftOtpCode(
                        context,
                        ref,
                        value,
                      );
                    }
                  },
                  onSubmitted: (value) {
                    if (value.length == 6) {
                      return veriftOtpCode(context, ref, value);
                    }
                  },
                  keyboardType: TextInputType.number,
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                ),
                SizedBox(height: 20.h),
                CustomBtn(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(Routes.login);
                  },
                  height: AppConstants.kHeight * 0.13,
                  width: AppConstants.kWidth * 0.9,
                  borderColor: AppConstants.kLight,
                  text: 'Change phone number',
                  boxDecoColor: null,
                  textStyleColor: AppConstants.kLight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
