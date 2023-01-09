import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:joapp/prefs/shared_prefs.dart';
import 'package:joapp/screen/add_image.dart';
import 'package:joapp/screen/auth/sgin_in.dart';
import 'package:joapp/screen/auth/sign_up.dart';
import 'package:joapp/screen/auth/sign_up_employ.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:joapp/screen/bn_screen/profile_screen.dart';
import 'package:joapp/screen/category_sreen.dart';
import 'package:joapp/screen/change_image.dart';
import 'package:joapp/screen/home_screen.dart';
import 'package:joapp/screen/lunchscreen.dart';
import 'package:joapp/screen/main_screen.dart';
import 'package:joapp/screen/outbording_screen.dart';

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
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Muli',
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              },
            ),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: const [
            Locale('ar'),
            Locale('en'),
          ],
          locale: const Locale('ar'),
          initialRoute: ('/lunch_screen'),
          routes: {
            '/lunch_screen': (context) => const LunchScreen(),
            '/OutBording_screen': (context) => const OutBording(),
            '/sginin_screen': (context) => const SginInScreen(),
            '/sign_up_screen': (context) => const SignUpScreen(),
            '/sign_up_emp_screen': (context) => const SignUpEmpScreen(),
            '/home_screen': (context) => const HomeScreen(),
            '/main_screen': (context) => const MainScreen(),
            '/select_image': (context) => const ChangeImage(),
            '/add_image': (context) => const AddImage(),
            '/profile_screen': (context) => const ProfileScreen(),
            '/category_screen': (context) => const CategoryScreen1(),
          },
        );
      },
    );
  }
}
