import 'package:flutter/material.dart';
import 'package:simap/utills/app_utils.dart';

import '../../../res/app_images.dart';

class OnbaordAuthBackground extends StatelessWidget {
  const OnbaordAuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 50,
        left: 0,
        right: 0,
        bottom: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Opacity(
                opacity: 0.3, // Adjust the opacity value as needed

                child: Image.asset(
                  AppImages.backPack,
                  height: AppUtils.deviceScreenSize(context).height / 4,
                  width: 200,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Opacity(
                opacity: 0.3, // Adjust the opacity value as needed

                child: Image.asset(
                  AppImages.girlBoy,
                  height: (AppUtils.deviceScreenSize(context).height / 4) + 50,
                  width: 200,
                ),
              ),
            )
          ],
        ));
  }
}
