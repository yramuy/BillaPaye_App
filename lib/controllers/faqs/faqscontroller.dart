import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiservice/restapi.dart';
import '../../widgets/constants.dart';

class FAQController extends GetxController {
  // [{id: 1, transaction_id: pay_NqYXqTd54HUqdi, transaction_amount: 1.6, transaction_date: 2024-03-25 10:34:23, transactionTo: ASHA FAMILY RESTAURANT}, {id: 5, transaction_id: pay_NqZVj7YqqkmqwA, transaction_amount: 2, transaction_date: 2024-03-25 11:31:03, transactionTo: ASHA FAMILY RESTAURANT}]

  bool isLoading = true;
  List faqData = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getFAQs();
  }


  getFAQs() async {
    await ApiService.get("policy_list").then((success) {
      if (success.statusCode == 200) {
        var responseBody = json.decode(success.body);
        if (responseBody['status'] == 1) {
          faqData = responseBody['policy'];
          log(responseBody.toString());
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
}
