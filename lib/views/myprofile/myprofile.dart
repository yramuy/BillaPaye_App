import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/myprofile/myprofilecontroller.dart';
import '../../widgets/constants.dart';
import '../profileupdate/profileupdate.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyProfileController>(
      init: MyProfileController(),
      builder: (e) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.lightBlue.withOpacity(0.8),
            title: const Text('My Profile'),
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
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [
                  0.2,
                  0.5,
                  0.2,
                  0.5
                ],
                    colors: [
                  Constants.lightBlue.withOpacity(0.2),
                  Constants.lightBlue.withOpacity(0.2),
                  Constants.lightBlue.withOpacity(0.8),
                  Constants.lightBlue.withOpacity(0.8)
                ])),
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            child: e.isLoading==true?
                Center(
                  child: CircularProgressIndicator(
                    color: Constants.darkBlue,
                  ),
                ):
            SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: e.userDetails['profilePic'].toString().isEmpty?Container(
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
                    ):Container(
                      width: 150.0,
                      height: 150.0,
                      margin: const EdgeInsets.all(30),
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Image.network(e.userDetails['profilePic'].toString(),fit: BoxFit.fill,),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(-1, -1), // changes position of shadow
                        ),
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(1, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Table(
                          children: [
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Name :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Constants.darkBlue),
                                ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(e.userDetails['user_name'].toString()),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Contact :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Constants.darkBlue),
                                ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(e.userDetails['mobileno'].toString()),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Email :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Constants.darkBlue),
                                ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(e.userDetails['email'].toString()),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'City :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Constants.darkBlue),
                                ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(e.userDetails['city'].toString()),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'State :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Constants.darkBlue),
                                ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(e.userDetails['state'].toString()),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'PinCode :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Constants.darkBlue),
                                ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(e.userDetails['pincode'].toString()),
                              )),
                            ]),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => Get.to(() => const ProfileUpdate()),
                            child: Container(
                                alignment: Alignment.center,
                                width: 100,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Constants.lightBlue,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'EDIT',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                )),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
