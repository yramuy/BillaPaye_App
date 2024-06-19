import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../controllers/faqs/faqscontroller.dart';
import '../../widgets/constants.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FAQController>(
      init: FAQController(),
      builder: (e) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.lightBlue.withOpacity(0.8),
            title: const Text('Contact Us'),
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
          body: e.isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: Constants.lightBlue.withOpacity(0.8),
                  ),
                )
              : Container(
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
                        Constants.lightBlue.withOpacity(0.8),
                      ])),
                  height: MediaQuery.of(context).size.height * 1,
                  width: MediaQuery.of(context).size.width * 1,
                  child: SingleChildScrollView(
                      child: ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: e.faqData.length,
                    itemBuilder: (context, index) {
                      return e.faqData[index]['policy_title'].toString() !=
                                  "Contact us" ||
                              e.faqData[index]['id'].toString() != "5"
                          ? Container()
                          : Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: HtmlWidget(e.faqData[index]
                                        ['policy_content']
                                    .toString()),
                              ),
                            );
                    },
                  )),
                ),
        );
      },
    );
  }
}
