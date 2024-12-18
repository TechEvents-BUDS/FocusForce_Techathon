import 'dart:async';

import 'package:cmslms/customWidgets/forText.dart';
import 'package:cmslms/services/apiServices.dart';
import 'package:cmslms/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splashpage extends StatelessWidget {
  const Splashpage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () async{
      Get.toNamed('/login');
    });
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: myText("C M S\nL M S", 30, true, AppColors.textWhiteColor),
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          Get.toNamed('/login');
        },
        child: Text("Next"),
      ),
    );
  }
}
