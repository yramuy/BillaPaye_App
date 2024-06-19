import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../apiservice/restapi.dart';
import '../../views/subcategorydetails/subcategorydetails.dart';
import '../../widgets/constants.dart';

class OffersController extends GetxController {
  bool isLoading = true;
  List categoryTitleList = [];
  List offersList = [];
  String categoryID = '0';
  String? filterDropDownValue;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPosts();
  }

  getPosts() async {
    await ApiService.get("posts").then((success) {
      if (success.statusCode == 200) {
        var responseBody = json.decode(success.body);
        isLoading = false;
        log(responseBody.toString());
        if (responseBody['status'] == 1) {
          offersList = responseBody['posts'];
          log('===========================');
          log(offersList.toString());
          log('===========================');
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
