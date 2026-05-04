import 'package:flutter/material.dart';

Map<String, double> bmiConversionTypes = {
  "Kilogram kg": 1.0,
  "Pound lb": 1.0,
  "Meter m": 1.0,
  "Foot ft": 1.0,
  "Inch in": 1.0,
  "Centimeter cm": 1.0,
};
Map<String, double> lengthConversionTypes = {
  "Kilometer km": 1000.0,
  "Meter m": 1.0,
  "Foot ft": 0.3048,
  "Inch in": 0.0254,
  "Centimeter cm": 0.01,
  "Millimeter mm": 0.001,
  "Mile mi": 1609.34,
  "Yard yd": 0.9144,
  "Decimeter dm": 0.1,
  "Nautical mile nmi": 1852.0,
  "Micrometer µm": 0.000001,
};

Map<String, double> massConversionTypes = {
  "Tonne t": 1000000.0,
  "Kilogram kg": 1000.0,
  "Gram gm": 1.0,
  "Milligram mg": 0.001,
  "Microgram µg": 0.000001,
  "Quintal q": 100000.0,
  "Pound lb": 453.592,
  "Ounce oz": 28.3495,
  "Carat ct": 0.2,
  "Grain gr": 0.0647989,
  "Long ton l.t": 1016046.91,
  "Short ton s.t": 907184.74,
  "UK hundredweight cwt": 50802.3,
  "US hundredweight cwt": 45359.2,
  "Stone st": 6350.29,
};

final List<Map<String, dynamic>> allConvertersForPage2 = [
  {
    "type": "BMI",
    "icon": Icons.monitor_weight_outlined,
    "topSelectedUnit": "Kilogram kg",
    "bottomSelectedUnit": "Centimeter cm",
    "conversionData": bmiConversionTypes,
  },

  {
    "type": "Length",
    "icon": Icons.straighten,
    "topSelectedUnit": "Meter m",
    "bottomSelectedUnit": "Kilometer km",
    "conversionData": lengthConversionTypes,
  },
  {
    "type": "Mass",
    "icon": Icons.person_2_outlined,
    "topSelectedUnit": "Kilogram kg",
    "bottomSelectedUnit": "Gram gm",
    "conversionData": massConversionTypes,
  },
];
