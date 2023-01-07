import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:joapp/prefs/shared_prefs.dart';
import 'package:joapp/screen/add_image.dart';
import 'package:joapp/screen/auth/sgin_in.dart';
import 'package:joapp/screen/auth/sign_up.dart';
import 'package:joapp/screen/auth/sign_up_employ.dart';
import 'package:joapp/screen/bn_screen/category_screen.dart';
import 'package:joapp/screen/bn_screen/profile_screen.dart';
import 'package:joapp/screen/category_sreen.dart';
import 'package:joapp/screen/change_image.dart';
import 'package:joapp/screen/home_screen.dart';
import 'package:joapp/screen/lunchscreen.dart';
import 'package:joapp/screen/main_screen.dart';
import 'package:joapp/screen/outbording_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initSharedPref();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return GetMaterialApp(
          theme: ThemeData(
              fontFamily: 'Muli',
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const[
            Locale('ar'),
            Locale('en'),
          ],

          initialRoute: ('/lunch_screen'),
          routes: {
            '/lunch_screen' : (context) => LunchScreen(),
            '/OutBording_screen' : (context) => OutBording(),
            '/sginin_screen' : (context) => SginInScreen(),
            '/sign_up_screen' : (context) => SignUpScreen(),
            '/sign_up_emp_screen' : (context) => SignUpEmpScreen(),
            '/home_screen' : (context) => HomeScreen(),
            '/main_screen' : (context) => MainScreen(),
            '/select_image' : (context) => ChangeImage(),
            '/add_image' : (context) => AddImage(),
            '/profile_screen' : (context) => ProfileScreen(),
            '/category_screen' : (context) => CategoryScreen1(),
          },
        );
      },
    );
  }
}

