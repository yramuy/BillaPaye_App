import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/forgotpassword/forgotpasswordcontroller.dart';
import '../../widgets/constants.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
      init: ForgotPasswordController(),
      builder: (e) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              'Forgot Password',
            ),
            titleTextStyle: TextStyle(
                fontSize: 16,
                color: Constants.darkBlue,
                fontWeight: FontWeight.bold),
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            child: SingleChildScrollView(
              child: Form(
                key: e.formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: e.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Enter email ID',
                        ),
                        validator: (value) {
                          if (value.toString().isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value.toString())) {
                            return 'Enter valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: TextFormField(
                              controller: e.mobNumController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Mobile Number',
                              ),
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  return 'Enter Mobile Number';
                                } else if (value.toString().length > 10 ||
                                    value.toString().length < 10) {
                                  return 'Mobile Number must be 10 characters';
                                }
                                return null;
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: e.otpBtnEnable == true
                                ? () {
                                    log('send OTP');
                                    if (e.mobNumController.text.isEmpty) {
                                      Get.snackbar(
                                          'Alert', 'Enter Mobile Number',
                                          backgroundColor: Constants.darkBlue,
                                          barBlur: 20,
                                          overlayBlur: 5,
                                          colorText: Colors.white,
                                          animationDuration:
                                              const Duration(seconds: 2));
                                    } else if (e.mobNumController.text.length <
                                            10 ||
                                        e.mobNumController.text.length > 10) {
                                      Get.snackbar(
                                          'Alert', 'Enter Valid Mobile Number',
                                          backgroundColor: Constants.darkBlue,
                                          barBlur: 20,
                                          overlayBlur: 5,
                                          colorText: Colors.white,
                                          animationDuration:
                                              const Duration(seconds: 2));
                                    } else if (e.mobNumController.text
                                            .contains(" ") ||
                                        e.mobNumController.text.contains(".")) {
                                      Get.snackbar(
                                          'Alert', 'Enter Valid Mobile Number',
                                          backgroundColor: Constants.darkBlue,
                                          barBlur: 20,
                                          overlayBlur: 5,
                                          colorText: Colors.white,
                                          animationDuration:
                                              const Duration(seconds: 2));
                                    } else if (e.mobNumController.text
                                            .contains("*") ||
                                        e.mobNumController.text.contains("(")) {
                                      Get.snackbar(
                                          'Alert', 'Enter Valid Mobile Number',
                                          backgroundColor: Constants.darkBlue,
                                          barBlur: 20,
                                          overlayBlur: 5,
                                          colorText: Colors.white,
                                          animationDuration:
                                              const Duration(seconds: 2));
                                    } else if (e.mobNumController.text
                                            .contains(")") ||
                                        e.mobNumController.text
                                            .contains("  ")) {
                                      Get.snackbar(
                                          'Alert', 'Enter Valid Mobile Number',
                                          backgroundColor: Constants.darkBlue,
                                          barBlur: 20,
                                          overlayBlur: 5,
                                          colorText: Colors.white,
                                          animationDuration:
                                              const Duration(seconds: 2));
                                    } else {
                                      e.getOtpApi(
                                          e.mobNumController.text.toString());
                                    }
                                  }
                                : () {
                                    Get.snackbar('Alert',
                                        "Retry after 30 seconds to resend another OTP",
                                        backgroundColor: Constants.darkBlue,
                                        barBlur: 20,
                                        overlayBlur: 5,
                                        colorText: Colors.white,
                                        animationDuration:
                                            const Duration(seconds: 2));
                                  },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Constants.darkBlue,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: const Text(
                                'Send OTP',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: e.otpController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Enter OTP'),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'Enter OTP';
                          } else if (e.otpValue.toString() !=
                              e.otpController.text.toString()) {
                            return 'OTP do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: e.passwordController,
                        obscureText: e.showPassword,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            tooltip: 'show/hide password',
                            icon: Icon(
                              e.showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Constants.darkBlue,
                            ),
                            onPressed: () {
                              e.setShowPwd();
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'Enter Password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: e.confirmPasswordController,
                        obscureText: e.showConfirmPassword,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          hintText: 'Confirm Password',
                          suffixIcon: IconButton(
                            tooltip: 'show/hide password',
                            icon: Icon(
                              e.showConfirmPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Constants.darkBlue,
                            ),
                            onPressed: () {
                              e.setShowConfirmPwd();
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'Enter Confirm Password';
                          } else if (value.toString() !=
                              e.passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              log(e.otpValue);
              log(e.otpController.text);
              if (e.formKey.currentState!.validate()) {
                e.forgotPassword(
                    e.emailController.text.toString(),
                    e.mobNumController.text.toString(),
                    e.confirmPasswordController.text.toString());
              }
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                  color: Constants.lightBlue,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              height: 50,
              child: const Text(
                "Submit",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
        );
      },
    );
  }
}
