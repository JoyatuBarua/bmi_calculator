import 'package:bmi_calculator/Presentation/UI/utils/extension_utils.dart';
import 'package:flutter/material.dart';
import 'button_widget.dart';

// ignore: must_be_immutable
class BuildButtons extends StatefulWidget {
  String? value;
  final ValueChanged<String> onButtonClick;
  final String title;
  BuildButtons({
    super.key,
    this.value,
    required this.onButtonClick,
    required this.title,
  });

  @override
  State<BuildButtons> createState() => _BuildButtonsState();
}

class _BuildButtonsState extends State<BuildButtons> {
  @override
  Widget build(BuildContext context) {
    final devicewidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    double roundedRectangullarButtonHeight;
    double roundedRectangullarButtonWidth;
    // MainAxisAlignment mainAxisAlignment;

    // if (devicewidth > 450) {
    //   // mainAxisAlignment = .spaceEvenly;
    //   // roundedRectangullarButtonHeight = 970 * .18;
    //   // roundedRectangullarButtonWidth = 450 * .2;
    //   roundedRectangullarButtonHeight = 450 * .3;
    //   roundedRectangullarButtonWidth = 150 * .12;
    // } else {
    //   // roundedRectangullarButtonHeight = devicewidth * .4;
    //   // mainAxisAlignment = .spaceBetween;
    //   roundedRectangullarButtonHeight = deviceHeight * .20;
    //   roundedRectangullarButtonWidth = devicewidth * .15;
    // }
    roundedRectangullarButtonHeight = deviceHeight * .20;
    roundedRectangullarButtonWidth = devicewidth * .15;
    bool isVisible = false;
    String isVisibleDependentButtonText = '+/-';
    String isVisibleDependentButtonOutput = '-';
    if (widget.title == "Temperature" ||
        widget.title == "BMI" ||
        widget.title == "Loan") {
      roundedRectangullarButtonHeight = deviceHeight * .15;
      roundedRectangullarButtonWidth = devicewidth * .15;
      isVisible = true;
      if (widget.title == "BMI" || widget.title == "Loan") {
        isVisibleDependentButtonOutput = '=';
        isVisibleDependentButtonText = "Go";
      }
    }

    final buttonSpacing = (devicewidth <= 450)
        ? (devicewidth * .05)
        : (450 * .05);

    Widget buildButton(String value) {
      return Button(
        buttonText: value,
        onPressed: () => widget.onButtonClick(value),
      );
    }

    // editing starts
    return SizedBox(
      child: FittedBox(
        fit: .scaleDown,
        child: Column(
          mainAxisSize: .min,
          children: [
            Row(
              mainAxisAlignment: .center,
              crossAxisAlignment: .start,
              children: [
                SizedBox(
                  // width: 300,
                  // editing starts
                  child: Column(
                    children: [
                      buildButton('7'),
                      // buttonSpacing.hb,
                      buildButton('4'),
                      // buttonSpacing.hb,
                      buildButton('1'),
                    ],
                  ),
                ),
                // buttonSpacing.wb,
                SizedBox(
                  // width: 300,
                  child: Column(
                    children: [
                      buildButton('8'),
                      // buttonSpacing.hb,
                      buildButton('5'),
                      // buttonSpacing.hb,
                      buildButton('2'),
                      // buttonSpacing.hb,
                      buildButton('0'),
                    ],
                  ),
                ),
                // buttonSpacing.wb,
                SizedBox(
                  // width: 300,
                  child: Column(
                    children: [
                      buildButton('9'),
                      // buttonSpacing.hb,
                      buildButton('6'),
                      // buttonSpacing.hb,
                      buildButton('3'),
                      // buttonSpacing.hb,
                      buildButton('.'),
                    ],
                  ),
                ),
                10.wb,

                SizedBox(
                  // width: 300,
                  child: Column(
                    children: [
                      Button(
                        buttonText: "AC",
                        buttonColor: const Color.fromARGB(255, 34, 33, 33),
                        textColor: const Color.fromARGB(255, 255, 115, 34),
                        buttonSize: Size(
                          roundedRectangullarButtonWidth,
                          roundedRectangullarButtonHeight,
                        ),
                        onPressed: () => widget.onButtonClick('AC'),
                      ),
                      buttonSpacing.hb,
                      Button(
                        buttonText: "⌫ ",
                        buttonColor: const Color.fromARGB(255, 34, 33, 33),
                        textColor: const Color.fromARGB(255, 255, 115, 34),
                        buttonSize: Size(
                          roundedRectangullarButtonWidth,
                          roundedRectangullarButtonHeight,
                        ),
                        onPressed: () => widget.onButtonClick('X'),
                      ),
                      buttonSpacing.hb,
                      Visibility(
                        visible: isVisible,
                        child: Button(
                          buttonText: isVisibleDependentButtonText,
                          buttonColor: const Color.fromARGB(255, 34, 33, 33),
                          textColor: const Color.fromARGB(255, 255, 115, 34),
                          buttonSize: Size(
                            roundedRectangullarButtonWidth,
                            roundedRectangullarButtonHeight,
                          ),
                          onPressed: () => widget.onButtonClick(
                            isVisibleDependentButtonOutput,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Column(
                //   // crossAxisAlignment: ,
                //   children: [],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
