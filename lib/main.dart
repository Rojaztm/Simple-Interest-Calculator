// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:si_calculator/si.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        accentColor: Colors.indigo,
      ),
      home: const SimpleInterest(),
    ),
  );
}
