import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiservice/restapi.dart';
import '../../widgets/constants.dart';

class MyPaymentsController extends GetxController{

  // [{id: 1, transaction_id: pay_NqYXqTd54HUqdi, transaction_amount: 1.6, transaction_date: 2024-03-25 10:34:23, transactionTo: ASHA FAMILY RESTAURANT}, {id: 5, transaction_id: pay_NqZVj7YqqkmqwA, transaction_amount: 2, transaction_date: 2024-03-25 11:31:03, transactionTo: ASHA FAMILY RESTAURANT}]

  bool isLoading = true;
  List paymentData=[];


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPayments();
  }


  getPayments() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    var userID = userPref.getString('userID').toString();
    var encodeBody = jsonEncode({
      "user_id": userID,
    });
    log('----------encodeBody-------------');
    log(encodeBody);
    log('-----------------------');
    await ApiService.post("myPayments", encodeBody).then((success) {
      if (success.statusCode == 200) {
        var responseBody = json.decode(success.body);
        log(responseBody.toString());
        if (responseBody['status'] == 1) {
          paymentData = responseBody['payments'];
          log('===========================');
          log(paymentData.toString());
          log('===========================');
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

}