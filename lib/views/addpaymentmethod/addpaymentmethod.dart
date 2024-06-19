import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../controllers/addpaymentmethod/addpaymentmethodcontroller.dart';
import '../../widgets/constants.dart';

class AddPaymentMethod extends StatelessWidget {
  const AddPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPaymentMethodController>(
      init: AddPaymentMethodController(),
      builder: (e) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.lightShadeColor,
            title: Text(e.argData[0][0]['sub_category_name'].toString()),
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
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                            height: 400,
                            width: 300,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(
                                    0,
                                    0,
                                  ),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0,
                                ), //BoxShadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ), //BoxShadow
                              ],
                            ),
                            child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      e.paymentData['offer_title'].toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Color(0xFF7D7878),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${e.paymentData['discount'].toString()} OFF',
                                    style: const TextStyle(
                                        color: Color(0xFF7144BB),
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 280,
                                    child: Text(
                                      'Congratulation’s You are saving ${e.paymentData['savingPrice'].toString()}/- on the entire bill',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Total Amount Payable',
                                    style: TextStyle(
                                        color: Color(0xFF979797),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 120,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFF1F1F1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(
                                            0,
                                            0,
                                          ),
                                          blurRadius: 3.0,
                                          spreadRadius: 2.0,
                                        ), //BoxShadow
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          spreadRadius: 0.0,
                                        ), //BoxShadow
                                      ],
                                    ),
                                    child: Text(
                                      'Rs ${e.paymentData['finalPrice'].toString()}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          // color: Color(0xFF7144BB),
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Lottie.asset(
                                    'assets/Animation.json',
                                  ),
                                ],
                              ),
                            )),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/recieptbg.png'))),
                          height: 500,
                          width: 500,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 70,
                              ),
                              const Text(
                                'Bill amount to be paid',
                                style: TextStyle(
                                    color: Color(0xFF9FA2AB),
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                e.paymentData['finalPrice'].toString(),
                                style: const TextStyle(
                                    color: Color(0xFF625D70),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                              Text(
                                e.paymentData['originalPrice'].toString(),
                                style: const TextStyle(
                                    color: Color(0xFF828282),
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Billing By',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF9FA2AB))),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        e.paymentData['billingBy'].toString(),
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Billing To',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF9FA2AB))),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        e.paymentData['billingTo'].toString(),
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Date',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF9FA2AB))),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        e.paymentData['date'].toString(),
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Time',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF9FA2AB))),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        e.paymentData['time'].toString(),
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Billed Amount',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF9FA2AB))),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        'Rs ${e.paymentData['originalPrice'].toString()}/-',
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        'Savings(${e.paymentData['discount'].toString()}off)',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF9FA2AB))),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        '-Rs ${e.paymentData['savingPrice'].toString()}/-',
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Color(0xFF79BF2E),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Amount to be Paid',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF1D1B23))),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        'Rs ${e.paymentData['finalPrice'].toString()}/-',
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Color(0xFF1251D4),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              e.openCheckout(e.paymentData['finalPrice'].toString(),
                  e.paymentData['billingTo'].toString());
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                  color: Constants.lightBlue,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              height: 50,
              child: const Text(
                "Add Payment Method",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
        );
      },
    );
  }
}
