import 'dart:developer';

import 'package:get/get.dart';

class SeeAllReviewsController extends GetxController{
  dynamic argData = Get.arguments;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    log('argument Data');
    log(argData[0].toString());
    log(argData[1].toString());
    log(argData.length.toString());
  }
}