import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_icons.dart';
import '../../../utills/app_utils.dart';
import '../../../utills/app_validator.dart';
import '../../widgets/app_custom_text.dart';
import '../../widgets/form_input.dart';

class ListOfSchools extends StatefulWidget {
  const ListOfSchools({super.key});

  @override
  State<ListOfSchools> createState() => _ListOfSchoolsState();
}

class _ListOfSchoolsState extends State<ListOfSchools> {
  final List<String> schools = [
    'Queen’s College, Lagos',
    'King’s College, Lagos',
    'Federal Government College, Lagos',
    'Federal Government College, Enugu',
    'Christ the King College, Onitsha',
    'Baptist High School, Jos',
    'Government College, Umuahia',
    'Ahmadiyya College, Agege',
    'Igbobi College, Lagos',
    'Mayflower School, Ikenne',
    'St. Gregory’s College, Lagos',
    'Barewa College, Zaria',
    'Fountain School, Lagos',
    'Atlantic Hall, Lagos',
    'Vivian Fowler Memorial College, Lagos',
  ];
  TextEditingController schNameController = TextEditingController();
  List<String> filteredSchools = [];

  @override
  void initState() {
    super.initState();
    filteredSchools = schools; // Initially show all schools
    schNameController.addListener(_filterSchools);
  }

  @override
  void dispose() {
    schNameController.removeListener(_filterSchools);
    schNameController.dispose();
    super.dispose();
  }

  void _filterSchools() {
    setState(() {
      filteredSchools = schools
          .where((school) => school
          .toLowerCase()
          .contains(schNameController.text.toLowerCase()))
          .toList();
    });
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
                          child: const Center(
                              child: CircularProgressIndicator()),
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
          Expanded(
            child: ListView.builder(
              itemCount: filteredSchools.length + 1, // Adjust for search bar
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
                      title: Text(filteredSchools[index - 1]),
                      onTap: (){
                        Navigator.pop(context,filteredSchools[index - 1]);
                      },// Adjust index
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
