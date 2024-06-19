import 'dart:developer';

import 'package:billspaye/controllers/home/homescreencontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';

import '../../widgets/constants.dart';
import '../subcategories/subcategories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (controller) => controller.isLoading == true
          ? Center(
              child: CircularProgressIndicator(
              color: Constants.darkBlue,
            ))
          : SizedBox(
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 1,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      height: 50,
                      child: DropdownButtonFormField(
                        hint: Text(
                          controller.cityName.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black38),
                        ),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.location_on_outlined,
                          ),
                          border: InputBorder.none,
                          fillColor: Constants.lightShadeColor,
                          filled: true,
                        ),
                        isDense: true,
                        icon: controller.loginValue == true
                            ? Icon(
                                Icons.arrow_drop_down,
                                color: Constants.darkBlue,
                              )
                            : null,
                        iconSize: 30,
                        items: controller.citiesList.map((item) {
                          return DropdownMenuItem(
                            value: item['id'].toString(),
                            child: Text(
                              item['city'],
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        value: controller.cityDropDownValue,
                        onChanged: controller.loginValue == true
                            ? (value) {
                                log('Selected city is $value');
                                controller.cityDropDownValue = value.toString();
                                for (int i = 0;
                                    i < controller.citiesList.length;
                                    i++) {
                                  if (controller.citiesList[i]['id']
                                          .toString() ==
                                      value.toString()) {
                                    controller.cityName = controller
                                        .citiesList[i]['city']
                                        .toString();
                                  }
                                }
                                log(controller.cityName.toString());
                                controller.updateData(value);
                              }
                            : null,
                      ),
                    ),
                    controller.mostExcitingOffers.isNotEmpty
                        ? Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Most Exciting Offers',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color(0xFF6C747B)),
                                ),
                              ),
                              Center(
                                child: FlutterCarousel(
                                  options: CarouselOptions(
                                      aspectRatio: 2,
                                      autoPlay: true,
                                      autoPlayInterval:
                                          const Duration(seconds: 3),
                                      viewportFraction: 0.8,
                                      enlargeCenterPage: true,
                                      showIndicator: false),
                                  items: controller.mostExcitingOffers
                                      .map((item) => Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color:
                                                        const Color(0xFF0384FF),
                                                    width: 3),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    item['imagePath']
                                                        .toString(),
                                                  ),
                                                  fit: BoxFit.fill,
                                                )),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Categories',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GridView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        mainAxisExtent: 100,
                                        maxCrossAxisExtent: 80,
                                        childAspectRatio: 5 / 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                itemCount: controller.categoryTitleList.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() => const SubCategories(),
                                          arguments: [
                                            controller.categoryTitleList[index]
                                                ['name'],
                                            controller.categoryTitleList[index]
                                                ['id']
                                          ]);
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                            height: 70,
                                            width: 70,
                                            padding: const EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                                left: 10,
                                                right: 10),
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/catbg.png')),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                            child: Image.network(controller
                                                .categoryTitleList[index]
                                                    ['imagePath']
                                                .toString())),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          controller.categoryTitleList[index]
                                                  ['name']
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Constants.darkBlue,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: const Text(
                            'Top Picks',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        controller.categoryTitleList[0]['top_picks'].length > 0
                            ? SafeArea(
                                bottom: true,
                                child: ListView.builder(
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.categoryTitleList
                                          .toString()
                                          .isNotEmpty
                                      ? controller.categoryTitleList.length
                                      : 0,
                                  itemBuilder:
                                      (BuildContext context, int topIndex) {
                                    var catId = controller
                                        .categoryTitleList[topIndex]['id']
                                        .toString();
                                    return controller
                                                .categoryTitleList[topIndex]
                                                    ['top_picks']
                                                .length >
                                            0
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 0,
                                                        horizontal: 20),
                                                child: Text(
                                                  controller.categoryTitleList[
                                                          topIndex]['name']
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                              SizedBox(
                                                height:MediaQuery.of(context).size.height/4.76,
                                                // height: 160,
                                                child: ListView.builder(
                                                  physics:
                                                      const ScrollPhysics(),
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: controller
                                                      .categoryTitleList[
                                                          topIndex]['top_picks']
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int subIndex) {
                                                    var catTopPicks = controller
                                                            .categoryTitleList[
                                                        topIndex]['top_picks'];
                                                    return catId ==
                                                            catTopPicks[subIndex]
                                                                    [
                                                                    'category_id']
                                                                .toString()
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              log(catTopPicks
                                                                  .toString());
                                                              log(catTopPicks[
                                                                          subIndex]
                                                                      [
                                                                      'sub_category_id']
                                                                  .toString());
                                                              log(catTopPicks[
                                                                          subIndex]
                                                                      [
                                                                      'sub_category_name']
                                                                  .toString());
                                                              controller.navigateTo(
                                                                  catTopPicks[subIndex]
                                                                          [
                                                                          'sub_category_id']
                                                                      .toString(),
                                                                  catTopPicks[subIndex]
                                                                          [
                                                                          'sub_category_name']
                                                                      .toString(),);
                                                            },
                                                            child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 10,
                                                                      right: 8,
                                                                      left: 8),
                                                              width: 300,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      borderRadius: const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              20)),
                                                                      image: DecorationImage(
                                                                          image: NetworkImage(
                                                                            catTopPicks[subIndex]['imagePath'].toString(),
                                                                          ),
                                                                          fit: BoxFit.cover)),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            15,
                                                                        vertical:
                                                                            8),
                                                                    decoration: const BoxDecoration(
                                                                        color: Colors
                                                                            .black,
                                                                        borderRadius: BorderRadius.only(
                                                                            bottomLeft:
                                                                                Radius.circular(20),
                                                                            bottomRight: Radius.circular(20))),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            SizedBox(
                                                                              width: 150,
                                                                              child: Text(catTopPicks[subIndex]['sub_category_name'].toString(),
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  maxLines: 1,
                                                                                  style: const TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  )),
                                                                            ),
                                                                            /*const SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            Image.asset(
                                                                              'assets/icons/tickicon.png',
                                                                              height: 15,
                                                                              width: 15,
                                                                            ),*/
                                                                          ],
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              50,
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(30)),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(catTopPicks[subIndex]['rating'].toString(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
                                                                              const SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              const Icon(
                                                                                Icons.star,
                                                                                color: Colors.amber,
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
                                                          )
                                                        : Container();
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container();
                                  },
                                ),
                              )
                            : Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'No Top Picks Found',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Constants.darkBlue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
