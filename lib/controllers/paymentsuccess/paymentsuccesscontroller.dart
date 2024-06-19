import 'dart:developer';

import 'package:get/get.dart';

class PaymentSuccessController extends GetxController{
dynamic argData = Get.arguments;

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    log('argument data');
    log(argData.toString());
  }
}