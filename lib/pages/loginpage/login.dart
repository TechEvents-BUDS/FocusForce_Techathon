import 'dart:async';

import 'package:cmslms/customWidgets/buttons.dart';
import 'package:cmslms/customWidgets/forText.dart';
import 'package:cmslms/customWidgets/textfilds.dart';
import 'package:cmslms/pages/loginpage/loginController.dart';
import 'package:cmslms/services/apiServices.dart';
import 'package:cmslms/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

final RxString selectedRoleValue = ''.obs; // Stores the selected value
final List<Map<String, String>> roles = [
  {'option': 'Admin', 'value': 'admin'},
  {'option': 'Teacher', 'value': 'teacher'},
  {'option': 'Student', 'value': 'student'},
]; //

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final Rx<double> _height = 0.0.obs;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    Timer(Duration(microseconds: 500), () {
      _height.value = 550;
    });
    Rx<bool> showPassword = false.obs;
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
                  myText("CMS\nLMS", 30, true, AppColors.textWhiteColor),
                  // myText("Chce your Role", 20, true, AppColors.textWhiteColor),
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
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      myText("Login", 30, true, AppColors.primaryColor),

                      SizedBox(height: 20),

                      LoginFields(
                        textControler: controller.usernameController,
                        labeltext: "User Name",
                        isPassword: false,
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        height: 55,
                        child: LoginFields(
                          textControler: controller.passwordController,
                          labeltext: "Password",
                          isPassword: true,
                        ),
                      ),

                      SizedBox(height: 20),

                      CustomDropdown(
                        labelText: "Select Institute",
                        options: roles,
                        selectedValue: selectedRoleValue,
                      ),
                      SizedBox(height: 20),

                      CustomDropdown(
                        labelText: "Select Role",
                        options: roles,
                        selectedValue: selectedRoleValue,
                      ),

                      SizedBox(height: 20),

                      SquareButton(
                        text: "Login",
                        onTap: () async {
                          // final apis = Get.find<Apiservices>();
                          // await apis.getLogedIn();

                          Get.toNamed('/view');
                        },
                      ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     TextButton(
                      //       onPressed: () {},
                      //       child: Text(
                      //         "Forget Password",
                      //         style: TextStyle(
                      //           fontSize: 18,
                      //           color: AppColors.primaryColor,
                      //           decorationColor: AppColors.primaryColor,
                      //           decoration: TextDecoration.underline,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
