import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiservice/restapi.dart';
import '../../views/paybill/paybill.dart';
import '../../widgets/constants.dart';

class SubCategoryDetailsController extends GetxController {
  dynamic argumentData = Get.arguments;
  PageController pageController = PageController();
  List subCategoryDetailList = [];
  int selectedOption = 1;
  List tempSearchList = [];
  bool isLoading = true;
  var offersKey = GlobalKey();
  var menuKey = GlobalKey();
  var photosKey = GlobalKey();
  var reviewsKey = GlobalKey();
  var aboutKey = GlobalKey();
  TextEditingController shortTextController = TextEditingController();
  TextEditingController longTextController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  var subCatID = '';
  var catName = '';
  var catID = '';
  List foodTypes = [];

  bool isVisible = false;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    log('arg data===========');
    log(argumentData.toString());
    getSubCategoryDetails();
  }

  getSubCategoryDetails() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    var userID = userPref.getBool('isLogin') == null
        ? '7'
        : userPref.getString('userID').toString();
    isVisible = userPref.getBool('isLogin') == null
        ? false :true;
    log('isvisible------------------->$isVisible');
    var encodeBody = jsonEncode({
      "sub_category_id": argumentData[0].toString(),
      "user_id": userID,
    });
    log('----------encodeBody-------------');
    log(encodeBody);
    log('-----------------------');
    await ApiService.post("subCategoryDetails", encodeBody).then((success) {
      if (success.statusCode == 200) {
        var responseBody = json.decode(success.body);
        log(responseBody.toString());
        if (responseBody['status'] == 1) {
          subCategoryDetailList = responseBody['subCategoryDetails'];
          catID = subCategoryDetailList[0]['category_id'];
          catName = subCategoryDetailList[0]['category_name'];
          subCatID = subCategoryDetailList[0]['sub_category_id'];
          foodTypes.add(subCategoryDetailList[0]['foodTypes']);
          log(foodTypes.toString());
          log(foodTypes[0].toString());
          log(catID.toString());
          log(catName.toString());
          log(subCatID.toString());
          isLoading = false;
        } else {
          isLoading = false;
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        'Add Review',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFFF56844),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Review Title',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: shortTextController,
                        minLines: 1,
                        maxLines: 2,
                        maxLength: 20,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Review Description',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: longTextController,
                        minLines: 1,
                        maxLines: 3,
                        maxLength: 150,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Rating',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: ratingController,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        maxLength: 4,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 20),
                      //Buttons
                      Row(
                        children: [
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
                                addReviewApi();
                              },
                              child: const Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
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
                                Get.back();
                              },
                              child: const Text(
                                'Cancel',
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

  addReviewApi() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    var userID = userPref.getBool('isLogin') == null
        ? '7'
        : userPref.getString('userID').toString();
    var encodeBody = jsonEncode({
      "cat_id": catID,
      "sub_cat_id": subCatID,
      "user_id": userID,
      "rating": ratingController.text.toString(),
      "short_text": shortTextController.text.toString(),
      "long_text": longTextController.text.toString()
    });
    log('----------encodeBody-------------');
    log(encodeBody);
    log('-----------------------');
    await ApiService.post("addReview", encodeBody).then((success) {
      if (success.statusCode == 200) {
        var responseBody = json.decode(success.body);
        log(responseBody.toString());
        if (responseBody['status'] == 1) {
        } else {}
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
    getSubCategoryDetails();
    Get.back();
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
          getSubCategoryDetails();
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

  navigateTo(subCategoryDetailList) async {
    log(subCategoryDetailList.toString());
    SharedPreferences userPref = await SharedPreferences.getInstance();
    userPref.getBool('isLogin') == null
        ? Get.snackbar('Alert', 'Requires Log In/Sign Up For Paying Bill',
            backgroundColor: Constants.darkBlue,
            barBlur: 20,
            overlayBlur: 5,
            colorText: Colors.white,
            animationDuration: const Duration(seconds: 3))
        : Get.to(() => const PayBill(), arguments: subCategoryDetailList);
  }
}
