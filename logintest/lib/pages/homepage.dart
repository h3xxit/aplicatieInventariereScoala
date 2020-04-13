import 'package:flutter/material.dart';
import 'package:logintest/scanner/barcode_detector.dart';
import 'package:flutter/rendering.dart';
import 'package:logintest/bloc.navigation_bloc/navigation_bloc.dart';

class HomePage extends StatelessWidget with NavigationStates{
  @override
  Widget build(BuildContext context) {
    return new ScanScreen();
  }
}