import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/mypayments/mypaymentscontroller.dart';
import '../../widgets/constants.dart';

class MyPayments extends StatelessWidget {
  const MyPayments({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyPaymentsController>(
      init: MyPaymentsController(),
      builder: (e) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.lightBlue.withOpacity(0.8),
            title: const Text('My Payments'),
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
              : e.paymentData.isNotEmpty
                  ? Container(
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
                        itemCount: e.paymentData.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(10),
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
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Table(
                              children: [
                                TableRow(children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'Paid To :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Constants.darkBlue),
                                    ),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(e.paymentData[index]
                                            ["transactionTo"]
                                        .toString()),
                                  )),
                                ]),
                                TableRow(children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'Transaction Id :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Constants.darkBlue),
                                    ),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(e.paymentData[index]
                                            ["transaction_id"]
                                        .toString()),
                                  )),
                                ]),
                                TableRow(children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'Amount Paid :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Constants.darkBlue),
                                    ),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                        "${e.paymentData[index]["transaction_amount"].toString()} /-Rs"),
                                  )),
                                ]),
                                TableRow(children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'Bill Date & Time :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Constants.darkBlue),
                                    ),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(e.paymentData[index]
                                            ["transaction_date"]
                                        .toString()),
                                  )),
                                ]),
                              ],
                            ),
                          );
                        },
                      )),
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: Text(
                        'No Records Found',
                        style: TextStyle(
                            fontSize: 16,
                            color: Constants.darkBlue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
        );
      },
    );
  }
}
