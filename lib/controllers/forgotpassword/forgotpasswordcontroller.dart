import 'dart:convert';
import 'dart:developer';

import 'package:billspaye/views/login/selectelogin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../apiservice/restapi.dart';
import '../../widgets/constants.dart';

class ForgotPasswordController extends GetxController {
  String otpValue = '';

  bool otpBtnEnable = true;

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobNumController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool showPassword = true;
  bool showConfirmPassword = true;

  setShowPwd() {
    showPassword = !showPassword;
    update();
  }

  setShowConfirmPwd() {
    showConfirmPassword = !showConfirmPassword;
    update();
  }

  getOtpApi(mobNumber) async {
    var encodeBody = jsonEncode({"mobileNumber": mobNumber});
    otpBtnEnable = false;
    log('----------encodeBody-------------');
    log(encodeBody);
    log('-----------------------');
    await ApiService.post("sendOTP", encodeBody).then((success) {
      if (success.statusCode == 200) {
        var responseBody = json.decode(success.body);
        log(responseBody.toString());
        if (responseBody['status'].toString() == 'Done' ||
            responseBody['status'].toString() == 'SUCCESS') {
          otpValue = responseBody['otpDetails']['otp'].toString();
          log(otpValue.toString());
          Get.snackbar('Alert', responseBody['message'].toString(),
              backgroundColor: Constants.darkBlue,
              barBlur: 3,
              colorText: Colors.white,
              animationDuration: const Duration(seconds: 3));
        } else {
          Get.snackbar('Alert', responseBody['message'].toString(),
              backgroundColor: Constants.darkBlue,
              barBlur: 20,
              overlayBlur: 5,
              colorText: Colors.white,
              animationDuration: const Duration(seconds: 3));
          log('error');
        }
      } else {
        Get.snackbar('Alert', 'Something went wrong, Please retry later',
            backgroundColor: Constants.darkBlue,
            barBlur: 20,
            overlayBlur: 5,
            colorText: Colors.white,
            animationDuration: const Duration(seconds: 3));
        log('Something went wrong, Please retry later');
      }
    });
    Future.delayed(const Duration(seconds: 30), () {
      otpBtnEnable = true;
      log('button status');
      log(otpBtnEnable.toString());
      update();
    });
    log('button status');
    log(otpBtnEnable.toString());
    update();
  }

  forgotPassword(eMail, mobNumber, confirmPassword) async {
    var encodeBody = jsonEncode({
      "email": eMail,
      "mobile_number": mobNumber,
      "password": confirmPassword
    });
    log('----------encodeBody-------------');
    log(encodeBody);
    log('-----------------------');
    await ApiService.post("forget_password", encodeBody).then((success) {
      if (success.statusCode == 200) {
        var responseBody = json.decode(success.body);
        log(responseBody.toString());
        if (responseBody['status'].toString() == '1') {
          Get.snackbar('Alert', responseBody['message'].toString(),
              backgroundColor: Constants.darkBlue,
              barBlur: 3,
              colorText: Colors.white,
              animationDuration: const Duration(seconds: 2));
          Get.offAll(()=>const ChooseLoginScreen());
        } else {
          Get.snackbar('Alert', responseBody['message'].toString(),
              backgroundColor: Constants.darkBlue,
              barBlur: 20,
              overlayBlur: 5,
              colorText: Colors.white,
              animationDuration: const Duration(seconds: 2));
          log('error');
        }
      } else {
        Get.snackbar('Alert', 'Something went wrong, Please retry later',
            backgroundColor: Constants.darkBlue,
            barBlur: 20,
            overlayBlur: 5,
            colorText: Colors.white,
            animationDuration: const Duration(seconds: 3));
        log('Something went wrong, Please retry later');
      }
    });
    update();
  }
}
