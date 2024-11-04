import 'package:flutter/material.dart';
import 'package:simap/view/widgets/not_found_page.dart';

import '../view/app_screens/landing_page/landing_page.dart';
import '../view/app_screens/splash_screen/splash_screen.dart';



class AppRouter {
  ///All route name

  /// ONBOARDING SCREEEN
  static const String splashScreen = '/';
  //static const String onBoardingScreen = "/on-boarding-screen";

  /// AUTH SCREENS
  static const String signInPage = "/sign-in-page";
  static const String exixtingSignInPage = "/existing-sign-in-page";

  //static const String otpPage = "/otp-page";
  static const String signUpPageGetStarted = "/sign-up-page-get-started";

  ///IMPORTANT SCREENS
  static const String noInternetScreen = "/no-internet";

  ///LANDING PAGE LandingPage
  //static const String landingPage = "/landing-page";
  static const String notificationPage = "/notification-page";

  static const String chooseLocation = "/choose-location-page";

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      // case onBoardingScreen:
      //   return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      // case landingPage:
      //
      //
      //   return MaterialPageRoute(
      //       builder: (_) => LandingPage(selectedIndex: 0,
      //           ));



      default:
        return MaterialPageRoute(builder: (_) =>  NotFoundPage());
    }
  }
}
