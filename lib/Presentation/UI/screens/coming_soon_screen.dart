import 'package:bmi_calculator/Presentation/UI/utils/extension_utils.dart';
import 'package:bmi_calculator/Presentation/UI/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(""),
      body: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          Icon(Icons.update_disabled_outlined, size: 40).centered(),
          10.hb,
          Text(
            "Coming Soon, please try again later😊",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
