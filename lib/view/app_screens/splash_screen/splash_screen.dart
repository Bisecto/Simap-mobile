import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simap/res/app_icons.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../../../utills/app_utils.dart';
import '../../widgets/app_custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppUtils appUtils = AppUtils();

  @override
  void initState() {
    appUtils.openApp(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: AppUtils.deviceScreenSize(context).height,
      width: AppUtils.deviceScreenSize(context).width,
      decoration: const BoxDecoration(color: AppColors.white
          // image: DecorationImage(
          //   image: AssetImage(AppImages.splashFrame,),fit: BoxFit.fill
          // ),

          ),
      child: Stack(
        children: [
          Positioned(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Opacity(
                  opacity: 0.3, // Adjust the opacity value as needed

                  child: Image.asset(
                    AppImages.back2School,
                    height: 300,
                    width: 200,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Opacity(
                  opacity: 0.3, // Adjust the opacity value as needed

                  child: Image.asset(
                    AppImages.itemPack,
                    height: 300,
                    width: 200,
                  ),
                ),
              )
            ],
          )),
          Positioned(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(text: ''),
              Center(
                  child: Image.asset(
                AppImages.simapLogo,
                height: 150,
                width: 150,
              )),
              Align(
                alignment: Alignment.center,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: 'Powered by',
                      color: AppColors.textColor,
                      size: 10,
                    ),
                    Image.asset(
                      AppImages.appleadLogo,
                      height: 30,
                      width: 85,
                      //color: AppColors.darkModeBlack,
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    ));
  }
}
