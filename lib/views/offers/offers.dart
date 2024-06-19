import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/offers/offerscontroller.dart';
import '../../widgets/constants.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GetBuilder<OffersController>(
      init: OffersController(),
      builder: (e) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Container(
                //       height: 60,
                //       width: 200,
                //       alignment: Alignment.topRight,
                //       margin: const EdgeInsets.all(10),
                //       padding: const EdgeInsets.all(10),
                //       child: DropdownButtonFormField(
                //         iconSize: 0.0,
                //         hint: const Text(
                //           'Filter',
                //           style: TextStyle(
                //               color: Color(0xFF46535F),
                //               fontWeight: FontWeight.bold),
                //         ),
                //         decoration: InputDecoration(
                //             border: const OutlineInputBorder(
                //                 borderSide:
                //                     BorderSide(color: Colors.transparent),
                //                 borderRadius:
                //                     BorderRadius.all(Radius.circular(10))),
                //             focusedBorder: const OutlineInputBorder(
                //                 borderSide:
                //                     BorderSide(color: Colors.transparent),
                //                 borderRadius:
                //                     BorderRadius.all(Radius.circular(10))),
                //             enabledBorder: const OutlineInputBorder(
                //                 borderSide:
                //                     BorderSide(color: Colors.transparent),
                //                 borderRadius:
                //                     BorderRadius.all(Radius.circular(10))),
                //             prefixIcon:
                //                 Image.asset('assets/icons/filtericon.png'),
                //             fillColor: const Color(0xFFCED8E1),
                //             filled: true,
                //             contentPadding: const EdgeInsets.only(
                //               bottom: 10,
                //             )),
                //         icon: null,
                //         items: e.categoryTitleList.map((item) {
                //           return DropdownMenuItem(
                //             value: item['id'].toString(),
                //             child: Text(
                //               item['name'],
                //               style: const TextStyle(
                //                   color: Color(0xFF46535F),
                //                   fontWeight: FontWeight.bold),
                //             ),
                //           );
                //         }).toList(),
                //         value: e.filterDropDownValue,
                //         onChanged: (value) {
                //           log('Selected State is $value');
                //           e.filterDropDownValue = value.toString();
                //           e.categoryID = value.toString();
                //           e.isLoading = true;
                //           e.offersList = [];
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                e.isLoading == true
                    ? Container(
                        margin: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height / 4),
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Constants.darkBlue,
                        )),
                      )
                    : e.offersList.isNotEmpty
                        ? SafeArea(
                            child: SingleChildScrollView(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 1.28,
                              child: ListView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: e.offersList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      children: [
                                        Container(
                                          color: const Color(0xFFDADADA),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    // padding: const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  50)),
                                                      border: Border.all(
                                                          color: Colors.black),
                                                    ),
                                                    child: CircleAvatar(
                                                      radius: 15,
                                                      backgroundImage:
                                                          NetworkImage(e
                                                              .offersList[index]
                                                                  ['image']
                                                              .toString()),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    e.offersList[index][
                                                            'sub_category_name']
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF004B67),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              Image.asset(
                                                  'assets/icons/tickicon.png'),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            e.navigateTo(
                                                e.offersList[index]
                                                        ['sub_cat_id']
                                                    .toString(),
                                                e.offersList[index]
                                                        ['sub_category_name']
                                                    .toString());
                                          },
                                          child: SizedBox(
                                            height: 300,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1,
                                            child: Image.network(
                                              e.offersList[index]['image']
                                                  .toString(),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Row(
                                              //   children: [
                                              //     GestureDetector(
                                              //         child: Image.asset(
                                              //             'assets/icons/hearticon.png')),
                                              //     const SizedBox(
                                              //       width: 10,
                                              //     ),
                                              //     // GestureDetector(
                                              //     //     child: Image.asset(
                                              //     //         'assets/icons/shareicon.png'))
                                              //   ],
                                              // ),
                                              // Image.asset(
                                              //     'assets/icons/saveicon.png'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  e.offersList[index]
                                                          ['post_title']
                                                      .toString(),
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      color: Color(0xFF004B67),
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  e.offersList[index]
                                                          ['post_description']
                                                      .toString(),
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      color: Color(0xFF004B67),
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ))
                        : Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 3),
                            child: Text(
                              'No Posts Found',
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
    ));
  }
}
