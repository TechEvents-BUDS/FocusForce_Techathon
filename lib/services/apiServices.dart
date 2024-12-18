import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:get/get.dart';
import 'dart:io'; // For Cookie class

class ApiServices extends GetxController {
  // Function to extract hidden field values from HTML
  String extractValue(String html, String fieldName) {
    final regex = RegExp('id="$fieldName" value="(.*?)"');
    final match = regex.firstMatch(html);
    return match?.group(1) ?? '';
  }

  // Function to handle login
  Future<void> getLoggedIn() async {
    final dioClient = dio.Dio();
    final cookieJar = CookieJar();
    dioClient.interceptors.add(CookieManager(cookieJar));

    // URL for the login page
    final loginPageUrl = 'https://cms.bahria.edu.pk/Logins/Student/Login.aspx';

    try {
      print('Fetching login page...');
      final loginPageResponse = await dioClient.get(loginPageUrl);
      final loginPageHtml = loginPageResponse.data;

      // Extract cookies after initial GET request
      final initialCookies = await cookieJar.loadForRequest(
        Uri.parse(loginPageUrl),
      );
      print('Cookies after fetching login page: $initialCookies');

      // Extract hidden field values from the login page
      final viewState = extractValue(loginPageHtml, '__VIEWSTATE');
      final viewStateGenerator = extractValue(
        loginPageHtml,
        '__VIEWSTATEGENERATOR',
      );
      final eventValidation = extractValue(loginPageHtml, '__EVENTVALIDATION');

      if (viewState.isEmpty ||
          viewStateGenerator.isEmpty ||
          eventValidation.isEmpty) {
        throw Exception(
          'Failed to extract required hidden values from the login page.',
        );
      }

      print('Extracted Values:');
      print('VIEWSTATE: $viewState');
      print('VIEWSTATEGENERATOR: $viewStateGenerator');
      print('EVENTVALIDATION: $eventValidation');

      // Login data payload
      final loginData = {
        '__LASTFOCUS': '',
        '__EVENTTARGET': 'ctl00\$BodyPH\$btnLogin',
        '__EVENTARGUMENT': '',
        '__VIEWSTATE': viewState,
        '__VIEWSTATEGENERATOR': viewStateGenerator,
        '__EVENTVALIDATION': eventValidation,
        'ctl00\$BodyPH\$tbEnrollment':
            '02-134242-041', // Replace with valid enrollment
        'ctl00\$BodyPH\$tbPassword':
            'Gull@90034', // Replace with valid password
        'ctl00\$BodyPH\$ddlInstituteID': '2',
        'ctl00\$BodyPH\$ddlSubUserType': 'None',
        'ctl00\$hfJsEnabled': '0',
      };

      final header_ = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Referer': 'https://cms.bahria.edu.pk/Logins/Student/Login.aspx',
        'User-Agent': 'Your-App-User-Agent',
        // "Content-Type": "application/x-www-form-urlencoded",
        // "Accept":
        //     "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        // "Accept-Encoding": "gzip, deflate, br",
        // "Accept-Language": "en-US,en;q=0.9,ur-PK;q=0.8,ur;q=0.7",
        // "Cache-Control": "max-age=0",
        // "Referer": "https://cms.bahria.edu.pk/Logins/Student/Login.aspx",
        // "User-Agent":
        //     "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Mobile Safari/537.36",
        // 'Cookie': _buildCookieHeader(initialCookies),
        // "Origin": "https://cms.bahria.edu.pk",
        // "Upgrade-Insecure-Requests": "1",
        // "DNT": "1", // Add cookies from the initial response
      };

      {}

      final encodedData = loginData.entries
          .map(
            (entry) =>
                '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}',
          )
          .join('&');
      final contentLength = utf8.encode(encodedData).length;

      log(jsonEncode(contentLength));

      log(jsonEncode(_buildCookieHeader(initialCookies)));
      log(jsonEncode(loginData));
      log(jsonEncode(header_));

      print('Sending login request...');
      final loginResponse = await dioClient.post(
        loginPageUrl,
        data: dio.FormData.fromMap(loginData), // Use prefixed FormData
        options: dio.Options(
          followRedirects: false,
          validateStatus: (status) => status != null && status < 400,
          headers: header_,
        ),
      );

      // Handle redirects
      if (loginResponse.statusCode == 302) {
        final prepareSessionUrl = loginResponse.headers['location']?.first;
        if (prepareSessionUrl == null) {
          throw Exception('PrepareSession redirect URL not found.');
        }
        print('Redirecting to PrepareSession: $prepareSessionUrl');

        final prepareSessionResponse = await dioClient.get(
          'https://cms.bahria.edu.pk$prepareSessionUrl',
          options: dio.Options(
            followRedirects: false,
            validateStatus: (status) => status != null && status < 400,
          ),
        );

        if (prepareSessionResponse.statusCode == 302) {
          final dashboardUrl =
              prepareSessionResponse.headers['location']?.first;
          if (dashboardUrl == null) {
            throw Exception('Dashboard redirect URL not found.');
          }
          print('Redirecting to Dashboard: $dashboardUrl');

          final dashboardResponse = await dioClient.get(
            'https://cms.bahria.edu.pk$dashboardUrl',
            options: dio.Options(
              headers: {
                'Referer': prepareSessionUrl,
                'User-Agent':
                    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Mobile Safari/537.36',
              },
            ),
          );

          print('Dashboard Response:');
          print(dashboardResponse.data); // Print the dashboard page HTML
        } else {
          print(
            'Failed to redirect to Dashboard. Status: ${prepareSessionResponse.statusCode}',
          );
        }
      } else {
        print('Login failed. Status Code: ${loginResponse.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Helper function to build the Cookie header from initial cookies
  String _buildCookieHeader(List<Cookie> cookies) {
    return cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
  }
}
