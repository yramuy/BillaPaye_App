import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiservice/restapi.dart';
import '../../views/subcategorydetails/subcategorydetails.dart';
import '../../widgets/constants.dart';

class WishlistController extends GetxController {
  bool isLoading = true;
  List wishList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getWishlistData();
  }

  getWishlistData() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    var userID = userPref.getBool('isLogin') == null
            ?'7':userPref.getString('userID').toString();
    var encodeBody = jsonEncode({"user_id": userID});
    log('----------encodeBody-------------');
    log(encodeBody);
    log('-----------------------');
    await ApiService.post("userWishlist", encodeBody).then((success) {
      if (success.statusCode == 200) {
        var responseBody = json.decode(success.body);
        log(responseBody.toString());
        if (responseBody['status'] == 1) {
          wishList = responseBody['wishlist'];
          isLoading = false;
        } else {
          wishList = [];
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

  wishlistUpdateApi(catID, subCatID) async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    var userID = userPref.getBool('isLogin') == null
            ?'7':userPref.getString('userID').toString();
    var encodeBody = jsonEncode(
        {"cat_id": catID, "sub_cat_id": subCatID, "user_id": userID});
    log('----------encodeBody-------------');
    log(encodeBody);
    log('-----------------------');
    await ApiService.post("addRemoveWishlist", encodeBody).then((success) {
      if (success.statusCode == 200) {
        var responseBody = json.decode(success.body);
        log(responseBody.toString());
        if (responseBody['status'] == 1) {
          Get.snackbar('Alert', responseBody['message'].toString(),
              backgroundColor: Constants.darkBlue,
              barBlur: 20,
              overlayBlur: 5,
              colorText: Colors.white,
              animationDuration: const Duration(seconds: 1));
          getWishlistData();
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

  navigateTo(subCatID, subCatName) async {
    log(subCatID.toString());
    log(subCatName.toString());
    Get.to(() => const SubCategoryDetailsScreen(),
        arguments: [subCatID, subCatName]);
    update();
  }
}
