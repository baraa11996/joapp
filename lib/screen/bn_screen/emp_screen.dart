import 'package:flutter/material.dart';

class EmpScreen extends StatefulWidget {
  const EmpScreen({Key? key}) : super(key: key);

  @override
  _EmpScreenState createState() => _EmpScreenState();
}

class _EmpScreenState extends State<EmpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('order'),
      ),
    );
  }
}