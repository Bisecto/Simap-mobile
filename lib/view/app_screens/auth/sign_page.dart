import 'package:flutter/material.dart';
import 'package:simap/utills/app_utils.dart';
import 'package:simap/view/app_screens/auth/password_reset/password_reset_request.dart';
import 'package:simap/view/app_screens/landing_page/landing_page.dart';
import 'package:simap/view/app_screens/onbaording_screens/setup.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../../../res/shared_preferenceKey.dart';
import '../../../utills/app_navigator.dart';
import '../../../utills/app_validator.dart';
import '../../../utills/shared_preferences.dart';
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
  final _schoolIdController = TextEditingController();

  final _passwordController = TextEditingController();
  String appSchoolName = '';
  String appLogo = '';

  @override
  void initState() {
    // TODO: implement initState
    getSavedData();
    super.initState();
  }

  Future<void> getSavedData() async {
    String schoolLogo =
        await SharedPref.getString(SharedPreferenceKey().appSchoolLogoKey);
    String schoolName =
        await SharedPref.getString(SharedPreferenceKey().appSchoolNameKey);
    AppUtils().debuglog(schoolName);
    setState(() {
      appSchoolName = schoolName;
      appLogo = schoolLogo;
    });
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
            child: SingleChildScrollView(
              child: Container(
                height: AppUtils.deviceScreenSize(context).height - 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (Navigator.canPop(context))
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
                          ],
                        ),
                      ],
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            if (appLogo != '')
                              CircleAvatar(
                                radius: 50,
                                backgroundColor:
                                    AppColors.mainAppColor.withOpacity(0.1),
                                child: Image.network(
                                  appLogo,
                                  height: 70,
                                  width: 70,
                                ),
                              ),
                            // Image.network(
                            //   appLogo,
                            //   height: 70,
                            //   width: 70,
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            const CustomText(
                              text: "Please login to continue",
                              color: AppColors.mainAppColor,
                              size: 20,
                              weight: FontWeight.w600,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              hint: 'Enter your school ID',
                              label: 'School ID',
                              borderColor: AppColors.mainAppColor,
                              controller: _schoolIdController,
                              backgroundColor: AppColors.white,
                              validator: AppValidator.validateTextfield,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextFormField(
                              hint: 'Enter your username',
                              label: 'Username',
                              borderColor: AppColors.mainAppColor,
                              controller: _emailController,
                              backgroundColor: AppColors.white,
                              validator: AppValidator.validateTextfield,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextFormField(
                              label: 'Password',
                              isPasswordField: true,
                              borderColor: AppColors.mainAppColor,
                              backgroundColor: AppColors.white,
                              validator: AppValidator.validateTextfield,
                              controller: _passwordController,
                              hint: 'Enter your password',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                // GestureDetector(
                                //   onTap: () {
                                //    AppNavigator.pushAndRemovePreviousPages(context, page: const AppSetUp());
                                //
                                //   },
                                //   child: const Align(
                                //     alignment:
                                //     Alignment.topRight,
                                //     child: CustomText(
                                //       text: "Reset setup",
                                //       color: AppColors.mainAppColor,
                                //       size: 16,
                                //       weight:
                                //       FontWeight.w400,
                                //     ),
                                //   ),
                                // ),
                                GestureDetector(
                                  onTap: () {
                                    AppNavigator.pushAndStackPage(context,
                                        page: const PasswordResetRequest());
                                  },
                                  child: const Align(
                                    alignment: Alignment.topRight,
                                    child: CustomText(
                                      text: "Forgot password ?",
                                      color: AppColors.mainAppColor,
                                      size: 16,
                                      weight: FontWeight.w400,
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
                                page: LandingPage(selectedIndex: 0));
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
              ),
            ),
          ))
        ],
      ),
    );
  }
}
