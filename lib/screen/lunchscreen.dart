import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../prefs/shared_prefs.dart';

class LunchScreen extends StatefulWidget {
  const LunchScreen({Key? key}) : super(key: key);

  @override
  _LunchScreenState createState() => _LunchScreenState();
}

class _LunchScreenState extends State<LunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      String route = SharedPrefController().logged ? '/OutBording_screen' : '/main_screen';
      Navigator.pushReplacementNamed(context, route);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green,
      ),
      child: Container(
        width: double.infinity,
        child: Image(
            fit: BoxFit.cover,
            image: AssetImage(
              'images/launch.jpg',
            )),
      ),
    ),
    );

  }
}
