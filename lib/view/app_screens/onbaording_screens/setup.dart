import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simap/model/school_model.dart';
import 'package:simap/utills/app_utils.dart';
import 'package:simap/view/widgets/drop_down.dart';
import 'package:simap/view/widgets/form_input.dart';

import '../../../bloc/app_bloc/app_bloc.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../../../utills/app_navigator.dart';
import '../../../utills/app_validator.dart';
import '../../../utills/enums/toast_mesage.dart';
import '../../widgets/app_custom_text.dart';
import '../../widgets/app_loading_bar.dart';
import '../../widgets/dialog_box.dart';
import '../../widgets/form_button.dart';
import '../../widgets/show_toast.dart';
import '../auth/sign_page.dart';
import 'list_of_schools.dart';
import 'onbaord_auth_background.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as modalSheet;

class AppSetUp extends StatefulWidget {
  const AppSetUp({super.key});

  @override
  State<AppSetUp> createState() => _AppSetUpState();
}

class _AppSetUpState extends State<AppSetUp> {
  String selectedPreference = '';
  TextEditingController schCodeController = TextEditingController();
  String logoUrl = '';
  AppBloc appBloc = AppBloc();
  SchoolModel selectedSchoolModel = SchoolModel(
    name: 'Nnamdi Azikiwe University Secondary School, Awka',
    address: "Nnamdi Azikiwe University Campus, Awka, Anambra State",
    logoUrl:
        'https://records.unizik.edu.ng/Content/Images/UNIZIK%20JUPEB%20Form%20is%20Out-%20Requirements,%20Price%20and%20How%20to%20Apply.png',
    schoolBaseUrl: "http://uhs.localhost.com/",
  );

  @override
  void initState() {
    // TODO: implement initState
    // appBloc.add(InitialEvent());
    super.initState();
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
            child: BlocConsumer<AppBloc, AppState>(
              bloc: appBloc,
              listener: (context, state) async {
                if (state is SetUpSuccessState) {
                  AppNavigator.pushAndRemovePreviousPages(context,
                      page: const SignPage());
                } else if (state is ErrorState) {
                  MSG.warningSnackBar(context, state.error);
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
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
                            text: '',
                            color: AppColors.textColor,
                            size: 18,
                            maxLines: 3,
                            weight: FontWeight.w400,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 5, 0, 0),
                            child: CustomText(
                              text: 'Who is using?',
                              color: AppColors.black,
                              size: 20,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              weight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedPreference = 'student';
                                  });
                                },
                                child: Container(
                                  width: 120,
                                  height: 170,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1,
                                          color: selectedPreference == 'student'
                                              ? AppColors.green
                                              : AppColors.white)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    width: 3,
                                                    color: AppColors
                                                        .mainAppColor
                                                        .withOpacity(0.2))),
                                            child: Center(
                                                child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .mainAppColor
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        image: const DecorationImage(
                                                            image: AssetImage(
                                                                AppImages
                                                                    .studentSetup))))),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: CustomText(
                                              text: 'Student',
                                              color: AppColors.textColor,
                                              size: 16,
                                              maxLines: 6,
                                              textAlign: TextAlign.center,
                                              weight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedPreference = 'guardian';
                                  });
                                },
                                child: Container(
                                  width: 120,
                                  height: 170,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1,
                                          color:
                                              selectedPreference == 'guardian'
                                                  ? AppColors.green
                                                  : AppColors.white)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    width: 3,
                                                    color: AppColors
                                                        .mainAppColor
                                                        .withOpacity(0.2))),
                                            child: Center(
                                                child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .mainAppColor
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        image: const DecorationImage(
                                                            image: AssetImage(
                                                                AppImages
                                                                    .guardianSetup))))),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: CustomText(
                                              text: 'Guardian',
                                              color: AppColors.textColor,
                                              size: 16,
                                              maxLines: 6,
                                              textAlign: TextAlign.center,
                                              weight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            // onTap: () async {
                            //   SchoolModel schoolModel;
                            //   schoolModel = (await modalSheet
                            //       .showMaterialModalBottomSheet(
                            //       backgroundColor: Colors.transparent,
                            //       isDismissible: true,
                            //       shape: const RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.vertical(
                            //             top: Radius.circular(20.0)),
                            //       ),
                            //       context: context,
                            //       builder: (context) => const Padding(
                            //         padding:
                            //         EdgeInsets.only(top: 100.0),
                            //         child: ListOfSchools(),
                            //       )))!;
                            //   setState(() {
                            //     selectedSchoolModel=schoolModel;
                            //     schNameController.text = schoolModel.name;
                            //     logoUrl = schoolModel.logoUrl;
                            //   });
                            // },
                            child: CustomTextFormField(
                              controller: schCodeController,
                              hint: 'Enter school code',
                              label: 'School code',
                              borderColor: schCodeController.text.isNotEmpty
                                  ? AppColors.green
                                  : AppColors.grey,
                              enabled: true,
                              widget: logoUrl == ''
                                  ? null
                                  : Image.network(
                                      logoUrl,
                                      height: 30,
                                      width: 30,
                                    ),
                              backgroundColor: AppColors.white,
                              validator: AppValidator.validateTextfield,
                              //suffixIcon: const Icon(Icons.arrow_drop_down),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          FormButton(
                            onPressed: () {
                              if (selectedPreference != '') {
                                if (schCodeController.text.isNotEmpty) {
                                  //print(selectedSchoolModel);
                                  appBloc.add(SetUpSchoolEvent(
                                      selectedSchoolModel,
                                      selectedPreference,
                                      context));
                                } else {
                                  showToast(
                                      context: context,
                                      title: "Info",
                                      subtitle:
                                          'Enter your school code to complete setup',
                                      type: ToastMessageType.info);
                                }
                              } else {
                                showToast(
                                    context: context,
                                    title: "Info",
                                    subtitle: 'Select who is using this app',
                                    type: ToastMessageType.info);
                              }
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
                                  color: AppColors.textColor,
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
                );
              },
            ),
          ))
        ],
      ),
    );
  }
}
