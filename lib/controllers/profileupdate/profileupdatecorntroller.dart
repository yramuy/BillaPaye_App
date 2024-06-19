import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiservice/restapi.dart';
import '../../widgets/bottomnavigation/bottomnavigation.dart';
import '../../widgets/constants.dart';
import '../bottomnavigation/bottomnavigationcontroller.dart';
import '../myprofile/myprofilecontroller.dart';

class ProfileUpdateController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  File? image, selectedImage;
  List names = [], paths = [], baseImg = [];
  List statesList = [];
  String? stateDropDownValue;
  List citiesList = [];
  String? cityDropDownValue;

  var getC = Get.put(MyProfileController());

  var getController = Get.put(BottomNavigationController());

  @override
  void onInit() {
    super.onInit();
    getStatesApi();
  }

  getStatesApi() async {
    await ApiService.get("states").then((success) {
      if (success.statusCode == 200) {
        var responseBody = json.decode(success.body);
        log(responseBody.toString());
        if (responseBody['status'] == 1) {
          statesList = responseBody['states'];
        } else {
          Get.snackbar('Alert', 'No States Found',
              backgroundColor: Constants.darkBlue,
              barBlur: 20,
              overlayBlur: 5,
              colorText: Colors.white,
              animationDuration: const Duration(seconds: 3));
          log('error');
        }
      } else {
        Get.snackbar(
            'Alert', 'No States Found Something went wrong, Please retry later',
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

  getDistrictsApi(sID) async {
    var encodeBody = jsonEncode({"state_id": sID});
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

  imageDialog() {
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          log('from camera');
                          takePhoto();
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 300,
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              color: Constants.lightBlue,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            'Take Photo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          log('from gallery');
                          takeGalleryPhoto();
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 300,
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              color: Constants.lightBlue,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            'Choose From Gallery',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
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

  takePhoto() async {
    names = [];
    paths = [];
    baseImg = [];
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 20,
    );

    final File file = File(image!.path);
    try {
      if (image != null) {
        selectedImage = file;
        String fileName = image.path.toString().split('/').last;
        List<int> imageBytes = selectedImage!.readAsBytesSync();
        var imageB64 = base64Encode(imageBytes);
        baseImg.add(imageB64);
        names.add(fileName);
        paths.add(image.path.toString());
        log(names.toString());
        update();
      }
    } catch (e) {
      log(e.toString());
    }
    update();
  }

  takeGalleryPhoto() async {
    names = [];
    paths = [];
    baseImg = [];
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );

    final File file = File(image!.path);
    try {
      if (image != null) {
        selectedImage = file;
        String fileName = image.path.toString().split('/').last;
        List<int> imageBytes = selectedImage!.readAsBytesSync();
        var imageB64 = base64Encode(imageBytes);
        baseImg.add(imageB64);
        names.add(fileName);
        paths.add(image.path.toString());
        log(names.toString());
        update();
      }
    } catch (e) {
      log(e.toString());
    }
    update();
  }

  saveApi(
    String url,
    String firstName,
    String lastName,
    String emailID,
    String mobNum,
    String stateID,
    String cityID,
    String pinCode,
    String profileFilepath,
  ) async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    var userID = userPref.getString('userID').toString();
    log('encoded body');
    log(url.toString());
    log(firstName.toString());
    log(lastName.toString());
    log(emailID.toString());
    log(mobNum.toString());
    log(stateID.toString());
    log(cityID.toString());
    log(pinCode.toString());
    log(userID.toString());
    log(profileFilepath.toString());
    await ApiService.saveProfile(url, firstName, lastName, emailID, mobNum,
            stateID, cityID, pinCode, userID, profileFilepath)
        .then((success) {
      var responseBody = json.decode(success);
      log(responseBody.toString());
      if (responseBody['status'] == 1) {
        // saveUserDetails(responseBody);
        Get.snackbar('Alert', responseBody['message'].toString(),
            backgroundColor: Constants.darkBlue,
            barBlur: 20,
            overlayBlur: 5,
            colorText: Colors.white,
            animationDuration: const Duration(seconds: 3));
        getC.getUserData();
        Get.offAll(() => const BottomNavigationTileScreen());
      } else {
        Get.snackbar('Alert', responseBody['message'].toString(),
            backgroundColor: Constants.darkBlue,
            barBlur: 20,
            overlayBlur: 5,
            colorText: Colors.white,
            animationDuration: const Duration(seconds: 3));
        log('error');
      }
    });
    update();
  }
}
