import 'dart:convert';
import 'dart:developer';

import 'package:billspaye/views/landingpage/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiservice/restapi.dart';
import '../../views/home/homescreen.dart';
import '../../views/login/selectelogin.dart';
import '../../views/offers/offers.dart';
import '../../views/scan/scanner.dart';
import '../../views/wishlist/wishlist.dart';
import '../../widgets/constants.dart';

class BottomNavigationController extends GetxController {
  final advancedDrawerController = AdvancedDrawerController();
  int selectedIndex = 0;
  String userName = "";
  String userMail = "";
  bool loginValue = false;

  String userProImage = "";
  @override
  void onInit() {
    super.onInit();
    setUserData();
  }

  final List<Widget> screenOptions = <Widget>[
    const HomeScreen(),
    const OffersScreen(),
    const Scanner(),
    const WishListScreen(),
  ];

  onItemTapped(int index) {
    log('index----->$index');
    selectedIndex = index;
    update();
  }

  setUserData() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    userName = userPref.getString('userName').toString();
    userMail = userPref.getString('userEmail').toString();
    userProImage = userPref.getString('userProfilepic').toString();
    loginValue=userPref.getBool('isLogin') == null?false:true;
    log('user details');
    log(userName.toString());
    log(userMail.toString());
    log(userPref.getBool('isLogin').toString());
    log(loginValue.toString());
    update();
  }
  addReviewDialog() {
    Get.dialog(
      barrierDismissible: false,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        'Are You Sure ?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'You want to delete your account !!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          color: Constants.darkBlue,
                        ),
                      ),
                      const SizedBox(height: 20),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                minimumSize: const Size(0, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                deleteAccount();
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Constants.lightBlue,
                                minimumSize: const Size(0, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                'No',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    update();
  }

  deleteAccount() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    var userID = userPref.getString('userID').toString();
    var encodeBody = jsonEncode({"user_id": userID.toString()});
    log('----------encodeBody-------------');
    log(encodeBody);
    log('-----------------------');
    await ApiService.post("delete_account", encodeBody).then((success) {
      if (success.statusCode == 200) {
        var responseBody = json.decode(success.body);
        log(responseBody.toString());
        if (responseBody['status'].toString() == '1') {
          Get.snackbar('Alert', responseBody['message'].toString(),
              backgroundColor: Constants.darkBlue,
              barBlur: 3,
              colorText: Colors.white,
              animationDuration: const Duration(seconds: 3));
          Get.offAll(() => const ChooseLoginScreen());
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
    update();
  }

  setLogOut() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    await userPref.clear();
    log('------------------->cleared');
    Get.offAll(
            () => const LandingPage());
    update();
  }
}
