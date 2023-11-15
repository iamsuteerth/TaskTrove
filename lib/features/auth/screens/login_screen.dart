import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/custom_btn.dart';
import 'package:todo/common/widgets/custom_text.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/text_style.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  Country? country;
  final TextEditingController phoneController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Image.asset(
                'assets/images/todo.png',
                width: 300,
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                left: 16.w,
              ),
              child: ReusableText(
                text: 'Please enter your phone number',
                style: appstyle(
                  17,
                  AppConstants.kLight,
                  FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Center(
              child: CustomTextField(
                controller: phoneController,
                prefixIcon: Container(
                  padding: const EdgeInsets.all(4),
                  child: GestureDetector(
                    onTap: () {
                      showCountryPicker(
                        useSafeArea: true,
                        context: context,
                        showPhoneCode: true,
                        onSelect: (value) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          setState(() {
                            country = value;
                          });
                        },
                        countryListTheme: CountryListThemeData(
                          backgroundColor: AppConstants.kLight,
                          bottomSheetHeight: 0.6,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppConstants.kRadius),
                            topRight: Radius.circular(AppConstants.kRadius),
                          ),
                        ),
                      );
                    },
                    // child: ReusableText(
                    //   text: '${country.flagEmoji} + ${country.phoneCode}',
                    //   style: appstyle(
                    //     18,
                    //     AppConstants.kbkDark,
                    //     FontWeight.bold,
                    //   ),
                    // ),
                  ),
                ),
                keyboardType: TextInputType.phone,
                hintText: 'Enter phone number',
                hintStyle: appstyle(
                  16,
                  AppConstants.kbkDark,
                  FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            CustomBtn(
              onTap: () {},
              height: AppConstants.kHeight * 0.15,
              width: AppConstants.kWidth * 0.9,
              boxDecoColor: AppConstants.kLight,
              borderColor: AppConstants.kLight,
              text: "Send Code",
              textStyleColor: AppConstants.kbkDark,
            ),
          ],
        ),
      ),
    );
  }
}
