import 'dart:developer';
import 'package:billspaye/views/forgotpassword/forgotpassword.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/login/selectlogincontroller.dart';
import '../../widgets/constants.dart';

class ChooseLoginScreen extends StatelessWidget {
  const ChooseLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ChooseLoginController>(
          init: ChooseLoginController(),
          builder: (controller) => Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [
                  0.2,
                  0.5,
                  0.2,
                  0.7
                ],
                    colors: [
                  Colors.white,
                  Colors.white,
                  Constants.lightBlue,
                  Constants.lightBlue
                ])),
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 10),
                child: Column(
                  children: [
                    Image.asset(
                      Constants.logoImage,
                      scale: 1.2,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        controller.welcomeHeader.toString(),
                        style: TextStyle(
                            color: Constants.darkBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Card(
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        color: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 2,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 30, left: 30, right: 30),
                              padding: const EdgeInsets.all(5),
                              width: controller.width,
                              height: controller.height,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  right: BorderSide(
                                    color: Colors.black45,
                                  ),
                                  top: BorderSide(color: Colors.black45),
                                  left: BorderSide(color: Colors.black45),
                                  bottom: BorderSide(color: Colors.black45),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50.0),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  AnimatedAlign(
                                    alignment:
                                        Alignment(controller.xAlign ?? -1, 0),
                                    duration: const Duration(milliseconds: 300),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height: controller.height,
                                      decoration: BoxDecoration(
                                        color: Constants.darkBlue,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(50.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.setLoginValues();
                                    },
                                    child: Align(
                                      alignment: const Alignment(-1, 0),
                                      child: SizedBox(
                                        child: Container(
                                          width: controller.width * 0.4,
                                          color: Colors.transparent,
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Log In',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: controller.loginColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.setSignUpValues();
                                    },
                                    child: Align(
                                      alignment: const Alignment(1, 0),
                                      child: Container(
                                        width: controller.width * 0.4,
                                        color: Colors.transparent,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: controller.signInColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: controller.isLoginVisible,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.55,
                                width: MediaQuery.of(context).size.width * 1,
                                margin: const EdgeInsets.only(
                                  top: 20,
                                  left: 30,
                                  right: 30,
                                ),
                                child: SingleChildScrollView(
                                  physics: const ScrollPhysics(),
                                  child: Form(
                                    key: controller.formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller:
                                              controller.loginEmailController,
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            hintText:
                                                'Enter email or phone number',
                                          ),
                                          validator: (value) {
                                            if (value.toString().isEmpty) {
                                              return 'Enter a valid email or phone number';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller: controller
                                              .loginPasswordController,
                                          obscureText:
                                              controller.showLoginPassword,
                                          decoration: InputDecoration(
                                            border:
                                                const UnderlineInputBorder(),
                                            hintText: 'Password',
                                            suffixIcon: IconButton(
                                              tooltip: 'show/hide password',
                                              icon: Icon(
                                                controller.showLoginPassword
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Constants.darkBlue,
                                              ),
                                              onPressed: () {
                                                controller.setShowPwd();
                                              },
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value.toString().isEmpty) {
                                              return 'Enter a valid Password';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (controller.formKey.currentState!
                                                .validate()) {
                                              controller.getLogin(
                                                  controller
                                                      .loginEmailController
                                                      .text,
                                                  controller
                                                      .loginPasswordController
                                                      .text);
                                            }
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            decoration: BoxDecoration(
                                                color: Constants.lightBlue,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: const Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10))),
                                            child: const Text(
                                              'Log In',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                        ),
                                        // const SizedBox(
                                        //   height: 20,
                                        // ),
                                        // Text(
                                        //   'or',
                                        //   style: TextStyle(
                                        //       color: Constants.darkBlue,
                                        //       fontWeight: FontWeight.bold,
                                        //       fontSize: 16),
                                        // ),
                                        // const SizedBox(
                                        //   height: 20,
                                        // ),
                                        // GestureDetector(
                                        //   child: Container(
                                        //     alignment: Alignment.center,
                                        //     height: 50,
                                        //     width: MediaQuery.of(context)
                                        //             .size
                                        //             .width *
                                        //         0.8,
                                        //     padding: const EdgeInsets.all(10),
                                        //     decoration: BoxDecoration(
                                        //         color: Colors.white,
                                        //         boxShadow: [
                                        //           BoxShadow(
                                        //             color: Colors.grey
                                        //                 .withOpacity(0.5),
                                        //             spreadRadius: 5,
                                        //             blurRadius: 7,
                                        //             offset: const Offset(0,
                                        //                 3), // changes position of shadow
                                        //           ),
                                        //         ],
                                        //         borderRadius:
                                        //             const BorderRadius.all(
                                        //                 Radius.circular(10))),
                                        //     child: Row(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.center,
                                        //       children: [
                                        //         Text(
                                        //           'Log In using',
                                        //           textAlign: TextAlign.center,
                                        //           style: TextStyle(
                                        //               color: Constants.darkBlue,
                                        //               fontSize: 18,
                                        //               fontWeight:
                                        //                   FontWeight.bold,
                                        //               fontStyle:
                                        //                   FontStyle.italic),
                                        //         ),
                                        //         const SizedBox(
                                        //           width: 20,
                                        //         ),
                                        //         Image.asset(
                                        //           'assets/images/google_logo.png',
                                        //           scale: 2,
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'By Continuing, you agree to our',
                                              style: TextStyle(
                                                  color: Constants.darkBlue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    var urlString =
                                                        'https://billspaye.in/terms-of-service';

                                                    // launchUrl(String urlString) async {

                                                    if (await canLaunchUrl(
                                                        Uri.parse(urlString
                                                            .toString()))) {
                                                      // Check if the URL can be launched

                                                      await launchUrl(Uri.parse(
                                                          urlString
                                                              .toString()));
                                                    } else {
                                                      throw 'Could not launch $urlString'; // throw could be used to handle erroneous situations
                                                    }

                                                    // }
                                                  },
                                                  child: Text(
                                                    'Terms of service',
                                                    style: TextStyle(
                                                        color:
                                                            Constants.darkBlue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'and',
                                                  style: TextStyle(
                                                      color: Constants.darkBlue,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    var urlString =
                                                        'https://billspaye.in/privacy-policy';

                                                    if (await canLaunchUrl(
                                                        Uri.parse(urlString
                                                            .toString()))) {
                                                      // Check if the URL can be launched

                                                      await launchUrl(Uri.parse(
                                                          urlString
                                                              .toString()));
                                                    } else {
                                                      throw 'Could not launch $urlString'; // throw could be used to handle erroneous situations
                                                    }
                                                  },
                                                  child: Text(
                                                    'Privacy policy',
                                                    style: TextStyle(
                                                        color:
                                                            Constants.darkBlue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),

                                        GestureDetector(
                                          onTap: () {
                                            Get.to(
                                                () => const ForgotPassword());
                                          },
                                          child: const Text(
                                            'Forgot Password?',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.setSignUpValues();
                                          },
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Dont have an account?',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                ' Sign Up',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            "© 2024 BillsPaye.All Rights Reserved.\n App Version: 1.0.0",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.blueGrey),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: controller.isSignUpVisible,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.55,
                                width: MediaQuery.of(context).size.width * 1,
                                margin: const EdgeInsets.only(
                                  top: 20,
                                  left: 30,
                                  right: 30,
                                ),
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: controller.signUpFormKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller:
                                              controller.firstNameController,
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            hintText: 'Enter FirstName',
                                          ),
                                          validator: (value) {
                                            if (value.toString().isEmpty) {
                                              return 'Enter a valid FirstName';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller:
                                              controller.lastNameController,
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            hintText: 'Enter LastName',
                                          ),
                                          validator: (value) {
                                            if (value.toString().isEmpty) {
                                              return 'Enter a valid LastName';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller:
                                              controller.signUpEmailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            hintText: 'Enter email ID',
                                          ),
                                          validator: (value) {
                                            if (value.toString().isEmpty ||
                                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                    .hasMatch(
                                                        value.toString())) {
                                              return 'Enter a valid email';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              child: TextFormField(
                                                controller: controller
                                                    .signUpMobController,
                                                keyboardType:
                                                    TextInputType.phone,
                                                decoration:
                                                    const InputDecoration(
                                                  border:
                                                      UnderlineInputBorder(),
                                                  hintText: 'Mobile Number',
                                                ),
                                                validator: (value) {
                                                  if (value
                                                      .toString()
                                                      .isEmpty) {
                                                    return 'Enter a valid Mobile Number';
                                                  } else if (value
                                                              .toString()
                                                              .length >
                                                          10 ||
                                                      value.toString().length <
                                                          10) {
                                                    return 'Mobile Number must be 10 characters';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: controller.otpBtnEnable ==
                                                      true
                                                  ? () {
                                                      log('send OTP');
                                                      if (controller
                                                          .signUpMobController
                                                          .text
                                                          .isEmpty) {
                                                        Get.snackbar('Alert',
                                                            'Enter Mobile Number',
                                                            backgroundColor:
                                                                Constants
                                                                    .darkBlue,
                                                            barBlur: 20,
                                                            overlayBlur: 5,
                                                            colorText:
                                                                Colors.white,
                                                            animationDuration:
                                                                const Duration(
                                                                    seconds:
                                                                        2));
                                                      } else if (controller.signUpMobController.text.length < 10 ||
                                                          controller.signUpMobController.text.length >
                                                              10) {
                                                        Get.snackbar('Alert',
                                                            'Enter Valid Mobile Number',
                                                            backgroundColor:
                                                                Constants
                                                                    .darkBlue,
                                                            barBlur: 20,
                                                            overlayBlur: 5,
                                                            colorText:
                                                                Colors.white,
                                                            animationDuration:
                                                                const Duration(
                                                                    seconds:
                                                                        2));
                                                      } else if (controller.signUpMobController.text.contains(" ") ||
                                                          controller
                                                              .signUpMobController
                                                              .text
                                                              .contains(".")) {
                                                        Get.snackbar('Alert',
                                                            'Enter Valid Mobile Number',
                                                            backgroundColor:
                                                                Constants
                                                                    .darkBlue,
                                                            barBlur: 20,
                                                            overlayBlur: 5,
                                                            colorText:
                                                                Colors.white,
                                                            animationDuration:
                                                                const Duration(
                                                                    seconds:
                                                                        2));
                                                      } else if (controller
                                                              .signUpMobController
                                                              .text
                                                              .contains("*") ||
                                                          controller
                                                              .signUpMobController
                                                              .text
                                                              .contains("(")) {
                                                        Get.snackbar('Alert',
                                                            'Enter Valid Mobile Number',
                                                            backgroundColor:
                                                                Constants
                                                                    .darkBlue,
                                                            barBlur: 20,
                                                            overlayBlur: 5,
                                                            colorText:
                                                                Colors.white,
                                                            animationDuration:
                                                                const Duration(
                                                                    seconds:
                                                                        2));
                                                      } else if (controller
                                                              .signUpMobController
                                                              .text
                                                              .contains(")") ||
                                                          controller.signUpMobController.text.contains("  ")) {
                                                        Get.snackbar('Alert',
                                                            'Enter Valid Mobile Number',
                                                            backgroundColor:
                                                                Constants
                                                                    .darkBlue,
                                                            barBlur: 20,
                                                            overlayBlur: 5,
                                                            colorText:
                                                                Colors.white,
                                                            animationDuration:
                                                                const Duration(
                                                                    seconds:
                                                                        2));
                                                      } else {
                                                        controller.getOtpApi(
                                                            controller
                                                                .signUpMobController
                                                                .text
                                                                .toString());
                                                      }
                                                    }
                                                  : () {
                                                      Get.snackbar('Alert',
                                                          "Retry after 30 seconds to resend another OTP",
                                                          backgroundColor:
                                                              Constants
                                                                  .darkBlue,
                                                          barBlur: 20,
                                                          overlayBlur: 5,
                                                          colorText:
                                                              Colors.white,
                                                          animationDuration:
                                                              const Duration(
                                                                  seconds: 2));
                                                    },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Constants.darkBlue,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
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
                                          controller:
                                              controller.signUpOtpController,
                                          keyboardType: TextInputType.phone,
                                          decoration: const InputDecoration(
                                              border: UnderlineInputBorder(),
                                              hintText: 'Enter OTP'),
                                          validator: (value) {
                                            if (value.toString().isEmpty) {
                                              return 'Enter a valid OTP';
                                            } else if (controller.otpValue
                                                    .toString() !=
                                                controller
                                                    .signUpOtpController.text
                                                    .toString()) {
                                              return 'OTP do not match';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller: controller
                                              .signUpPasswordController,
                                          obscureText:
                                              controller.showSignUpPassword,
                                          decoration: InputDecoration(
                                            border:
                                                const UnderlineInputBorder(),
                                            hintText: 'Password',
                                            suffixIcon: IconButton(
                                              tooltip: 'show/hide password',
                                              icon: Icon(
                                                controller.showSignUpPassword
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Constants.darkBlue,
                                              ),
                                              onPressed: () {
                                                controller.setSignUpShowPwd();
                                              },
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value.toString().isEmpty) {
                                              return 'Enter a valid Password';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller: controller
                                              .signUpConfirmPasswordController,
                                          obscureText: controller
                                              .showSignUpConfirmPassword,
                                          decoration: InputDecoration(
                                            border:
                                                const UnderlineInputBorder(),
                                            hintText: 'Confirm Password',
                                            suffixIcon: IconButton(
                                              tooltip: 'show/hide password',
                                              icon: Icon(
                                                controller
                                                        .showSignUpConfirmPassword
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Constants.darkBlue,
                                              ),
                                              onPressed: () {
                                                controller
                                                    .setSignUpShowConfirmPwd();
                                              },
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value.toString().isEmpty) {
                                              return 'Enter Confirm Password';
                                            } else if (value.toString() !=
                                                controller
                                                    .signUpPasswordController
                                                    .text) {
                                              return 'Passwords do not match';
                                            }
                                            return null;
                                          },
                                        ),
                                        /* const SizedBox(
                                          height: 20,
                                        ),
                                        DropdownButtonFormField(
                                          hint: const Text(
                                            'Select State',
                                          ),
                                          decoration: const InputDecoration(
                                              border: UnderlineInputBorder()),
                                          isDense: true,
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Constants.darkBlue,
                                          ),
                                          iconSize: 30,
                                          items:
                                              controller.statesList.map((item) {
                                            return DropdownMenuItem(
                                              value: item['id'].toString(),
                                              child: Text(
                                                item['name'],
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            );
                                          }).toList(),
                                          value: controller.stateDropDownValue,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Select State';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            log('Selected State is $value');
                                            controller.stateDropDownValue =
                                                value.toString();
                                            controller.getDistrictsApi(value);
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        DropdownButtonFormField(
                                          hint: const Text(
                                            'Select District',
                                          ),
                                          decoration: const InputDecoration(
                                              border: UnderlineInputBorder()),
                                          isDense: true,
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Constants.darkBlue,
                                          ),
                                          iconSize: 30,
                                          items:
                                              controller.citiesList.map((item) {
                                            return DropdownMenuItem(
                                              value: item['id'].toString(),
                                              child: Text(
                                                item['city'].toString(),
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                            );
                                          }).toList(),
                                          value: controller.cityDropDownValue,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Select District';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            controller.cityDropDownValue =
                                                value.toString();
                                            log('Selected District is $value');
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          style: const TextStyle(fontSize: 14),
                                          controller: controller
                                              .signUpPinCodeController,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(),
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            hintText: 'Enter PinCode',
                                          ),
                                          validator: (value) {
                                            if (value.toString().isEmpty) {
                                              return 'Enter a valid Pin Code';
                                            }
                                            return null;
                                          },
                                        ),*/
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (controller
                                                .signUpFormKey.currentState!
                                                .validate()) {
                                              controller
                                                  .signUpApi(
                                                      controller
                                                          .firstNameController
                                                          .text
                                                          .toString(),
                                                      controller
                                                          .lastNameController
                                                          .text
                                                          .toString(),
                                                      controller
                                                          .signUpEmailController
                                                          .text
                                                          .toString(),
                                                      controller
                                                          .signUpMobController
                                                          .text
                                                          .toString(),
                                                      controller
                                                          .signUpConfirmPasswordController
                                                          .text
                                                          .toString(),
                                                      controller.stateDropDownValue
                                                          .toString(),
                                                      controller
                                                          .cityDropDownValue
                                                          .toString(),
                                                      controller
                                                          .signUpPinCodeController
                                                          .text
                                                          .toString());
                                            }
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            decoration: BoxDecoration(
                                                color: Constants.lightBlue,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: const Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10))),
                                            child: const Text(
                                              'Sign Up',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.setLoginValues();
                                          },
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Have an account?',
                                              ),
                                              Text(
                                                ' Login',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
