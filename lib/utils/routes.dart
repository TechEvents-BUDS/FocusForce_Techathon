import 'package:cmslms/pages/loginpage/login.dart';
import 'package:cmslms/pages/mainpage.dart/view.dart';
import 'package:cmslms/pages/onbordingPage/onboardingpage.dart';
import 'package:cmslms/pages/splashPage/splashpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyAppRoutes {
  static String initPage = '/splash';

  static List<GetPage<dynamic>>? routes = [
   GetPage(name: '/splash', page:()=> Splashpage()),
   GetPage(name: '/onboarding', page:()=> OnBoardingPage()),
   GetPage(name: '/login', page:()=> LoginPage()),
   GetPage(name: '/view', page: ()=> MainView())
 ];
}