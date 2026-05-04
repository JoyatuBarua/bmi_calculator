import 'package:bmi_calculator/Presentation/UI/utils/extension_utils.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';

class BMICard extends StatelessWidget {
  const BMICard({super.key, required this.result});
  final String result;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final bmiCardWidth = deviceWidth * .92;
    final bmiCardHeight = deviceHeight * .4;
    return Container(
      // color: Colors.amber,
      decoration: BoxDecoration(
        color: Color.fromRGBO(35, 35, 35, 155),
        border: BoxBorder.all(
          color: const Color.fromRGBO(199, 199, 199, 1),
          width: 0.2,
        ),
        borderRadius: .circular(12),
      ),
      width: bmiCardWidth,
      height: bmiCardHeight,
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .center,
        children: [
          10.hb,
          SizedBox(
            child: Row(
              mainAxisAlignment: .center,
              children: [
                Text(
                  result,
                  style: TextStyle(
                    fontSize: 45,
                    color: const Color.fromARGB(255, 255, 115, 34),
                  ),
                ),
                5.wb,
                Column(
                  mainAxisAlignment: .start,
                  children: [
                    Text(
                      "BMI",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    Text(
                      "Normal",
                      style: TextStyle(fontSize: 10, color: Colors.green),
                    ),
                  ],
                ),
              ],
            ),
          ),
          10.hb,
          Container(
            width: bmiCardWidth * .9,
            height: 3,
            decoration: BoxDecoration(
              color: Color.fromRGBO(114, 116, 129, 90),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 1,
                  blurRadius: 9,
                  offset: Offset(0, 3),
                  blurStyle: .normal,
                ),
              ],
            ),
          ),
          10.hb,
          Text(
            "Information",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          10.hb,
          SfLinearGauge(
            showLabels: true,

            // labelPosition: .outside,
            labelOffset: 10,
            minimum: 0,
            maximum: 60.0,
            showTicks: false,
            showAxisTrack: false,
            onGenerateLabels: () {
              return [
                LinearAxisLabel(text: '0.0', value: 0),
                LinearAxisLabel(text: '18.5', value: 18.5),
                LinearAxisLabel(text: '25.0', value: 25.0),
                LinearAxisLabel(text: '40.0', value: 40.0),
                LinearAxisLabel(text: '60.0', value: 60.0),
              ];
            },
            markerPointers: [
              LinearWidgetPointer(
                offset: 20,
                position: .outside,
                value: 9.2,
                child: Text(
                  "Underweight",
                  style: TextStyle(color: Colors.cyan, fontSize: 10),
                ),
              ),
              LinearWidgetPointer(
                offset: 20,
                position: .outside,
                value: 21.75,
                child: Text(
                  "Normal",
                  style: TextStyle(color: Colors.green, fontSize: 10),
                ),
              ),
              LinearWidgetPointer(
                offset: 20,
                position: .outside,
                value: 32.5,
                child: Text(
                  "Overweight",
                  style: TextStyle(color: Colors.amber, fontSize: 10),
                ),
              ),
              LinearWidgetPointer(
                offset: 20,
                position: .outside,
                value: 50,
                child: Text(
                  "Obese",
                  style: TextStyle(color: Colors.red, fontSize: 10),
                ),
              ),

              LinearShapePointer(
                value: 20.8,
                color: Colors.teal,
                shapeType: .invertedTriangle,
                height: 20,
                width: 12,
              ),
            ],

            ranges: <LinearGaugeRange>[
              LinearGaugeRange(
                edgeStyle: .startCurve,
                startWidth: 10,
                endWidth: 10,
                startValue: 0,
                endValue: 18.5,
                color: Colors.cyan,
              ),
              LinearGaugeRange(
                startWidth: 10,
                endWidth: 10,
                startValue: 18.5,
                endValue: 25.0,
                color: Colors.green,
              ),
              LinearGaugeRange(
                startWidth: 10,
                endWidth: 10,
                startValue: 25.0,
                endValue: 40.0,
                color: Colors.amber,
              ),
              LinearGaugeRange(
                edgeStyle: .endCurve,
                startWidth: 10,
                endWidth: 10,
                startValue: 40.0,
                endValue: 60.0,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
