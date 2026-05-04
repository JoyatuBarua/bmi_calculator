import 'package:flutter/material.dart';

dynamic appBar(String title) => AppBar(
  backgroundColor: Colors.transparent,
  centerTitle: true,
  toolbarHeight: 30,
  title: Text(
    title,
    style: TextStyle(
      color: const Color.fromRGBO(199, 199, 199, 1),

      fontWeight: .bold,
    ),
  ),
);
