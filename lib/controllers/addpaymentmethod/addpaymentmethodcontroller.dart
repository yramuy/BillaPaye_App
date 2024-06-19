import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiservice/restapi.dart';
import '../../views/paymentsuccess/paymentsuccess.dart';
import '../../widgets/constants.dart';

class AddPaymentMethodController extends GetxController {
  dynamic argData = Get.arguments;
  bool isLoading = true;
  late Razorpay _razorpay;
  var paymentData = {};

  String transactionAmount = "";
  String discountAmount = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    log('argument data');
    log(argData[0].toString());
    log(argData[1].toString());
    log(argData[0][0]['sub_category_name'].toString());
    var val = argData[0][0]['latestOffer'].length == 0
        ? "0"
        : argData[0][0]['latestOffer']['offer'].toString().isEmpty
            ? "0"
            : argData[0][0]['latestOffer']['offer'].toString();
    log(val.toString());
    getPaymentData();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  getPaymentData() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    var userID = userPref.getBool('isLogin') == null
        ? '7'
        : userPref.getString('userID').toString();
    var offerVal = argData[0][0]['latestOffer']['offer'].toString();
    var encodeBody = jsonEncode({
      "user_id": userID,
      "cat_id": argData[0][0]['category_id'].toString(),
      "sub_cat_id": argData[0][0]['sub_category_id'].toString(),
      "offer": offerVal,
      "amount": argData[1].toString()
    });
    log('----------encodeBody-------------');
    log(encodeBody);
    log('-----------------------');
    await ApiService.post("proceedToPay", encodeBody).then((success) {
      if (success.statusCode == 200) {
        var responseBody = json.decode(success.body);
        log(responseBody.toString());
        if (responseBody['status'] == 1) {
          paymentData = responseBody['billDetails'];
          log('===========================');
          log(paymentData.toString());
          log('===========================');
          transactionAmount = paymentData['finalPrice'].toString();
          discountAmount = paymentData['savingPrice'].toString();
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

  openCheckout(amount, name) async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    var userContact = userPref.getString('userMob').toString();
    var userMail = userPref.getString('userEmail').toString();
    log('enter open checkout');
    log(amount.toString());
    log(name.toString());
    var options = {
      "key": 'rzp_live_Oi05AmtjWz0eLB',
      "amount": double.parse(amount) * 100,
      "currency": "INR",
      "name": name,
      "description": "BILLSPAYE",
      "prefill": {'contact': userContact, 'email': userMail},
      'external': {
        'wallets': ['paytm']
      }
    };
    log(options.toString());
    try {
      log('enter try block');
      _razorpay.open(options);
    } catch (e) {
      log('enter catch block');
      debugPrint('error:$e');
    }
  }

  handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Successful${response.paymentId}",
        toastLength: Toast.LENGTH_SHORT);
    log('Payment Successful');
    log(response.paymentId.toString());
    savePaymentData(response.paymentId);
    _razorpay.clear();
  }

  handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Failed${response.message}",
        toastLength: Toast.LENGTH_SHORT);
    _razorpay.clear();
  }

  handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet${response.walletName}",
        toastLength: Toast.LENGTH_SHORT);
    _razorpay.clear();
  }

  savePaymentData(transID) async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    var userID = userPref.getString('userID').toString();
    var offerVal = argData[0][0]['latestOffer']['offer'].toString();
    var encodeBody = jsonEncode({
      "merchant_id": "NeJVMDkL6ZZo5K",
      "transaction_id": transID,
      "transaction_by": userID,
      "transaction_to": argData[0][0]['sub_category_id'].toString(),
      "transaction_amount": transactionAmount,
      "original_amount": argData[1].toString(),
      "discount": offerVal,
      "discounted_amount": discountAmount,
      "final_amount": transactionAmount,
      "status": 1
    });
    log('----------encodeBody-------------');
    log(encodeBody);
    log('-----------------------');
    await ApiService.post("saveTransaction", encodeBody).then((success) {
      var responseBody = json.decode(success.body);
      isLoading = false;
      log(responseBody.toString());
      if (responseBody['status'] == 1) {
        Get.to(() => const PaymentSuccessPage(), arguments: paymentData);
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
