import 'package:flutter/material.dart';
import 'Presentation/UI/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: .dark),
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}
