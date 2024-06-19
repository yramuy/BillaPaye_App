import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../controllers/seeallreviews/seeallreviewscontroller.dart';
import '../../widgets/constants.dart';

class SeeAllReviews extends StatelessWidget {
  const SeeAllReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeeAllReviewsController>(
      init: SeeAllReviewsController(),
      builder: (e) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.lightShadeColor,
            title: Text(e.argData[1].toString()),
            titleTextStyle: TextStyle(
                fontSize: 14,
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
          body: ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: e.argData[0].length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                width: 320,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD2DE).withOpacity(0.35),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: const Color(0xFFACACAC)),
                ),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Icon(
                                Icons.person,
                                color: Constants.darkBlue,
                                size: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text(
                                  e.argData[0][index]['user_name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                // const Row(
                                //   children: [
                                //     Icon(
                                //       Icons.edit,
                                //       color: Color(0xFF73738F),
                                //       size: 14,
                                //     ),
                                //     SizedBox(
                                //       width: 5,
                                //     ),
                                //     Text(
                                //       '3 reviews',
                                //       style: TextStyle(
                                //         color: Color(0xFF73738F),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(color: Colors.black12),
                              ),
                              child: RatingBarIndicator(
                                unratedColor: Colors.grey,
                                rating: double.parse(
                                    e.argData[0][index]['rating'].toString()),
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 20.0,
                              ),
                            ),
                            Text(
                              e.argData[0][index]['date'].toString(),
                              style: const TextStyle(
                                  color: Color(0xFF73738F),
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          e.argData[0][index]['short_text'].toString(),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SingleChildScrollView(
                          child: Text(
                            e.argData[0][index]['long_text'].toString(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w400),
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
        );
      },
    );
  }
}
