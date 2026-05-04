import 'package:flutter/material.dart';
import 'package:bmi_calculator/Presentation/UI/utils/extension_utils.dart';
import '../widgets/app_bar.dart';
import '../widgets/bmi_calculation_row_widget.dart';
import '../widgets/build_buttons_widget.dart';
import '../widgets/bmi_card_widget.dart';
import 'package:intl/intl.dart';
import 'package:bmi_calculator/Data/data.dart';

int position = 0;
int maxWholePartLengthForFractionNumber =
    4; // this includes the '.' thus length is 4, but the max digits here is 3
int maxWholePartLength =
    3; // this includes the '.' thus length is 3, but the max digits here is 2

// ignore: must_be_immutable
class BmiCalculatePage extends StatefulWidget {
  final Map<String, double> conversionTypes2;
  String topSelectedUnit;
  String bottomSelectedUnit;
  final String appBarTitle;
  BmiCalculatePage({
    super.key,
    required this.conversionTypes2,
    required this.topSelectedUnit,
    required this.bottomSelectedUnit,
    required this.appBarTitle,
  });
  @override
  State<BmiCalculatePage> createState() => _BmiCalculatePageState();
}

class _BmiCalculatePageState extends State<BmiCalculatePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _valueControllerTop =
      TextEditingController();
  late final TextEditingController _valueControllerBottom =
      TextEditingController();
  late String topValueControllerType;
  late String bottomValueControllerType;
  late bool showNumPad;
  late bool showCard;

  @override
  void initState() {
    super.initState();
    _valueControllerTop.text = '0';
    _valueControllerBottom.text = '0';
    showCard = false;
    showNumPad = true;
  }

  @override
  void dispose() {
    _valueControllerTop.dispose();
    _valueControllerBottom.dispose();
    super.dispose();
  }

  dynamic showSnackBar() {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 250,
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: .circular(20)),
        backgroundColor: const Color.fromRGBO(35, 35, 35, 200),
        content: const Text(
          'Enter valid Parameters',
          textAlign: .center,
          style: TextStyle(color: Colors.orange, fontSize: 13),
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // handle input based on button click
  void handleInput(String value) {
    TextEditingController activeController = (position == 0)
        ? _valueControllerTop
        : _valueControllerBottom;

    // remove all commas(,)
    String currentInput = activeController.text.replaceAll(',', '');
    int wholePartLength = 0;

    if (currentInput.contains('.')) {
      int index = currentInput.indexOf('.');
      String wholePart = currentInput.substring(0, index);
      wholePartLength = wholePart.length;
    } else {
      wholePartLength = currentInput.length;
    }
    if (value != 'X' && value != "AC" && value != '=') {
      //  accepts inputs from users with '.' of max length of 3 for whole part (3 digit of whole number + 1 '.')
      //  and/or max length of 2 fraction part (2 digits after '.')
      if (currentInput.contains('.')) {
        if (wholePartLength == maxWholePartLengthForFractionNumber ||
            (currentInput.length - wholePartLength) == 3) {
          return;
        }
        // accepts inputs from users of max length of 3 (3 digit whole number) with no '.'
      } else if (currentInput.length >= maxWholePartLength &&
          currentInput.contains('.') == false &&
          value != '.') {
        return;
      }
    }

    if (value == "AC") {
      clearAll();

      return;
    } else if (value == 'X') {
      currentInput = (currentInput.length > 1)
          ? currentInput.substring(0, currentInput.length - 1)
          : '0';
    } else if (value == '=') {
      bmiCalculate(currentInput, position, position == 0);
    } else if (value == '.') {
      if (currentInput.contains('e') != true ||
          currentInput.contains('.') != true) {
        currentInput += value;
      }
    } else {
      if (value == '0' && currentInput.length == 1 && currentInput == '0') {
        currentInput = value;
      } else if (currentInput == '0' && currentInput.contains('e') != true) {
        currentInput = value;
      } else {
        /////////////////////////////////////////see here
        if (wholePartLength >= 10 && currentInput.contains('.') != true) {
          currentInput += value;

          String src = currentInput;
          // String src = currentInput;

          activeController.text = src;
          return;
        } else {
          currentInput += value;
          // print(currentInput);
        }
      }
    }

    // for livefomatting
    //-------------------------------------------------------------------------------

    // if (the input ends with a '.')
    //   then, remove the '.' and call value formatter to format the value,
    //   set the value as the new current input, add '.' after the current input
    if (currentInput.endsWith('.')) {
      currentInput = valueFormatter(
        double.tryParse(currentInput.replaceAll('.', '')) ?? 0,
      );
      currentInput += '.';
    }
    // else if (the input contains '.')
    //   then, divide the current input into two substrings of whole number and fractional part
    //   format the whole number part with valueformatter as it will have commas
    //   lastly concatinate the formatted whole number part, '.' and the fractional part
    else if (currentInput.contains('.')) {
      List<String> parts = currentInput.split('.');
      String wholePart = valueFormatter(double.tryParse(parts[0]) ?? 0);
      currentInput = "$wholePart.${parts[1]}";
    }
    // else
    //   format the current input normally
    else {
      currentInput = valueFormatter(double.tryParse(currentInput) ?? 0);
    }

    // the currently selected textfield's controller will be used to take the current input
    activeController.text = currentInput;
  }

  // formats value with ','  and '.'
  String valueFormatter(double value) {
    final formatter = NumberFormat("#,##0.#########", "en_US");
    print('formatted ${formatter.format(value)}');

    return formatter.format(value);
  }

  void setTypesForValueControllers(
    bool activeTopController,
    String valueControllerType,
  ) {
    if (activeTopController == true) {
      widget.topSelectedUnit = valueControllerType;
    } else {
      widget.bottomSelectedUnit = valueControllerType;
    }
  }

  // function that converts units from one type to another
  void bmiCalculate(String newValue, int? position, bool activeTopController) {
    try {
      final Map<String, dynamic>? lengthData =
          allConvertersForPage2[1]["conversionData"];
      final Map<String, dynamic>? weightData =
          allConvertersForPage2[2]["conversionData"];

      if (lengthData == null || weightData == null) {
        // print("Error: Conversion data not found");
        return;
      }
      double topFactorForLength = lengthData[widget.bottomSelectedUnit];
      double bottomFactorForLength = lengthData['Meter m'];
      double topFactorForMass = weightData[widget.topSelectedUnit];
      double bottomFactorForMass = weightData['Kilogram kg'];

      double typeCorrespondingRatioForLength =
          (topFactorForLength / bottomFactorForLength);
      double typeCorrespondingRatioForMass =
          (topFactorForMass / bottomFactorForMass);

      double weightInKg =
          typeCorrespondingRatioForMass *
          double.parse(_valueControllerTop.text.replaceAll(',', ''));

      double lengthInMeter =
          typeCorrespondingRatioForLength *
          double.parse(_valueControllerBottom.text.replaceAll(',', ''));

      if (double.parse(_valueControllerTop.text.replaceAll(',', '')) == 0 ||
          double.parse(_valueControllerBottom.text.replaceAll(',', '')) == 0 ||
          lengthInMeter == 0 ||
          weightInKg == 0) {
        result = "Enter valid parameters";
        showSnackBar();
        return;
      }

      double bmi = weightInKg / (lengthInMeter * lengthInMeter);

      if (bmi > 60 || bmi < 0) {
        showSnackBar();
        return;
      }

      setState(() {
        // the conversion of the sourceValue is done using its corresponding rate and stored inside the result
        result = bmi.toStringAsFixed(2);
        showCard = true;
        showNumPad = false;
      });
    } catch (e) {
      // print("Error $e");
      throw ("Error $e");
    }
  }

  // function that resets the top and bottom textfields for all types
  void clearAll() {
    setState(() {
      _valueControllerTop.text = '0';
      _valueControllerBottom.text = '0';
      result = '0';
    });
  }

  String result = '0';
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    final Map<String, double> conversionTypesForWeight = Map.fromEntries(
      (widget.conversionTypes2).entries.take(2),
    );
    final Map<String, double> conversionTypesFoLength = Map.fromEntries(
      (widget.conversionTypes2).entries.toList().reversed.take(4),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBar(widget.appBarTitle),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            BMICalculatorRow(
              conversionTypes: conversionTypesForWeight,
              formKey: _formKey,
              setTypesForValueControllers: setTypesForValueControllers,
              activeTopController: true,
              valueController: _valueControllerTop,
              selectedUnit: widget.topSelectedUnit,
              onUnitChanged: (value) => setState(() {
                widget.topSelectedUnit = value;
                showCard = false;
              }),
              onTap: () => setState(() {
                position = 0;
                showCard = false;
                showNumPad = true;
              }),
              position: position,
            ).withPadding(0),

            BMICalculatorRow(
              conversionTypes: conversionTypesFoLength,
              formKey: _formKey,
              setTypesForValueControllers: setTypesForValueControllers,
              activeTopController: false,
              valueController: _valueControllerBottom,
              selectedUnit: widget.bottomSelectedUnit,
              onUnitChanged: (value) => setState(() {
                widget.bottomSelectedUnit = value;
                showCard = false;
              }),
              onTap: () => setState(() {
                position = 1;
                showCard = false;
                showNumPad = true;
              }),
              position: position,
            ).withPadding(0),

            (showCard == false) ? Spacer() : Container(),

            // buildbutton returns value on click
            AnimatedOpacity(
              opacity: showNumPad ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Visibility(
                visible: showNumPad,
                child: BuildButtons(
                  onButtonClick: (value) => handleInput(value),
                  title: widget.appBarTitle,
                ),
              ),
            ),

            AnimatedOpacity(
              opacity: showCard ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Visibility(
                visible: showCard,
                child: BMICard(result: result),
              ),
            ),

            (deviceHeight * .03).hb,
          ],
        ),
      ),
    );
  }
}
