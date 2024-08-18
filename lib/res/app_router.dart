// import 'package:flutter/material.dart';
//
//
//
// class AppRouter {
//   ///All route name
//
//   /// ONBOARDING SCREEEN
//   static const String splashScreen = '/';
//   //static const String onBoardingScreen = "/on-boarding-screen";
//
//   /// AUTH SCREENS
//   static const String signInPage = "/sign-in-page";
//   static const String exixtingSignInPage = "/existing-sign-in-page";
//
//   //static const String otpPage = "/otp-page";
//   static const String signUpPageGetStarted = "/sign-up-page-get-started";
//
//   ///IMPORTANT SCREENS
//   static const String noInternetScreen = "/no-internet";
//
//   ///LANDING PAGE LandingPage
//   static const String landingPage = "/landing-page";
//   static const String notificationPage = "/notification-page";
//
//   static const String chooseLocation = "/choose-location-page";
//
//   Route onGenerateRoute(RouteSettings routeSettings) {
//     switch (routeSettings.name) {
//       case splashScreen:
//         return MaterialPageRoute(builder: (_) => const SplashScreen());
//       // case onBoardingScreen:
//       //   return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
//       case signInPage:
//         return MaterialPageRoute(builder: (_) => const SignInPage()); case exixtingSignInPage:
//         return MaterialPageRoute(builder: (_) => const ExistingSignIn());
//       case landingPage:
//         final StudentProfile studentProfile =
//             routeSettings.arguments as StudentProfile;
//         final CurrentSession currentSession =
//             routeSettings.arguments as CurrentSession;
//         final FeesActivity feesActivity =
//             routeSettings.arguments as FeesActivity;
//
//         return MaterialPageRoute(
//             builder: (_) => LandingPage(
//                   studentProfile: studentProfile, selectedIndex: 0, currentSession: currentSession,
//                 ));
//
//       case notificationPage:
//         return MaterialPageRoute(builder: (_) => const NotificationPage());
//
//       default:
//         return MaterialPageRoute(builder: (_) =>  AppLoadingPage('Loading'));
//     }
//   }
// }
