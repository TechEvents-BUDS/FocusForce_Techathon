import 'package:cmslms/pages/loginpage/loginController.dart';
import 'package:cmslms/services/apiServices.dart';
import 'package:cmslms/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<ApiServices>(() => ApiServices());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      getPages: MyAppRoutes.routes,
    );
  }
}
