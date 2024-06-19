import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiservice/restapi.dart';
import '../../views/subcategorydetails/subcategorydetails.dart';
import '../../widgets/constants.dart';

class HomeScreenController extends GetxController {
  bool isLoading = true;
  bool loginValue = false;

  List mostExcitingOffers = [];
  List citiesList = [];
  String? cityName;
  String? cityDropDownValue;
  List categoryImgList = [
    Constants.restaurantIcon,
    Constants.clothingIcon,
    Constants.salonIcon,
    Constants.spaIcon,
    Constants.beautyParlourIcon,
    Constants.hotelIcon,
    Constants.cafeIcon,
    Constants.ticketBookingIcon,
  ];

  List categoryTitleList = [];

  List topPicksList = [];

  String userDistrictName = "";
  String userPinCode = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDistrictsApi();
    getCategoriesApi("");
    getMostExcitingOfferApi();
  }

  getDistrictsApi() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    loginValue=userPref.getBool('isLogin') == null?false:true;
    var encodeBody = jsonEncode({
      "state_id": userPref.getBool('isLogin') == null
          ? '1'
          : userPref.getString('userStateID').toString(),
    });
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

  getCategoriesApi(cityID) async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    var cityID1 =
        cityID == "" ? userPref.getString('userCityID').toString() : cityID;
    var encodeBody = jsonEncode({
      "state_id": userPref.getBool('isLogin') == null
          ? '1'
          : userPref.getString('userStateID').toString(),
      "city_id": userPref.getBool('isLogin') == null ? '23' : cityID1,
    });
    log('----------encodeBody-------------');
    log(encodeBody);
    log('-----------------------');
    await ApiService.post("categories", encodeBody).then((success) {
      if (success.statusCode == 200) {
        var responseBody = json.decode(success.body);
        if (responseBody['status'] == 1) {
          categoryTitleList = responseBody['category'];
          log(categoryTitleList.toString());
          for (int i = 0; i < categoryTitleList.length; i++) {}
          isLoading = false;
        }
      } else {
        isLoading = false;
        Get.snackbar('Alert',
            'No Categories Found Something went wrong, Please retry later',
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

  getMostExcitingOfferApi() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    userDistrictName = userPref.getBool('isLogin') == null
        ? 'Visakhapatnam'
        : userPref.getString('userCity').toString();
    cityName = userDistrictName.toString();
    userPinCode = userPref.getBool('isLogin') == null
        ? '530017'
        : userPref.getString('userPincode').toString();
    log('cityName====================>$cityName');
    log('distname====================>$userDistrictName');
    var encodeBody = jsonEncode({
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
    await ApiService.post("most_exciting_offers", encodeBody).then((success) {
      if (success.statusCode == 200) {
        var responseBody = json.decode(success.body);
        // isLoading = false;
        log(responseBody.toString());
        if (responseBody['status'] == 1) {
          mostExcitingOffers = responseBody['offers'];
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

  updateData(value) {
    isLoading = true;
    getCategoriesApi(value);
    saveUserDetails(value);
    update();
  }

  saveUserDetails(response) async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    userPref.setString("userCityID", response.toString());
    log("==================");
    log(response.toString());
    log(userPref.getString('userCityID').toString());
    log("==================");
  }

  navigateTo(subCatID, subCatName,) async {
    log(subCatID.toString());
    log(subCatName.toString());
    SharedPreferences userPref = await SharedPreferences.getInstance();
    var userID = userPref.getString('userID').toString();
    Get.to(() => const SubCategoryDetailsScreen(),
        arguments: [subCatID, subCatName]);
    update();
  }
}
