import 'package:billspaye/views/login/selectelogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

import '../../controllers/bottomnavigation/bottomnavigationcontroller.dart';
import '../../views/contactus/contactus.dart';
import '../../views/faqs/faqs.dart';
import '../../views/mypayments/mypayments.dart';
import '../../views/myprofile/myprofile.dart';
import '../constants.dart';

class BottomNavigationTileScreen extends StatelessWidget {
  const BottomNavigationTileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationController>(
        init: BottomNavigationController(),
        builder: (controller) => Scaffold(
              backgroundColor: Colors.white,
              body: AdvancedDrawer(
                  backdrop: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // color: Constants.lightBlue
                    ),
                  ),
                  controller: controller.advancedDrawerController,
                  animationCurve: Curves.easeInOut,
                  animationDuration: const Duration(milliseconds: 300),
                  animateChildDecoration: true,
                  rtlOpening: false,
                  // openScale: 1.0,
                  disabledGestures: false,
                  childDecoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  drawer: SafeArea(
                    bottom: true,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 1,
                      color: Constants.lightBlue,
                      // color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Visibility(
                              visible:
                                  controller.loginValue == false ? false : true,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 1,
                                color: const Color(0xFFdadada),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100.0,
                                      height: 100.0,
                                      margin: const EdgeInsets.only(
                                        top: 24.0,
                                        bottom: 24.0,
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
                                        color: Colors.black26,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                          controller.userProImage.toString()),
                                    ),
                                    SizedBox(
                                      width: 100.0,
                                      child: Text(
                                        controller.loginValue == false
                                            ? ''
                                            : controller.userName.toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Constants.darkBlue,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        controller.loginValue == false
                                            ? ''
                                            : controller.userMail.toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Constants.darkBlue,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SafeArea(
                              bottom: true,
                              child: Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    decoration: const BoxDecoration(
                                        color: Color(0xFFf1f1f1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 15, right: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Visibility(
                                          visible: controller.loginValue == true
                                              ? false
                                              : true,
                                          child: ListTile(
                                            onTap: () {
                                              Get.to(() =>
                                                  const ChooseLoginScreen());
                                            },
                                            leading: Icon(
                                              Icons.person_add_alt_1,
                                              color: Constants.lightBlue,
                                              size: 20,
                                            ),
                                            title: Text(
                                              'Log In/Sign Up',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Constants.darkBlue,
                                              ),
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Constants.lightBlue,
                                              // size: 30,
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible:
                                              controller.loginValue == false
                                                  ? false
                                                  : true,
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.offAll(() =>
                                                      const BottomNavigationTileScreen());
                                                },
                                                child: ListTile(
                                                  leading: Icon(
                                                    Icons.home_outlined,
                                                    color: Constants.lightBlue,
                                                    size: 20,
                                                  ),
                                                  title: Text(
                                                    'Home',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Constants.darkBlue,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                onTap: () {
                                                  Get.offAll(() =>
                                                      const BottomNavigationTileScreen());
                                                },
                                                leading: Icon(
                                                  Icons.category_outlined,
                                                  color: Constants.lightBlue,
                                                  size: 20,
                                                ),
                                                title: Text(
                                                  'Shop by Category',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Constants.darkBlue,
                                                  ),
                                                ),
                                                trailing: Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  color: Constants.lightBlue,
                                                  // size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: controller.loginValue == false
                                        ? false
                                        : true,
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      decoration: const BoxDecoration(
                                          color: Color(0xFFf1f1f1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 15, right: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            onTap: () {
                                              Get.to(() => const MyProfile());
                                            },
                                            leading: Icon(
                                              Icons.person,
                                              color: Constants.lightBlue,
                                              size: 20,
                                            ),
                                            title: Text(
                                              'My Profile',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Constants.darkBlue,
                                              ),
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Constants.lightBlue,
                                              size: 20,
                                            ),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              Get.to(() => const MyPayments());
                                            },
                                            leading: Icon(
                                              Icons.list_alt,
                                              color: Constants.lightBlue,
                                              size: 20,
                                            ),
                                            title: Text(
                                              'My Payments',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Constants.darkBlue,
                                              ),
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Constants.lightBlue,
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: controller.loginValue == false
                                        ? false
                                        : true,
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      decoration: const BoxDecoration(
                                          color: Color(0xFFf1f1f1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 15, right: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            onTap: () {
                                              Get.to(() => const ContactUs());
                                            },
                                            leading: Icon(
                                              Icons.phone_callback_sharp,
                                              color: Constants.lightBlue,
                                              size: 20,
                                            ),
                                            title: Text(
                                              'Contact Us',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Constants.darkBlue,
                                              ),
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Constants.lightBlue,
                                              size: 20,
                                            ),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              Get.to(() => const FAQScreen());
                                            },
                                            leading: Icon(
                                              Icons.help_center,
                                              color: Constants.lightBlue,
                                              size: 20,
                                            ),
                                            title: Text(
                                              'About',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Constants.darkBlue,
                                              ),
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Constants.lightBlue,
                                              size: 20,
                                            ),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              controller.addReviewDialog();
                                            },
                                            leading: Icon(
                                              Icons.delete_forever,
                                              color: Constants.lightBlue,
                                              size: 20,
                                            ),
                                            title: Text(
                                              'Delete Account',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Constants.darkBlue,
                                              ),
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Constants.lightBlue,
                                              size: 20,
                                            ),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              controller.setLogOut();
                                            },
                                            leading: Icon(
                                              Icons.exit_to_app_sharp,
                                              color: Constants.lightBlue,
                                              size: 20,
                                            ),
                                            title: Text(
                                              'Log Out',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Constants.darkBlue,
                                              ),
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Constants.lightBlue,
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      title: Row(
                        children: [
                          controller.loginValue == false
                              ? const Text(
                                  'Hello Welcome!',
                                )
                              : Text(
                                  'Hello ${controller.userName.toString().capitalize}',
                                ),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            'assets/icons/helloicon.png',
                            height: 30,
                            width: 30,
                          ),
                        ],
                      ),
                      titleTextStyle: TextStyle(
                          fontSize: 16,
                          color: Constants.darkBlue,
                          fontWeight: FontWeight.bold),
                      leading: IconButton(
                        onPressed: () {
                          controller.advancedDrawerController.showDrawer();
                        },
                        icon: ValueListenableBuilder<AdvancedDrawerValue>(
                          valueListenable: controller.advancedDrawerController,
                          builder: (_, value, __) {
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: Icon(
                                value.visible ? Icons.clear : Icons.menu,
                                color: value.visible
                                    ? Constants.darkBlue
                                    : Constants.darkBlue,
                                key: ValueKey<bool>(value.visible),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    body: GetBuilder<BottomNavigationController>(
                      builder: (controller) => SizedBox(
                        height: MediaQuery.of(context).size.height * 1,
                        width: MediaQuery.of(context).size.width * 1,
                        child: controller.screenOptions
                            .elementAt(controller.selectedIndex),
                      ),
                    ),
                    bottomNavigationBar: Container(
                      decoration: const BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: BottomNavigationBar(
                          backgroundColor: Colors.white,
                          items: <BottomNavigationBarItem>[
                            const BottomNavigationBarItem(
                                label: 'Home',
                                icon: Icon(
                                  Icons.home_outlined,
                                ),
                                backgroundColor: Colors.white),
                            BottomNavigationBarItem(
                                label: 'Posts',
                                icon: const Icon(Icons.local_offer_sharp),
                                backgroundColor: Constants.lightShadeColor),
                            BottomNavigationBarItem(
                                label: 'Scan',
                                icon: const Icon(Icons.qr_code_scanner_sharp),
                                backgroundColor: Constants.lightShadeColor),
                            BottomNavigationBarItem(
                                label: 'Wishlist',
                                icon: const Icon(Icons.favorite_border_sharp),
                                backgroundColor: Constants.lightShadeColor),
                          ],
                          type: BottomNavigationBarType.fixed,
                          currentIndex: controller.selectedIndex,
                          selectedItemColor: const Color(0xFF546575),
                          showUnselectedLabels: true,
                          unselectedLabelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFACACAC)),
                          unselectedItemColor: const Color(0xFFACACAC),
                          iconSize: 30,
                          selectedLabelStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          onTap: controller.onItemTapped,
                          elevation: 10),
                    ),
                  )),
            ));
  }
}
