import 'package:flutter/material.dart';
import 'package:simap/view/app_screens/landing_page/landing_page.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../../../utills/app_navigator.dart';
import '../../../utills/app_validator.dart';
import '../../widgets/app_custom_text.dart';
import '../../widgets/form_button.dart';
import '../../widgets/form_input.dart';
import '../onbaording_screens/onbaord_auth_background.dart';

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();
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
                    Row(
                      children: [
                        Image.asset(
                          AppImages.simapLogo,
                          height: 70,
                          width: 70,
                        ),
                        const Icon(Icons.badge)
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios),
                    )
                  ],
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const CustomText(
                          text:
                          "Please login to continue",
                          color: AppColors
                              .mainAppColor
                          ,
                          size: 20,
                          weight:
                          FontWeight.w600,
                        ),
                        SizedBox(height: 20,),
                        CustomTextFormField(
                          hint:
                          'Enter your username',
                          label:
                          'Username',
                          borderColor:
                          AppColors.mainAppColor,
                          controller: _emailController,
                          backgroundColor:  AppColors.white,
                          validator: AppValidator
                              .validateTextfield,

                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          label: 'Password',
                          isPasswordField: true,
                          borderColor:
                          AppColors.mainAppColor,
                          backgroundColor: AppColors.white,
                          validator: AppValidator
                              .validateTextfield,
                          controller:
                          _passwordController,
                          hint: 'Enter your password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                               Navigator.pop(context);

                              },
                              child: const Align(
                                alignment:
                                Alignment.topRight,
                                child: CustomText(
                                  text: "Reset setup",
                                  color: AppColors.mainAppColor,
                                  size: 16,
                                  weight:
                                  FontWeight.w400,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {

                                // AppNavigator
                                //     .pushAndStackPage(
                                //     context,
                                //     page:
                                //     const PasswordResetRequest());
                              },
                              child: Align(
                                alignment:
                                Alignment.topRight,
                                child: CustomText(
                                  text:
                                  "Forgot password ?",
                                  color: AppColors
                                      .mainAppColor
                                      ,
                                  size: 16,
                                  weight:
                                  FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    )),

                Column(
                  children: [
                    FormButton(
                      onPressed: () {
                        AppNavigator.pushAndStackPage(context,
                            page:  LandingPage(selectedIndex: 0));
                      },
                      text: 'Login',
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
          ))
        ],
      ),
    );
  }
}
