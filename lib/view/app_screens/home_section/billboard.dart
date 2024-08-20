import 'package:flutter/material.dart';

import '../../../res/app_colors.dart';
import '../../../utills/app_utils.dart';

class Billboard extends StatelessWidget {
  const Billboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
          height: 150,
          width: AppUtils.deviceScreenSize(context).width,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.mainAppColor,width: 5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          )),
    );
  }
}
