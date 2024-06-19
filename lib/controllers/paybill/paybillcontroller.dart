import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class PayBillController extends GetxController{
  dynamic argData = Get.arguments;
  TextEditingController amountController = TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (kDebugMode) {
      print(argData.toString());
    }
  }
}