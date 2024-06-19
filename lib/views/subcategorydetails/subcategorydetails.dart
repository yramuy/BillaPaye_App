import 'dart:developer';
import 'package:billspaye/views/imageview/menuimageviewer.dart';
import 'package:billspaye/views/seeallreviews/seeallreviews.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/subcategorydetails/subcategorydetailscontroller.dart';
import '../../widgets/constants.dart';

class SubCategoryDetailsScreen extends StatelessWidget {
  const SubCategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<SubCategoryDetailsController>(
        init: SubCategoryDetailsController(),
        builder: (e) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Constants.lightShadeColor,
              title: Text(e.argumentData[1].toString()),
              titleTextStyle: TextStyle(
                  fontSize: 16,
                  color: Constants.darkBlue,
                  fontWeight: FontWeight.bold),
              leading: GestureDetector(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Constants.darkBlue,
                  size: 20,
                ),
              ),
            ),
            body: e.isLoading == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: Constants.darkBlue,
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 1,
                    width: MediaQuery.of(context).size.width * 1,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: e.subCategoryDetailList
                                        .toString()
                                        .isNotEmpty
                                    ? e.subCategoryDetailList.length
                                    : 0,
                                itemBuilder: (BuildContext context, int index) {
                                  log(e.subCategoryDetailList.toString());
                                  log(
                                    e.subCategoryDetailList[index]['subCatImg']
                                        .toString(),
                                  );
                                  return Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, right: 10, left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        border: Border.all(
                                            color: Constants.lightShadeColor),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              e.subCategoryDetailList[index]
                                                      ['subCatImg']
                                                  .toString(),
                                            ),
                                            fit: BoxFit.cover)),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    log('fav tapped');
                                                    e.isLoading = true;
                                                    e.addRemoveWishList(
                                                        e.subCategoryDetailList[
                                                                index]
                                                                ['category_id']
                                                            .toString(),
                                                        e.subCategoryDetailList[
                                                                index][
                                                                'sub_category_id']
                                                            .toString());
                                                  },
                                                  child: Card(
                                                    color: Colors.white,
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    100))),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: e.subCategoryDetailList[
                                                                      index][
                                                                      'wishlist_status']
                                                                  .toString() ==
                                                              "0"
                                                          ? const Icon(
                                                              Icons
                                                                  .favorite_border_sharp,
                                                              color: Colors.red,
                                                              size: 20,
                                                            )
                                                          : const Icon(
                                                              Icons.favorite,
                                                              color: Colors.red,
                                                              size: 20,
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                                // GestureDetector(
                                                //   onTap: () {
                                                //     // log('share tapped');
                                                //     // Share.share('hello',subject: "BillsPaye");
                                                //   },
                                                //   child: Card(
                                                //     color: Colors.white,
                                                //     shape: const RoundedRectangleBorder(
                                                //         borderRadius:
                                                //             BorderRadius.all(
                                                //                 Radius.circular(
                                                //                     100))),
                                                //     child: Container(
                                                //       alignment:
                                                //           Alignment.center,
                                                //       margin:
                                                //           const EdgeInsets.all(
                                                //               5),
                                                //       child: const Icon(
                                                //         Icons.share,
                                                //         color: Colors.red,
                                                //         size: 20,
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 120,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 8),
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20))),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 220,
                                                      child: Text(
                                                          e.subCategoryDetailList[
                                                                  index][
                                                                  'sub_category_name']
                                                              .toString(),
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          maxLines: 1,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      24)),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 30,
                                                      width: 50,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                          color: Constants
                                                              .lightBlue),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(
                                                              e.subCategoryDetailList[
                                                                      index]
                                                                      ['rating']
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      12)),
                                                          const Icon(
                                                            Icons.star,
                                                            color:
                                                                Colors.yellow,
                                                            size: 15,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  width: 300,
                                                  child: Text(
                                                      e.subCategoryDetailList[
                                                              index]
                                                              ['description']
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                      )),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment.start,
                                                //   children: [
                                                //     const Icon(
                                                //       Icons.timer_outlined,
                                                //       size: 15,
                                                //     ),
                                                //     const Text(" : ",
                                                //         style: TextStyle(
                                                //           color: Colors.black,
                                                //         )),
                                                //     Text(
                                                //         e.subCategoryDetailList[
                                                //                 index]
                                                //                 ['distance']
                                                //             .toString(),
                                                //         style: const TextStyle(
                                                //             color: Colors.black,
                                                //             fontSize: 12)),
                                                //   ],
                                                // ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      size: 15,
                                                    ),
                                                    const Text(" : ",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        )),
                                                    SizedBox(
                                                      width: 250,
                                                      child: Text(
                                                          e.subCategoryDetailList[
                                                                  index]
                                                                  ['address']
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      12)),
                                                    ),
                                                  ],
                                                ),
                                                e.subCategoryDetailList[0]
                                                            ['foodTypes']
                                                        .toString()
                                                        .isNotEmpty
                                                    ? Column(
                                                        children: [
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Available Food : ',
                                                                style: TextStyle(
                                                                    color: Constants
                                                                        .darkBlue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(
                                                                e.subCategoryDetailList[
                                                                        0][
                                                                    'foodTypes'],
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                        ],
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              DottedLine(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.center,
                                lineLength: double.infinity,
                                lineThickness: 2.0,
                                dashLength: 10.0,
                                dashColor:
                                    const Color(0xff969696).withOpacity(0.4),
                                dashRadius: 0.0,
                                dashGapLength: 10.0,
                                dashGapColor: Colors.transparent,
                                dashGapRadius: 0.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 20, bottom: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Scrollable.ensureVisible(
                                            e.offersKey.currentContext!,
                                            duration: const Duration(
                                                milliseconds: 3000));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: const Color(0xffE6EBF5),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: const Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(30))),
                                            child: Image.asset(
                                              'assets/icons/offersicon.png',
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text('Offers')
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Scrollable.ensureVisible(
                                            e.menuKey.currentContext!,
                                            duration: const Duration(
                                                milliseconds: 3000));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: const Color(0xffE6EBF5),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: const Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(30))),
                                            child: Image.asset(
                                              'assets/icons/menuicon.png',
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          e.catName != "Restaurant" ||
                                                  e.catName == "restaurant"
                                              ? const Text('Prices')
                                              : const Text('Menu')
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Scrollable.ensureVisible(
                                            e.photosKey.currentContext!,
                                            duration: const Duration(
                                                milliseconds: 3000));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: const Color(0xffE6EBF5),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: const Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(30))),
                                            child: Image.asset(
                                              'assets/icons/photosicon.png',
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text('Photos')
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Scrollable.ensureVisible(
                                            e.reviewsKey.currentContext!,
                                            duration: const Duration(
                                                milliseconds: 3000));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: const Color(0xffE6EBF5),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: const Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(30))),
                                            child: Image.asset(
                                              'assets/icons/reviewicon.png',
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text('Reviews')
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Scrollable.ensureVisible(
                                            e.aboutKey.currentContext!,
                                            duration: const Duration(
                                                milliseconds: 3000));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: const Color(0xffE6EBF5),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: const Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(30))),
                                            child: Image.asset(
                                              'assets/icons/abouticon.png',
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text('About')
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              DottedLine(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.center,
                                lineLength: double.infinity,
                                lineThickness: 2.0,
                                dashLength: 10.0,
                                dashColor:
                                    const Color(0xff969696).withOpacity(0.4),
                                dashRadius: 0.0,
                                dashGapLength: 10.0,
                                dashGapColor: Colors.transparent,
                                dashGapRadius: 0.0,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Padding(
                                key: e.offersKey,
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: const Text(
                                  'Offers for you',
                                  style: TextStyle(
                                      color: Color(0xFF3F4953),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: GridView.builder(
                                    physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 150,
                                            maxCrossAxisExtent: 150,
                                            childAspectRatio: 2.5 / 2,
                                            crossAxisSpacing: 20,
                                            mainAxisSpacing: 10),
                                    itemCount: e
                                        .subCategoryDetailList[0]
                                            ['offerDetails']
                                        .length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFD0C8D4),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(30),
                                              topRight: Radius.circular(30)),
                                          image: DecorationImage(
                                              image: NetworkImage(e
                                                  .subCategoryDetailList[0]
                                                      ['offerDetails'][index]
                                                      ['offerImg']
                                                  .toString()),
                                              fit: BoxFit.fill),
                                        ),
                                      );
                                    }),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              DottedLine(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.center,
                                lineLength: double.infinity,
                                lineThickness: 2.0,
                                dashLength: 10.0,
                                dashColor:
                                    const Color(0xff969696).withOpacity(0.4),
                                dashRadius: 0.0,
                                dashGapLength: 10.0,
                                dashGapColor: Colors.transparent,
                                dashGapRadius: 0.0,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                key: e.menuKey,
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: e.catName != "Restaurant" ||
                                        e.catName == "restaurant"
                                    ? const Text(
                                        'Prices',
                                        style: TextStyle(
                                            color: Color(0xFF3F4953),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    : const Text(
                                        'Menu',
                                        style: TextStyle(
                                            color: Color(0xFF3F4953),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              e.subCategoryDetailList[0]['menuDetails']
                                          .length ==
                                      0
                                  ? e.catName != "Restaurant" ||
                                          e.catName == "restaurant"
                                      ? const Center(
                                          child: Text(
                                            'No Prices available',
                                            style: TextStyle(
                                                color: Color(0xFF3F4953),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        )
                                      : const Center(
                                          child: Text(
                                            'No Menu available',
                                            style: TextStyle(
                                                color: Color(0xFF3F4953),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: SizedBox(
                                        height: 300,
                                        child: PageView.builder(
                                            itemCount: e
                                                .subCategoryDetailList[0]
                                                    ['menuDetails']
                                                .length,
                                            pageSnapping: true,
                                            controller: e.pageController,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                    () =>
                                                        const MenuImageViewer(),
                                                    arguments: [
                                                      e.subCategoryDetailList[0]
                                                              ['menuDetails']
                                                          [index]['menuImg'],
                                                      'Menu'
                                                    ],
                                                  );
                                                },
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  margin:
                                                      const EdgeInsets.all(10),
                                                  child: Image.network(
                                                      e.subCategoryDetailList[0]
                                                              ['menuDetails']
                                                          [index]['menuImg'],
                                                      fit: BoxFit.fill),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              DottedLine(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.center,
                                lineLength: double.infinity,
                                lineThickness: 2.0,
                                dashLength: 10.0,
                                dashColor:
                                    const Color(0xff969696).withOpacity(0.4),
                                dashRadius: 0.0,
                                dashGapLength: 10.0,
                                dashGapColor: Colors.transparent,
                                dashGapRadius: 0.0,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                key: e.photosKey,
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: const Text(
                                  'Photos',
                                  style: TextStyle(
                                      color: Color(0xFF3F4953),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              e.subCategoryDetailList[0]['photos'].length == 0
                                  ? const Center(
                                      child: Text(
                                        'No photos available',
                                        style: TextStyle(
                                            color: Color(0xFF3F4953),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 200,
                                      child: PageView.builder(
                                          itemCount: e
                                              .subCategoryDetailList[0]
                                                  ['photos']
                                              .length,
                                          pageSnapping: true,
                                          controller: e.pageController,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Get.to(
                                                  () => const MenuImageViewer(),
                                                  arguments: [
                                                    e.subCategoryDetailList[0]
                                                            ['photos'][index]
                                                        ['photoImg'],
                                                    'Photos'
                                                  ],
                                                );
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Image.network(
                                                    e.subCategoryDetailList[0]
                                                            ['photos'][index]
                                                        ['photoImg'],
                                                    fit: BoxFit.fill),
                                              ),
                                            );
                                          }),
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              DottedLine(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.center,
                                lineLength: double.infinity,
                                lineThickness: 2.0,
                                dashLength: 10.0,
                                dashColor:
                                    const Color(0xff969696).withOpacity(0.4),
                                dashRadius: 0.0,
                                dashGapLength: 10.0,
                                dashGapColor: Colors.transparent,
                                dashGapRadius: 0.0,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                key: e.reviewsKey,
                                padding:
                                    const EdgeInsets.only(left: 30, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Reviews',
                                      style: TextStyle(
                                          color: Color(0xFF3F4953),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Visibility(
                                      visible: e.isVisible,
                                      child: GestureDetector(
                                        onTap: () {
                                          log('add review tapped');
                                          e.addReviewDialog();
                                        },
                                        child: const Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(top: 5),
                                              child: Icon(
                                                Icons.rate_review_outlined,
                                                color: Color(0xFFF56844),
                                                size: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Add Review',
                                              style: TextStyle(
                                                  color: Color(0xFFF56844),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
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
                              ),
                              e.subCategoryDetailList[0]['reviews'].length == 0
                                  ? const Center(
                                      child: Text(
                                        'No reviews available, Be the first one to review',
                                        style: TextStyle(
                                            color: Color(0xFF3F4953),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    )
                                  : SizedBox(
                                      // width: MediaQuery.of(context).size.width/0.1,
                                      height: 220,
                                      child: ListView.builder(
                                        physics: const ScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: e
                                            .subCategoryDetailList[0]['reviews']
                                            .length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: 320,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFCBD2DE)
                                                  .withOpacity(0.35),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xFFACACAC)),
                                            ),
                                            child: SingleChildScrollView(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            50)),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          child: Icon(
                                                            Icons.person,
                                                            color: Constants
                                                                .darkBlue,
                                                            size: 30,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              e.subCategoryDetailList[
                                                                      0][
                                                                      'reviews']
                                                                      [index][
                                                                      'user_name']
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                              height: 3,
                                                            ),
                                                            // Row(
                                                            //   children: [
                                                            //     const Icon(
                                                            //       Icons.edit,
                                                            //       color: Color(
                                                            //           0xFF73738F),
                                                            //       size: 14,
                                                            //     ),
                                                            //     const SizedBox(
                                                            //       width: 5,
                                                            //     ),
                                                            //     Text(
                                                            //       e.subCategoryDetailList[
                                                            //               index]
                                                            //               [
                                                            //               'reviewCnt']
                                                            //           .toString(),
                                                            //       style:
                                                            //           const TextStyle(
                                                            //         color: Color(
                                                            //             0xFF73738F),
                                                            //       ),
                                                            //     ),
                                                            //   ],
                                                            // ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    const Divider(
                                                      color: Color(0xFFE8E8E8),
                                                      thickness: 2,
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black12),
                                                          ),
                                                          child:
                                                              RatingBarIndicator(
                                                            unratedColor:
                                                                Colors.grey,
                                                            rating: double.parse(e
                                                                .subCategoryDetailList[
                                                                    0]
                                                                    ['reviews']
                                                                    [index]
                                                                    ['rating']
                                                                .toString()),
                                                            itemBuilder:
                                                                (context,
                                                                        index) =>
                                                                    const Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                            itemCount: 5,
                                                            itemSize: 20.0,
                                                          ),
                                                        ),
                                                        Text(
                                                          e.subCategoryDetailList[
                                                                  0]['reviews']
                                                                  [index]
                                                                  ['date']
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0xFF73738F),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      e.subCategoryDetailList[0]
                                                              ['reviews'][index]
                                                              ['short_text']
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    SingleChildScrollView(
                                                      child: Text(
                                                        e.subCategoryDetailList[
                                                                0]['reviews']
                                                                [index]
                                                                ['long_text']
                                                            .toString(),
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    const Divider(
                                                      color: Color(0xFFE8E8E8),
                                                      thickness: 2,
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const SeeAllReviews(),
                                      arguments: [
                                        e.subCategoryDetailList[0]['reviews'],
                                        e.argumentData[1].toString()
                                      ]);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    border: Border.all(
                                        color: const Color(0xFFACACAC)),
                                  ),
                                  child: Text(
                                    'See all reviews(${e.subCategoryDetailList[0]['reviews'].length})',
                                    style: const TextStyle(
                                        color: Color(0xFF545454),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              DottedLine(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.center,
                                lineLength: double.infinity,
                                lineThickness: 2.0,
                                dashLength: 10.0,
                                dashColor:
                                    const Color(0xff969696).withOpacity(0.4),
                                dashRadius: 0.0,
                                dashGapLength: 10.0,
                                dashGapColor: Colors.transparent,
                                dashGapRadius: 0.0,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                key: e.aboutKey,
                                padding:
                                    const EdgeInsets.only(left: 30, right: 20),
                                child: const Text(
                                  'About',
                                  style: TextStyle(
                                      color: Color(0xFF3F4953),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 20),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0xFFBDBDBD),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(1, 1),
                                        ),
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          e.subCategoryDetailList[0]
                                                  ['description']
                                              .toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                size: 15,
                                              ),
                                              Text(" : ",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.6,
                                            child: Text(
                                                e.subCategoryDetailList[0]
                                                        ['address']
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12)),
                                          ),
                                        ],
                                      ),
                                      e.subCategoryDetailList[0]['foodTypes']
                                              .toString()
                                              .isNotEmpty
                                          ? Column(
                                              children: [
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Available Food : ',
                                                      style: TextStyle(
                                                          color: Constants
                                                              .darkBlue,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      e.subCategoryDetailList[0]
                                                          ['foodTypes'],
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Visibility(
                                            visible: e.subCategoryDetailList[0]
                                                            ['direction_link']
                                                        .toString()
                                                        .isEmpty ||
                                                    e.subCategoryDetailList[0][
                                                                'direction_link']
                                                            .toString() ==
                                                        "null"
                                                ? false
                                                : true,
                                            child: GestureDetector(
                                              onTap: () async {
                                                log('Get Directions');
                                                var url = e
                                                    .subCategoryDetailList[0]
                                                        ['direction_link']
                                                    .toString();
                                                log('URL----->$url');
                                                if (url.toString().isNotEmpty) {
                                                  if (await canLaunchUrl(
                                                      Uri.parse(
                                                          url.toString()))) {
                                                    await launchUrl(
                                                        Uri.parse(
                                                            url.toString()),
                                                        mode: LaunchMode
                                                            .externalApplication);
                                                  } else {
                                                    throw 'Could not launch $url';
                                                  }
                                                } else {
                                                  Get.snackbar('Alert',
                                                      'Something went wrong, Please retry later',
                                                      backgroundColor:
                                                          Constants.darkBlue,
                                                      barBlur: 20,
                                                      overlayBlur: 5,
                                                      colorText: Colors.white,
                                                      animationDuration:
                                                          const Duration(
                                                              seconds: 3));
                                                }
                                              },
                                              child: DottedBorder(
                                                radius:
                                                    const Radius.circular(10),
                                                color: Colors.black,
                                                strokeWidth: 1.2,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        'assets/icons/direction_icon.png',
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      // direction_link
                                                      const Text(
                                                          "Get directions",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: e.subCategoryDetailList[0]
                                                            ['telephone_number']
                                                        .toString()
                                                        .isEmpty ||
                                                    e.subCategoryDetailList[0][
                                                                'telephone_number']
                                                            .toString() ==
                                                        "null"
                                                ? false
                                                : true,
                                            child: DottedBorder(
                                              radius: const Radius.circular(10),
                                              color: Colors.black,
                                              strokeWidth: 1.2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/icons/dialer_icon.png',
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                        e.subCategoryDetailList[
                                                                0][
                                                                'telephone_number']
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ]),
                      ),
                    ),
                  ),
            bottomNavigationBar: GestureDetector(
              onTap: () {
                e.navigateTo(e.subCategoryDetailList);
              },
              child: Container(
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                decoration: BoxDecoration(
                    color: Constants.lightBlue,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                height: 50,
                child: const Text(
                  "Pay Bill",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
