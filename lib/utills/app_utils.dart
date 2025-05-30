import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:simap/utills/shared_preferences.dart';
import 'package:simap/view/app_screens/auth/sign_page.dart';
import 'package:simap/view/app_screens/landing_page/landing_page.dart';
import 'package:simap/view/app_screens/onbaording_screens/on_boarding_screen.dart';
import 'package:simap/view/app_screens/onbaording_screens/setup.dart';

import '../res/app_router.dart';
import '../res/shared_preferenceKey.dart';
import 'app_navigator.dart';

class AppUtils {
  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  void debuglog(object) {
    if (kDebugMode) {
      print(object.toString());
      // debugPrint(object.toString());
    }
  }

  openApp(context) async {
    bool isFirstOpen = (await SharedPref.getBool('isFirstOpen')) ?? true;
    // String schoolLogo = await SharedPref.getString(SharedPreferenceKey().appSchoolLogoKey);
    // String schoolName = await SharedPref.getString(SharedPreferenceKey().appSchoolNameKey);
    // String baseUrl = await SharedPref.getString(SharedPreferenceKey().baseUrlKey);
    // String firstame = await SharedPref.getString('firstName');
    // print(userData);
    // print(password);
    // print(8);

    if (!isFirstOpen) {
      //if(schoolLogo.isNotEmpty&&baseUrl.isNotEmpty){
      Future.delayed(const Duration(seconds: 3), () {
        AppNavigator.pushAndRemovePreviousPages(context,
            page: const SignPage());
      });
      // }else{
      //   Future.delayed(const Duration(seconds: 3), () {
      //     AppNavigator.pushAndRemovePreviousPages(context,
      //         page: const AppSetUp());
      //   });
      // }
      //   print(1);
      //   if (userData.isNotEmpty && password.isNotEmpty) {
      //     print(3);
      //
      //     Future.delayed(const Duration(seconds: 3), () {
      //       AppNavigator.pushAndRemovePreviousPages(context,
      //           page: SignInWIthAccessPinBiometrics(userName: firstame));
      //     });
      //   } else {
      //     print(4);
      //
      //     Future.delayed(const Duration(seconds: 3), () {
      //       AppNavigator.pushAndRemovePreviousPages(context,
      //           page: const SignInScreen());
      //     });
      //   }
      // } else {
      //   print(15);
      //
      //   await SharedPref.putBool('isFirstOpen', false);
      //   if (Platform.isAndroid) {
      //     print(5);
      //
      //     Future.delayed(const Duration(seconds: 3), () {
      //       AppNavigator.pushAndReplaceName(context,
      //           name: AppRouter.onBoardingScreen);
      //     });
      //   } else {
      //     print(6);
      //
      //     Future.delayed(const Duration(seconds: 3), () {
      //       AppNavigator.pushAndReplaceName(context,
      //           name: AppRouter.onBoardingScreen);
      //     });
      //   }
      // }
    } else {
      await SharedPref.putBool('isFirstOpen', false);

      Future.delayed(const Duration(seconds: 3), () {
        AppNavigator.pushAndRemovePreviousPages(context,
            page: const OnBoardingScreen());
      });
    }
  }

  static Future<bool> biometrics(String localizedReason) async {
    final LocalAuthentication auth = LocalAuthentication();
    final bool didAuthenticate = await auth.authenticate(
        localizedReason: localizedReason,
        options: const AuthenticationOptions(biometricOnly: true));

    return didAuthenticate;
  }

  ///Future<String?>
  static getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }

  void copyToClipboard(textToCopy, context) {
    Clipboard.setData(ClipboardData(text: textToCopy));
    //MSG.snackBar(context, "$textToCopy copied");
    // You can also show a snackbar or any other feedback to the user.
    print('Text copied to clipboard: $textToCopy');
  }

  static Size deviceScreenSize(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return queryData.size;
  }

  static String convertPrice(dynamic price, {bool showCurrency = false}) {
    double amount = price is String ? double.parse(price.toString()) : price;
    final formatCurrency = NumberFormat("#,##0.00", "en_US");
    return '${showCurrency ? 'NGN' : ''} ${formatCurrency.format(amount)}';
  }

  static DateTime timeToDateTime(TimeOfDay time, [DateTime? date]) {
    final newDate = date ?? DateTime.now();
    return DateTime(
        newDate.year, newDate.month, newDate.day, time.hour, time.minute);
  }

  static String formatString({required String data}) {
    if (data.isEmpty) return data;

    String firstLetter = data[0].toUpperCase();
    String remainingString = data.substring(1);

    return firstLetter + remainingString;
  }

  static String formatComplexDate({required String dateTime}) {
    DateTime parseDate = DateFormat("dd-MM-yyyy").parse(dateTime);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('d MMMM, yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  static String convertString(dynamic data) {
    if (data is String) {
      return data;
    } else if (data is List && data.isNotEmpty) {
      return data[0];
    } else {
      return data[0];
    }
  }

  static String formateSimpleDate({String? dateTime}) {
    var inputDate = DateTime.parse(dateTime!);

    var outputFormat = DateFormat('yyyy MMM d, hh:mm a');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  // static bool isPhoneNumber(String s) {
  //   if (s.length > 16 || s.length < 11) return false;
  //   return hasMatch(s, r'^(?:[+0][1-9])?[0-9]{10,12}$');
  // }

  static final dateTimeFormat = DateFormat('dd MMM yyyy, hh:mm a');
  static final dateFormat = DateFormat('dd MMM, yyyy');
  static final timeFormat = DateFormat('hh:mm a');
  static final apiDateFormat = DateFormat('yyyy-MM-dd');
  static final utcTimeFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
  static final dayOfWeekFormat = DateFormat('EEEEE', 'en_US');
}
