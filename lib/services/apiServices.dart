import 'dart:convert';
import 'dart:developer';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Apiservices extends GetxController {

  String extractValue(String html, String fieldName) {
    final regex = RegExp('id="$fieldName" value="(.*?)"');
    final match = regex.firstMatch(html);
    return match?.group(1) ?? '';
  }

  getLogedIn() async {
   final dio = Dio();

  // Enable cookies to maintain session state
  dio.interceptors.add(CookieManager(CookieJar()));

  // Step 1: Fetch the login page to get dynamic hidden values
  final loginPageUrl = 'https://cms.bahria.edu.pk/Logins/Student/Login.aspx';
  try {
    print('Fetching login page...');
    final loginPageResponse = await dio.get(loginPageUrl);
    final loginPageHtml = loginPageResponse.data;
    //final cookies =  loginPageResponse.
    log(jsonEncode(loginPageHtml));

    // Step 2: Extract hidden values (__VIEWSTATE, __EVENTVALIDATION, etc.)
    final viewState = extractValue(loginPageHtml, '__VIEWSTATE');
    final viewStateGenerator = extractValue(loginPageHtml, '__VIEWSTATEGENERATOR');
    final eventValidation = extractValue(loginPageHtml, '__EVENTVALIDATION');

    print('Extracted Values:');
    print('VIEWSTATE: $viewState');
    print('VIEWSTATEGENERATOR: $viewStateGenerator');
    print('EVENTVALIDATION: $eventValidation');




    // Step 3: Send the login request
    final loginData = {
      '__LASTFOCUS': '',
      '__EVENTTARGET': 'ctl00\$BodyPH\$btnLogin',
      '__EVENTARGUMENT': '',
      '__VIEWSTATE': viewState,
      '__VIEWSTATEGENERATOR': viewStateGenerator,
      '__EVENTVALIDATION': eventValidation,
      'ctl00\$BodyPH\$tbEnrollment': '02-134242-041', // Replace with valid enrollment
      'ctl00\$BodyPH\$tbPassword': 'Gull@90034',      // Replace with valid password
      'ctl00\$BodyPH\$ddlInstituteID': '2',
      'ctl00\$BodyPH\$ddlSubUserType': 'None',
      'ctl00\$hfJsEnabled': '0',
    };

    print('Sending login request...');
    final loginResponse = await dio.post(
      loginPageUrl,
      data: FormData.fromMap(loginData),
      options: Options(
        followRedirects: false, // Don't auto-follow redirects
        validateStatus: (status){
            if(status != null){
            return (status == 302 || status < 400);
          }
          return false;
          },
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Referer': loginPageUrl,
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
        },
      ),
    );

    if (loginResponse.statusCode == 302) {
      // Step 4: Handle redirect to PrepareSession.aspx
      final prepareSessionUrl = loginResponse.headers['location']?.first;
      print('Redirecting to PrepareSession: $prepareSessionUrl');

      final prepareSessionResponse = await dio.get(
        'https://cms.bahria.edu.pk$prepareSessionUrl',
        options: Options(
          followRedirects: false,
          validateStatus:(status){
            if(status != null){
            return (status == 302 || status < 400);
          }
          return false;
          },
        ),
      );

      if (prepareSessionResponse.statusCode == 302) {
        // Step 5: Handle redirect to Dashboard.aspx
        final dashboardUrl = prepareSessionResponse.headers['location']?.first;
        print('Redirecting to Dashboard: $dashboardUrl');

        final dashboardResponse = await dio.get(
          'https://cms.bahria.edu.pk$dashboardUrl',
          options: Options(
            headers: {
              'Referer': loginPageUrl,
              'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
            },
          ),
        );

        print('Dashboard Response:');
        print(dashboardResponse.data); // Print the dashboard page HTML
      } else {
        print('Failed to redirect to Dashboard. Status: ${prepareSessionResponse.statusCode}');
      }
    } else {
      print('Login failed. Status Code: ${loginResponse.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
}
