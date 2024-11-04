import 'package:flutter/material.dart';
import 'package:simap/model/student_profile.dart';
import 'package:simap/view/app_screens/library_section/library_components/book_list.dart';

import '../../../model/class_model.dart';
import '../../../utills/app_utils.dart';
import '../../widgets/appBar_widget.dart';
import '../../widgets/drop_down.dart';

class LibraryPage extends StatefulWidget {
  StudentProfile studentProfile;
  ClassModel classModel;

  LibraryPage({super.key, required this.studentProfile,required this.classModel});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  String selectedSubject = '';
  String selectedBook = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
               MainAppBar(
                isBackKey: true,studentProfile: widget.studentProfile, classModel: widget.classModel,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    DropDown(
                        selectedValue: selectedSubject,
                        hint: "Subject",
                        showLabel: true,
                        label: "Select Book",
                        borderRadius: 10,
                        items: ['item 1', 'item 2', 'item 3', 'item 4']),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        DropDown(
                            selectedValue: selectedBook,
                            width: AppUtils.deviceScreenSize(context).width / 2,
                            hint: "Select book",
                            showLabel: false,
                            borderRadius: 10,
                            items: const [
                              'item 1',
                              'item 2',
                              'item 3',
                              'item 4'
                            ]),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BookListScreen(),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
