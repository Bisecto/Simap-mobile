import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simap/model/school_model.dart';

import '../../../bloc/app_bloc/app_bloc.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_icons.dart';
import '../../../utills/app_utils.dart';
import '../../../utills/app_validator.dart';
import '../../widgets/app_custom_text.dart';
import '../../widgets/app_loading_bar.dart';
import '../../widgets/dialog_box.dart';
import '../../widgets/form_input.dart';

class ListOfSchools extends StatefulWidget {
  const ListOfSchools({super.key});

  @override
  State<ListOfSchools> createState() => _ListOfSchoolsState();
}

class _ListOfSchoolsState extends State<ListOfSchools> {
  TextEditingController schNameController = TextEditingController();

  AppBloc appBloc = AppBloc();

  @override
  void initState() {
    // TODO: implement initState
    appBloc.add(GetSchoolsEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (AppUtils.deviceScreenSize(context).height / 1.2) - 50,
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Column(
        children: [
          Container(
            height: 60,
            decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SvgPicture.asset(
                      AppIcons.backgroundTop,
                      height: 60,
                      width: double.infinity,
                      placeholderBuilder: (context) {
                        return Container(
                          height: 50,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child:
                              const Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 10, // Adjust position as needed
                    left: 10,
                    right: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextStyles.textHeadings(
                          textValue: 'Schools',
                          textColor: AppColors.mainAppColor,
                          textSize: 14,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.cancel,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocConsumer<AppBloc, AppState>(
            bloc: appBloc,
            listener: (context, state) async {
              if (state is GetSchoolsSuccessState) {
                // Handle success, navigate or show a message
              } else if (state is ErrorState) {
                MSG.warningSnackBar(context, state.error);
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(
                  child: AppLoadingPage("Loading......"),
                );
              } else if (state is GetSchoolsSuccessState) {
                final successResponse = state as GetSchoolsSuccessState;
                return Expanded(
                  child: ListView.builder(
                    itemCount: successResponse.listOfSchools.length + 1,
                    // Adjust for search bar
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CustomTextFormField(
                            controller: schNameController,
                            hint: 'Search',
                            label: '',
                            borderColor: schNameController.text.isNotEmpty
                                ? AppColors.green
                                : AppColors.grey,
                            backgroundColor: AppColors.white,
                            widget: const Icon(Icons.search),
                          ),
                        );
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          child: ListTile(
                            leading: Image.network(
                              successResponse.listOfSchools[index - 1].logo,
                              height: 40,
                              width: 40,
                            ),
                            title: Text(
                                successResponse.listOfSchools[index - 1].name),
                            onTap: () {
                              Navigator.pop(
                                context,
                                successResponse.listOfSchools[index - 1],
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                );
              } else {
                return const Center(
                  child: AppLoadingPage("Loading......"),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
