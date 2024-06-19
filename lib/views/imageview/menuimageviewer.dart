import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/constants.dart';

class MenuImageViewer extends StatefulWidget {
  const MenuImageViewer({super.key});

  @override
  State<MenuImageViewer> createState() => _MenuImageViewerState();
}

class _MenuImageViewerState extends State<MenuImageViewer> {
  dynamic argData = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.lightShadeColor,
          title: Text(argData[1].toString()),
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
        body: SizedBox(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.network(
              argData[0],
              fit: BoxFit.fill,
            ),
          ),
        ));
  }
}
