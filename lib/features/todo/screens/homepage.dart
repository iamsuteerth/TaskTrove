import 'package:flutter/material.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/text_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ReusableText(
          text: 'ToDo',
          style: appstyle(
            26,
            AppConstants.kBlueLight,
            FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
