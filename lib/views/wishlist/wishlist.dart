import 'dart:developer';

import 'package:billspaye/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/wishlist/wishlistcontroller.dart';
import '../../widgets/constants.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: const WishListPage(),
      desktop: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: const WishListPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<WishlistController>(
        init: WishlistController(),
        builder: (e) {
          return Scaffold(
            // backgroundColor: Constants.lightShadeColor,
            body: e.isLoading == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: Constants.darkBlue,
                    ),
                  )
                : e.wishList.isNotEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 1,
                        width: MediaQuery.of(context).size.width * 1,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: e.wishList.isNotEmpty
                                    ? e.wishList.length
                                    : 0,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      e.navigateTo(
                                          e.wishList[index]['sub_cat_id']
                                              .toString(),
                                          e.wishList[index]['subCatName']
                                              .toString());
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 10,
                                          right: 30,
                                          left: 20,
                                          bottom: 10),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          border: Border.all(
                                              color: Constants.lightShadeColor),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                e.wishList[index]['image']
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
                                            const SizedBox(
                                              height: 120,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 8),
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20))),
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
                                                        width: 180,
                                                        child: Text(
                                                            e.wishList[index][
                                                                    'subCatName']
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          log('fav tapped');
                                                          e.isLoading = true;
                                                          e.wishlistUpdateApi(
                                                              e.wishList[index]
                                                                      ['cat_id']
                                                                  .toString(),
                                                              e.wishList[index][
                                                                      'sub_cat_id']
                                                                  .toString());
                                                        },
                                                        child: e.wishList[index]
                                                                        [
                                                                        'status']
                                                                    .toString() ==
                                                                '1'
                                                            ? const Icon(
                                                                Icons.favorite,
                                                                color:
                                                                    Colors.red,
                                                                size: 30,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .favorite_border_sharp,
                                                                color:
                                                                    Colors.red,
                                                                size: 30,
                                                              ),
                                                      ),
                                                    ],
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
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: Text(
                          'WishList is empty',
                          style: TextStyle(
                              fontSize: 16,
                              color: Constants.darkBlue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
          );
        },
      ),
    );
  }
}
