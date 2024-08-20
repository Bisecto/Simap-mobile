import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simap/view/app_screens/onbaording_screens/setup.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../../../res/app_strings.dart';
import '../../../utills/app_navigator.dart';
import '../../../utills/app_utils.dart';
import '../../widgets/app_custom_text.dart';
import '../../widgets/form_button.dart';
import 'onbaord_auth_background.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<String> onBoardingText = [
    AppStrings.onBoardingScreen1MainText,
    AppStrings.onBoardingScreen2MainText,
    AppStrings.onBoardingScreen3MainText,
  ];
  final List<String> onBoardingSubText = [
    AppStrings.onBoardingScreen1SubText,
    AppStrings.onBoardingScreen2SubText,
    AppStrings.onBoardingScreen3SubText,
  ];
  CarouselSliderController carouselSliderController =
      CarouselSliderController();
  final GlobalKey _sliderKey = GlobalKey();
  bool skip = false;
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const OnbaordAuthBackground(),

          Positioned(
              child: Padding(
            padding: const EdgeInsets.only(
                top: 50.0, bottom: 20, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      AppImages.simapLogo,
                      height: 70,
                      width: 70,
                    ),
                    const CustomText(
                      text: 'Skip',
                      color: AppColors.black,
                      size: 18,
                      maxLines: 3,
                      weight: FontWeight.w400,
                    )
                  ],
                ),
                SizedBox(
                  height: 200,
                  child: CarouselSlider.builder(
                    key: _sliderKey,
                    unlimitedMode: true,
                    enableAutoSlider: true,
                    slideIndicator: CircularSlideIndicator(
                        indicatorBackgroundColor: AppColors.grey,
                        currentIndicatorColor: AppColors.mainAppColor,
                        padding: const EdgeInsets.only(bottom: 0),
                        alignment: Alignment.bottomCenter),
                    itemCount: onBoardingSubText.length,
                    slideBuilder: (index) {
                      return SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0.0, 5, 0, 0),
                              child: CustomText(
                                text: onBoardingText[index],
                                color: AppColors.black,
                                size: 25,
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                weight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CustomText(
                                text: onBoardingSubText[index],
                                color: AppColors.black,
                                size: 16,
                                maxLines: 6,
                                textAlign: TextAlign.center,
                                weight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    slideTransform: const DefaultTransform(),
                  ),
                ),
                Column(
                  children: [
                    FormButton(
                      onPressed: () {
                        AppNavigator.pushAndStackPage(context, page: const AppSetUp());
                      },
                      text: 'Get Started',
                      height: 60,
                      textSize: 14,
                      borderRadius: 10,
                      bgColor: AppColors.mainAppColor,
                      borderColor: AppColors.mainAppColor,
                    ),
                    const SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomText(
                            text: 'Powered by',
                            color: AppColors.black,
                            size: 10,
                          ),
                          Image.asset(
                            AppImages.appleadLogo,
                            height: 30,
                            width: 85,
                            //color: AppColors.darkModeBlack,
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    )

                  ],
                ),

              ],
            ),
          ))
        ],
      ),
    );
  }
}
