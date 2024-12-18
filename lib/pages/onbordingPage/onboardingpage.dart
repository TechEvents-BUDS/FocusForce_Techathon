import 'dart:async';

import 'package:cmslms/customWidgets/buttons.dart';
import 'package:cmslms/customWidgets/forText.dart';
import 'package:cmslms/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({super.key});
  final Rx<double> _height = 0.0.obs;

  @override
  Widget build(BuildContext context) {
    Timer(Duration(microseconds: 500), () {
      _height.value = 550;
    });
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Positioned(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: (MediaQuery.of(context).size.height - 550) / 2 - 30,
                  ),
                  myText("CMSLMS", 30, true, AppColors.textWhiteColor),
                  myText("Chce your Role", 20, true, AppColors.textWhiteColor),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Obx(
              () => AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.easeInOut, // Smooth animation
                width: double.infinity,
                height: _height.value,
                decoration: BoxDecoration(
                  color: AppColors.WhiteColor,

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    SquareButton(text: "Management", onTap: () {}),
                    SquareButton(text: "Teacher", onTap: () {}),
                    SquareButton(text: "Student", onTap: () {}),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
