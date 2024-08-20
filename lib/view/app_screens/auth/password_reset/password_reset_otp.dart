import 'package:flutter/material.dart';
import 'package:simap/view/app_screens/auth/password_reset/reset_password.dart';
import 'package:simap/view/app_screens/landing_page/landing_page.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_images.dart';
import '../../../../utills/app_navigator.dart';
import '../../../../utills/app_utils.dart';
import '../../../../utills/app_validator.dart';
import '../../../widgets/app_custom_text.dart';
import '../../../widgets/form_button.dart';
import '../../../widgets/form_input.dart';
import '../../onbaording_screens/onbaord_auth_background.dart';

class PasswordResetOTP extends StatefulWidget {
  const PasswordResetOTP({super.key});

  @override
  State<PasswordResetOTP> createState() => _PasswordResetOTPState();
}

class _PasswordResetOTPState extends State<PasswordResetOTP> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

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
            child: SingleChildScrollView(
              child: Container(
                height: AppUtils.deviceScreenSize(context).height-100,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              AppImages.simapLogo,
                              height: 70,
                              width: 70,
                            ),
                            Image.asset(
                              AppImages.logo,
                              height: 70,
                              width: 70,
                            ),
                          ],
                        ),

                      ],
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const CustomText(
                              text: "Input Code",
                              color: AppColors.mainAppColor,
                              size: 20,
                              weight: FontWeight.w600,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            const CustomText(
                              text:
                                  "A 5 digit code was sent to your email, please enter the code to reset your password.",
                              color: AppColors.black,
                              size: 16,
                              weight: FontWeight.w500,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              hint: 'Enter the code',
                              label: 'Code',
                              borderColor: AppColors.mainAppColor,
                              controller: _emailController,
                              backgroundColor: AppColors.white,
                              validator: AppValidator.validateTextfield,
                              maxLength: 5,
                            ),

                          ],
                        )),

                    Column(
                      children: [
                        FormButton(
                          onPressed: () {
                            AppNavigator.pushAndStackPage(context,
                                page:  const ResetPassword());
                          },
                          text: 'Continue',
                          height: 60,
                          textSize: 14,
                          borderRadius: 10,
                          bgColor: AppColors.mainAppColor,
                          borderColor: AppColors.mainAppColor,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
              ),
            ),
          ))
        ],
      ),
    );
  }
}
