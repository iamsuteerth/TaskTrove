// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/common/helpers/db_helper.dart';
import 'package:todo/common/routes/routes.dart';
import 'package:todo/common/widgets/custom_alert.dart';

final authRepostioryProvider = Provider(
  (ref) {
    return AuthRepository(
      auth: FirebaseAuth.instance,
    );
  },
);

class AuthRepository {
  final FirebaseAuth auth;
  AuthRepository({required this.auth});

  void sendOtp({required BuildContext context, required String phone}) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (phoneAuthCredential) async {
          await auth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (e) => showAlertDialog(
            context: context, message: e.toString(), btmText: null),
        codeSent: (smsCodeId, resendCodeId) {
          DBHelper.createUser(1);
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.otp,
            (route) => false,
            arguments: {
              "phone": phone,
              "smsCodeId": smsCodeId,
            },
          );
        },
        codeAutoRetrievalTimeout: (smsCodeId) {},
      );
    } on FirebaseAuthException catch (e) {
      showAlertDialog(
        context: context,
        message: e.toString(),
        btmText: null,
      );
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    try {
      final creds = PhoneAuthProvider.credential(
        verificationId: smsCodeId,
        smsCode: smsCode,
      );
      // print(creds);
      await auth.signInWithCredential(creds);
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.home, (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      String message = e.toString();
      if (e.code == 'invalid-verification-code') {
        message = 'Invalid Otp';
      }
      showAlertDialog(
        context: context,
        message: message,
        btmText: null,
      );
      return;
    }
  }
}
