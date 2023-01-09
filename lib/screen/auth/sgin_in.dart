import 'package:flutter/material.dart';
import '../../helpers/helpers.dart';
import '../../prefs/shared_prefs.dart';
import '../../widgets/app_text_filed.dart';
import '../../controller/fb_auth_controller.dart';

class SginInScreen extends StatefulWidget {
  const SginInScreen({Key? key}) : super(key: key);

  @override
  _SginInScreenState createState() => _SginInScreenState();
}

class _SginInScreenState extends State<SginInScreen> with Helpers {
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;

  @override
  void initState() {
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 80,
          right: 20,
          left: 20,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Muli',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 100,
                height: 100,
                child: Image(
                  // fit: BoxFit.cover,
                  image: AssetImage('images/response.png'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'JoApp',
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'Muli',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF042C4C),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              AppTextFiled(
                controller: _emailEditingController,
                hint: 'ادخل البريد الالكتروني',
                lable: 'البريد الالكتروني',
                suffixIcon: Icons.email,
                obscureText: false,
              ),
              SizedBox(
                height: 40,
              ),
              AppTextFiled(
                controller: _passwordEditingController,
                hint: 'ادخل كلمة المرور',
                lable: 'كلمة المرور',
                suffixIcon: Icons.remove_red_eye,
                obscureText: true,
              ),
              SizedBox(
                height: 60,
              ),
              ElevatedButton(
                onPressed: () {
                  performLogin();
                },
                child: const Text(
                  'تسجيل الدخول',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF042C4C),
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
              SizedBox(height: 15),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       'هل لديك حساب سابق ؟',
              //       style: TextStyle(color: Colors.grey),
              //     ),
              //     TextButton(
              //       onPressed: () {
              //         Navigator.pushNamed(context, '/sign_up_screen');
              //       },
              //       child: Text(
              //         ' تسجيل حساب جديد',
              //         style: TextStyle(color: Colors.blue),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (_emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
      context: context,
      message: 'Enter required data!',
      error: true,
    );
    return false;
  }

  Future<void> login() async {
    bool status = await FbAuthController().signIn(
        context: context,
        email: _emailEditingController.text,
        password: _passwordEditingController.text);
    if (status) {
      await SharedPrefController().saveLogin();
      await SharedPrefController()
          .savePassword(password: _passwordEditingController.text.toString());
      Navigator.pushReplacementNamed(context, '/main_screen');
    }
  }
}
