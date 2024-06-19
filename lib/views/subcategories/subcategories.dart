import 'dart:developer';

import 'package:billspaye/views/subcategorydetails/subcategorydetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';

import '../../controllers/subcategories/subcategoriescontroller.dart';
import '../../widgets/constants.dart';

class SubCategories extends StatelessWidget {
  const SubCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<SubCategoriesController>(
        init: SubCategoriesController(),
        builder: (e) {
          return Scaffold(
            // backgroundColor: Constants.lightShadeColor,
            appBar: AppBar(
              backgroundColor: Constants.lightShadeColor,
              title: Text(e.argumentData[0].toString()),
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
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(20),
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(top: 5),
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: Constants.lightShadeColor,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: Constants.lightShadeColor,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: Constants.lightShadeColor,
                                  )),
                              hintText: 'Search here...',
                              prefixIcon: const Icon(
                                Icons.search,
                              ),
                              fillColor: Constants.lightShadeColor,
                              filled: true,
                            ),
                            onChanged: (value) {
                              e.filterList(value.toString());
                            },
                          ),
                        ),
                        e.subCategoryList.isNotEmpty
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                width: MediaQuery.of(context).size.width * 1,
                                child: SingleChildScrollView(
                                  physics: const ScrollPhysics(),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 8),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Deals of the day',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                      FlutterCarousel(
                                        options: CarouselOptions(
                                          aspectRatio: 2,
                                          autoPlay: true,
                                          autoPlayInterval:
                                              const Duration(seconds: 3),
                                          viewportFraction: 1,
                                          enlargeCenterPage: true,
                                          slideIndicator:
                                              CircularWaveSlideIndicator(),
                                          floatingIndicator: true,
                                        ),
                                        items: e.categoryOffersList
                                            .map((item) => Center(
                                                child: Image.network(
                                                    item['offerImg'].toString(),
                                                    fit: BoxFit.fill,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            1)))
                                            .toList(),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20, top: 20, bottom: 10),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Featured ${e.argumentData[0].toString()}s',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        child: ListView.builder(
                                          physics: const ScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: e.subCategoryList
                                                  .toString()
                                                  .isNotEmpty
                                              ? e.subCategoryList.length
                                              : 0,
                                          itemBuilder: (BuildContext context,
                                              int subIndex) {
                                            return GestureDetector(
                                              onTap: () {
                                                Get.to(
                                                    () =>
                                                        const SubCategoryDetailsScreen(),
                                                    arguments: [
                                                      e.subCategoryList[
                                                              subIndex][
                                                              'sub_category_id']
                                                          .toString(),
                                                      e.subCategoryList[
                                                              subIndex][
                                                              'sub_category_name']
                                                          .toString(),
                                                      e.argumentData[0].toString()
                                                    ]);
                                              },
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      spreadRadius: 2,
                                                      blurRadius: 2,
                                                      offset: Offset(0,
                                                          4), // changes position of shadow
                                                    ),
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      spreadRadius: 2,
                                                      blurRadius: 2,
                                                      offset: Offset(0,
                                                          1), // changes position of shadow
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20)),
                                                  border: Border.all(
                                                      color: Constants
                                                          .lightShadeColor),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20)),
                                                          image:
                                                              DecorationImage(
                                                                  image:
                                                                      NetworkImage(
                                                                    e.subCategoryList[
                                                                            subIndex]
                                                                            [
                                                                            'imagePath']
                                                                        .toString(),
                                                                  ),
                                                                  fit: BoxFit
                                                                      .fill)),
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(20),
                                                              topRight: Radius
                                                                  .circular(20),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          0),
                                                              bottomLeft: Radius
                                                                  .circular(0)),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 10,
                                                                      right:
                                                                          10),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      log('fav tapped');
                                                                      e.isLoading =
                                                                          true;
                                                                      e.addRemoveWishList(
                                                                          e.subCategoryList[subIndex]['category_id']
                                                                              .toString(),
                                                                          e.subCategoryList[subIndex]['sub_category_id']
                                                                              .toString());
                                                                    },
                                                                    child: e.subCategoryList[subIndex]['wishlist_status'].toString() ==
                                                                            "0"
                                                                        ? const Icon(
                                                                            Icons.favorite_border_sharp,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                30,
                                                                          )
                                                                        : const Icon(
                                                                            Icons.favorite,
                                                                            color:
                                                                                Colors.red,
                                                                            size:
                                                                                30,
                                                                          ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 120,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15,
                                                          vertical: 8),
                                                      decoration: const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          20))),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            width: 250,
                                                            child: Text(
                                                                e.subCategoryList[
                                                                        subIndex]
                                                                        [
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
                                                                )),
                                                          ),
                                                          Container(
                                                            height: 30,
                                                            width: 50,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            10)),
                                                                color: Constants
                                                                    .lightBlue),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Text(
                                                                    e.subCategoryList[
                                                                            subIndex]
                                                                            [
                                                                            'rating']
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        color:
                                                                            Colors
                                                                                .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            12)),
                                                                const Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .yellow,
                                                                  size: 15,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.height / 3),
                                child: Text(
                                  'No Records Found',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Constants.darkBlue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
