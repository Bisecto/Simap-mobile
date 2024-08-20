import 'package:flutter/material.dart';
import 'package:simap/view/app_screens/home_section/welcome_container.dart';

import '../../widgets/appBar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFCFCFC),
      body: SafeArea(child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            MainAppBar(),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  WelcomeContainer()
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
