import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/custom_alert.dart';
import 'package:todo/common/widgets/custom_btn.dart';
import 'package:todo/common/widgets/custom_text.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/text_style.dart';
import 'package:todo/features/auth/controllers/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  bool isLoading = false;
  CountryCode? code;
  final countryPicker = FlCountryCodePicker(
    searchBarTextStyle: appstyle(
      14,
      AppConstants.kLight,
      FontWeight.normal,
    ),
    countryTextStyle: appstyle(
      16,
      AppConstants.kLight,
      FontWeight.w500,
    ),
    dialCodeTextStyle: appstyle(
      16,
      AppConstants.kLight,
      FontWeight.bold,
    ),
    showDialCode: true,
    title: Padding(
      padding: const EdgeInsets.only(top: 6.0, left: 12.0),
      child: Text(
        'Select Country',
        style: appstyle(
          26,
          AppConstants.kLight,
          FontWeight.bold,
        ),
      ),
    ),
    searchBarDecoration: const InputDecoration(
      hintText: "Country or 'Code'",
      hintStyle: TextStyle(color: AppConstants.kGreyLight),
      suffixIcon: Icon(
        Icons.search,
        color: AppConstants.kbkDark,
      ),
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
    ),
  );

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    String error = 'Please enter country code!';
    setState(() {
      isLoading = true;
    });
    if (code == null) {
      showAlertDialog(context: context, message: error, btmText: null);
      setState(() {
        isLoading = false;
      });
      return;
    }
    if (phoneNumber.length != 10 || int.tryParse(phoneNumber) == null) {
      error = 'Please enter valid phone number!';
      showAlertDialog(context: context, message: error, btmText: null);
      setState(() {
        isLoading = false;
      });
      return;
    }
    ref
        .read(authControllerProvider)
        .sendSms(context: context, phone: '${code!.dialCode}$phoneNumber');

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: ListView(
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
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: GestureDetector(
                      onTap: () async {
                        code = await countryPicker.showPicker(
                          context: context,
                          backgroundColor: AppConstants.kbkDark,
                        );
                        setState(() {});
                      },
                      child: code == null
                          ? const Icon(Icons.flag)
                          : ReusableText(
                              text: "${code == null ? '' : code?.dialCode}",
                              style: appstyle(
                                18,
                                AppConstants.kbkDark,
                                FontWeight.bold,
                              ),
                            ),
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
                onTap: () => sendPhoneNumber(),
                height: AppConstants.kHeight * 0.08,
                width: AppConstants.kWidth * 0.9,
                boxDecoColor: AppConstants.kLight,
                borderColor: AppConstants.kLight,
                text: "Send Code",
                textStyleColor: AppConstants.kbkDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
