import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/paybill/paybillcontroller.dart';
import '../../widgets/constants.dart';
import '../addpaymentmethod/addpaymentmethod.dart';

class PayBill extends StatelessWidget {
  const PayBill({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayBillController>(
      init: PayBillController(),
      builder: (e) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.lightShadeColor,
            title: Text(e.argData[0]['sub_category_name'].toString()),
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
          body: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              const Center(
                  child: Text(
                'Please enter the bill amount.',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Color(0xFF979797)),
              )),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 120,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: e.amountController,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Constants.lightBlue,
                      fontSize: 24),
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              if (e.amountController.text.toString().isNotEmpty) {
                Get.to(() => const AddPaymentMethod(),
                    arguments: [e.argData, e.amountController.text.toString()]);
              } else {
                Get.snackbar('Alert', 'Please enter the amount to be paid',
                    backgroundColor: Constants.darkBlue,
                    barBlur: 20,
                    overlayBlur: 5,
                    colorText: Colors.white,
                    animationDuration: const Duration(seconds: 3));
              }
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                  color: Constants.lightBlue,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              height: 50,
              child: const Text(
                "Proceed to pay",
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
