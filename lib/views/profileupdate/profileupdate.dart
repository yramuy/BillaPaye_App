import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../controllers/profileupdate/profileupdatecorntroller.dart';
import '../../widgets/constants.dart';

class ProfileUpdate extends StatelessWidget {
  const ProfileUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileUpdateController>(
      init: ProfileUpdateController(),
      builder: (e) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.lightBlue.withOpacity(0.8),
            title: const Text('Profile Update'),
            titleTextStyle: const TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: e.names.isEmpty
                        ? Container(
                            width: 150.0,
                            height: 150.0,
                            margin: const EdgeInsets.all(30),
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              color: Colors.black26,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: const Icon(
                              Icons.person_outline,
                              size: 100,
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.all(30),
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              color: Colors.black26,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Image.memory(
                              base64Decode(e.baseImg[0]),
                              height: 200,
                              width: 200,
                              fit: BoxFit.fill,
                              excludeFromSemantics: true,
                            )),
                  ),
                  GestureDetector(
                    onTap: () {
                      e.imageDialog();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Constants.lightBlue,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'Change',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: e.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: e.firstNameController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Enter FirstName',
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Enter a valid FirstName';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: e.lastNameController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Enter LastName',
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Enter a valid LastName';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: e.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Enter email ID',
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value.toString())) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: e.mobController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Mobile Number',
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Enter a valid Mobile Number';
                            } else if (value.toString().length > 10 ||
                                value.toString().length < 10) {
                              return 'Mobile Number must be 10 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                          hint: const Text(
                            'Select State',
                          ),
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder()),
                          isDense: true,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Constants.darkBlue,
                          ),
                          iconSize: 30,
                          items: e.statesList.map((item) {
                            return DropdownMenuItem(
                              value: item['id'].toString(),
                              child: Text(
                                item['name'],
                                style: const TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          value: e.stateDropDownValue,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Select State';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            log('Selected State is $value');
                            e.stateDropDownValue = value.toString();
                            e.getDistrictsApi(value);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                          hint: const Text(
                            'Select District',
                          ),
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder()),
                          isDense: true,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Constants.darkBlue,
                          ),
                          iconSize: 30,
                          items: e.citiesList.map((item) {
                            return DropdownMenuItem(
                              value: item['id'].toString(),
                              child: Text(
                                item['city'].toString(),
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            );
                          }).toList(),
                          value: e.cityDropDownValue,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Select District';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            e.cityDropDownValue = value.toString();
                            log('Selected District is $value');
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: e.pinCodeController,
                          keyboardType: const TextInputType.numberWithOptions(),
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Enter PinCode',
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Enter a valid Pin Code';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (e.formKey.currentState!.validate()) {
                              log(e.firstNameController.text.toString());
                              log(e.lastNameController.text.toString());
                              log(e.emailController.text.toString());
                              log(e.mobController.text.toString());
                              log(e.stateDropDownValue.toString());
                              log(e.cityDropDownValue.toString());
                              log(e.pinCodeController.text.toString());
                              e.saveApi(
                                  'update_account',
                                  e.firstNameController.text.toString(),
                                  e.lastNameController.text.toString(),
                                  e.emailController.text.toString(),
                                  e.mobController.text.toString(),
                                  e.stateDropDownValue.toString(),
                                  e.cityDropDownValue.toString(),
                                  e.pinCodeController.text.toString(),
                                  e.paths.toString().isEmpty?"":e.paths[0].toString());
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                color: Constants.lightBlue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
