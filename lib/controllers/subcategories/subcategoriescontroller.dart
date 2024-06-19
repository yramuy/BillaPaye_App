import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiservice/restapi.dart';
import '../../widgets/constants.dart';

class SubCategoriesController extends GetxController {
  dynamic argumentData = Get.arguments;
  List subCategoryList = [];
  List tempSearchList = [];
  List categoryOffersList = [];
  bool isLoading = true;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    log('data===================>');
    log(argumentData.toString());
    getSubCategoryData();
  }

  getSubCategoryData() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    var userID = userPref.getBool('isLogin') == null
        ? '7'
        : userPref.getString('userID').toString();
    var encodeBody = jsonEncode({
      "category_id": argumentData[1].toString(),
      "user_id": userID,
      "state_id": userPref.getBool('isLogin') == null
          ? '1'
          : userPref.getString('userStateID').toString(),
      "city_id": userPref.getBool('isLogin') == null
          ? '23'
          : userPref.getString('userCityID').toString(),
    });
    log('----------encodeBody-------------');
    log(encodeBody);
    log('-----------------------');
    await ApiService.post("subCategories", encodeBody).then((success) {
      if (success.statusCode == 200) {
        var responseBody = json.decode(success.body);
        if (responseBody['status'] == 1) {
          subCategoryList = responseBody['sub_categories'];
          tempSearchList = responseBody['sub_categories'];
          categoryOffersList = responseBody['categoryOffers'];
          isLoading = false;
          log(responseBody.toString());
          log('response');
          log('subCategoryList');
          log(subCategoryList.toString());

          // log(categoryOffersList.toString());
          // log('category offers');
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

  filterList(val) async {
    subCategoryList = [];
    for (int i = 0; i < tempSearchList.length; i++) {
      String subCategoryName =
          tempSearchList[i]["sub_category_name"].toString();
      String enteredValue = val.toString();

      if (subCategoryName.toLowerCase() == enteredValue.toLowerCase()) {
        subCategoryList.add(tempSearchList[i]);
        break;
      } else if (subCategoryName
          .toLowerCase()
          .contains(enteredValue.toLowerCase())) {
        subCategoryList.add(tempSearchList[i]);
      }
    }
    update();
  }

  addRemoveWishList(catID, subCatID) async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    var userID = userPref.getBool('isLogin') == null
        ? '7'
        : userPref.getString('userID').toString();
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
          getSubCategoryData();
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
}
