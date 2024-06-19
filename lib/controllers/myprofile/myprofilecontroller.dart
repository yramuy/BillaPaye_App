import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiservice/restapi.dart';
import '../../widgets/constants.dart';

class MyProfileController extends GetxController {
   var userDetails;
  bool isLoading = true;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserData();
  }

  getUserData() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    var userID = userPref.getString('userID').toString();
    var encodeBody = jsonEncode({
      "user_id": userID,
    });
    log('----------encodeBody-------------');
    log(encodeBody);
    log('-----------------------');
    await ApiService.post("userDetails", encodeBody).then((success) {
      if (success.statusCode == 200) {
        var responseBody = json.decode(success.body);
        // log(responseBody.toString());
        if (responseBody['status'] == 1) {
          saveUserDetails(responseBody);
          userDetails=responseBody['userDetails'];
          log(userDetails.toString());
          isLoading = false;
        } else {
          isLoading = false;
        }
      } else {
        isLoading = false;
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
     // getController.setUserData();
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


}
