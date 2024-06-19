import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../apiservice/restapi.dart';
import '../../widgets/bottomnavigation/bottomnavigation.dart';
import '../../widgets/constants.dart';
import '../bottomnavigation/bottomnavigationcontroller.dart';

class ChooseLoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  Color loginColor = Colors.white;
  Color signInColor = Colors.black54;
  bool vertical = false;
  bool otpBtnEnable = true;
  double? xAlign;
  bool isLoginVisible = true;
  bool isSignUpVisible = false;
  String welcomeHeader = "Welcome to Bills Paye";
  bool showLoginPassword = true;
  bool showSignUpPassword = true;
  bool showSignUpConfirmPassword = true;
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController signUpMobController = TextEditingController();
  TextEditingController signUpOtpController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController =
      TextEditingController();
  TextEditingController signUpPinCodeController = TextEditingController();
  double width = 280.0;
  double height = 50.0;
  double loginAlign = -1;
  double signInAlign = 1;
  Color selectedColor = Colors.white;
  Color normalColor = Colors.black54;
  List statesList = [];
  String? stateDropDownValue;
  List citiesList = [];
  String? cityDropDownValue;
  String otpValue = '';
  var getC = Get.put(BottomNavigationController());
  @override
  void onInit() {
    super.onInit();
    getStatesApi();
  }

  setLoginValues() {
    xAlign = loginAlign;
    loginColor = Colors.white;
    signInColor = Constants.darkBlue;
    isLoginVisible = true;
    isSignUpVisible = false;
    welcomeHeader = 'Welcome to Bills Paye';
    update();
  }

  setSignUpValues() {
    xAlign = signInAlign;
    signInColor = Colors.white;
    loginColor = Constants.darkBlue;
    isLoginVisible = false;
    isSignUpVisible = true;
    welcomeHeader = 'Lets Get Started';
    update();
  }

  setShowPwd() {
    showLoginPassword = !showLoginPassword;
    update();
  }

  setSignUpShowPwd() {
    showSignUpPassword = !showSignUpPassword;
    update();
  }

  setSignUpShowConfirmPwd() {
    showSignUpConfirmPassword = !showSignUpConfirmPassword;
    update();
  }

  getLogin(userName, userPassword) async {
    getC.setUserData();
    var encodeBody =
        jsonEncode({"username": userName, "password": userPassword});
    log('----------encodeBody-------------');
    log(encodeBody);
    log('-----------------------');
    await ApiService.post("login", encodeBody).then((success) {
      if (success.statusCode == 200) {
        var responseBody = json.decode(success.body);
        log(responseBody.toString());
        if (responseBody['status'] == 1) {
          saveUserDetails(responseBody);
          getC.setUserData();
          Get.snackbar('Alert', responseBody['message'].toString(),
              backgroundColor: Constants.darkBlue,
              barBlur: 3,
              colorText: Colors.white,
              animationDuration: const Duration(seconds: 3));
          Get.offAll(() => const BottomNavigationTileScreen());
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

  saveUserDetails(response) async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    userPref.setString("userID", response["userDetails"]['user_id'].toString());
    userPref.setString(
        "userName", response["userDetails"]['user_name'].toString());
    userPref.setString(
        "roleName", response["userDetails"]['role_name'].toString());
    userPref.setString(
        "roleID", response["userDetails"]['user_role_id'].toString());
    userPref.setString(
        "userMob", response["userDetails"]['mobileno'].toString());
    userPref.setString(
        "userEmail", response["userDetails"]['email'].toString());
    userPref.setString(
        "userState", response["userDetails"]['state'].toString());
    userPref.setString(
        "userStateID", response["userDetails"]['state_id'].toString());
    userPref.setString("userCity", response["userDetails"]['city'].toString());
    userPref.setString(
        "userCityID", response["userDetails"]['city_id'].toString());
    userPref.setString(
        "userPincode", response["userDetails"]['pincode'].toString());
    userPref.setString(
        "userProfilepic", response["userDetails"]['profilePic'].toString());
    userPref.setBool("isLogin", true);
    getC.setUserData();
    log("user details==================");
    log(response.toString());
    log(userPref.getString('userID').toString());
    log(userPref.getString('userName').toString());
    log(userPref.getString('roleName').toString());
    log(userPref.getString('roleID').toString());
    log(userPref.getString('userMob').toString());
    log(userPref.getString('userEmail').toString());
    log(userPref.getString('userState').toString());
    log(userPref.getString('userCity').toString());
    log(userPref.getString('userPincode').toString());
    log(userPref.getString('userProfilepic').toString());
    log("==================");
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

  getStatesApi() async {
    await ApiService.get("states").then((success) {
      if (success.statusCode == 200) {
        var responseBody = json.decode(success.body);
        log(responseBody.toString());
        if (responseBody['status'] == 1) {
          statesList = responseBody['states'];
        } else {
          Get.snackbar('Alert', 'No States Found',
              backgroundColor: Constants.darkBlue,
              barBlur: 20,
              overlayBlur: 5,
              colorText: Colors.white,
              animationDuration: const Duration(seconds: 3));
          log('error');
        }
      } else {
        Get.snackbar(
            'Alert', 'No States Found Something went wrong, Please retry later',
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

  getDistrictsApi(sID) async {
    var encodeBody = jsonEncode({"state_id": sID});
    log('----------encodeBody-------------');
    log(encodeBody);
    log('-----------------------');
    citiesList = [];
    await ApiService.post("citiesByState", encodeBody).then((success) {
      if (success.statusCode == 200) {
        var responseBody = json.decode(success.body);
        log(responseBody.toString());
        if (responseBody['status'] == 1) {
          citiesList = responseBody['cities'];
        } else {
          Get.snackbar('Alert', 'No Districts Found',
              backgroundColor: Constants.darkBlue,
              barBlur: 20,
              overlayBlur: 5,
              colorText: Colors.white,
              animationDuration: const Duration(seconds: 3));
          log('error');
        }
      } else {
        Get.snackbar('Alert',
            'No Districts Found Something went wrong, Please retry later',
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

  signUpApi(firstName, lastName, emailID, mobNum, passWord, stateID, cityID,
      pinCode) async {
    var encodeBody = jsonEncode({
      "first_name": firstName.toString(),
      "last_name": lastName.toString(),
      "email": emailID.toString(),
      "mobile_number": mobNum.toString(),
      "password": passWord.toString(),
      "state_id": '1',
      "city_id": '23',
      "pincode": '530017',
    });
    log('----------encodeBody-------------');
    log(encodeBody);
    log('-----------------------');
    await ApiService.post("signUp", encodeBody).then((success) {
      if (success.statusCode == 200) {
        var responseBody = json.decode(success.body);
        log(responseBody.toString());
        if (responseBody['status'] == 1) {
          Get.snackbar('Alert', responseBody['message'].toString(),
              backgroundColor: Constants.darkBlue,
              barBlur: 3,
              colorText: Colors.white,
              animationDuration: const Duration(seconds: 3));
          firstNameController.clear();
          lastNameController.clear();
          signUpEmailController.clear();
          signUpMobController.clear();
          signUpOtpController.clear();
          signUpPasswordController.clear();
          signUpConfirmPasswordController.clear();
          signUpPinCodeController.clear();
          setLoginValues();
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
}
