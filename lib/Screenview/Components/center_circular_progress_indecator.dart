import 'package:flutter/material.dart';

class CenterCircularProgressIndecator extends StatefulWidget {
  const CenterCircularProgressIndecator({super.key});

  @override
  State<CenterCircularProgressIndecator> createState() =>
      _CenterCircularProgressIndecatorState();
}

class _CenterCircularProgressIndecatorState
    extends State<CenterCircularProgressIndecator> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
