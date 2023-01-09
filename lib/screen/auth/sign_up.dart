import 'package:flutter/material.dart';
import '../../controller/fb_auth_controller.dart';
import '../../helpers/helpers.dart';
import '../../widgets/app_text_filed.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with Helpers {
  late TextEditingController _emailEditingController;
  late TextEditingController _userEditingController;
  late TextEditingController _passwordEditingController;
  late TextEditingController _password2EditingController;

  final List<String> _locations = [
    'غزة',
    'خانيونس',
    'رفح',
    'الوسطى',
    'الشمال'
  ]; // Option 2
  String? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _emailEditingController = TextEditingController();
    _userEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    _password2EditingController = TextEditingController();
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _userEditingController.dispose();
    _passwordEditingController.dispose();
    _password2EditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.topEnd,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 40,
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
                    'تسجيل حساب صاحب عمل',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Muli',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const SizedBox(
                width: 100,
                height: 100,
                child: Image(
                  // fit: BoxFit.cover,
                  image: AssetImage('images/response.png'),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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
              const SizedBox(height: 30),
              AppTextFiled(
                controller: _userEditingController,
                hint: 'ادخل اسم المستخدم',
                lable: 'اسم المستخدم',
                suffixIcon: Icons.person,
                obscureText: false,
              ),
              const SizedBox(height: 20),
              AppTextFiled(
                controller: _emailEditingController,
                hint: 'ادخل البريد الالكتروني',
                lable: 'البريد الالكتروني',
                suffixIcon: Icons.email,
                obscureText: false,
              ),
              const SizedBox(height: 20),
              AppTextFiled(
                controller: _passwordEditingController,
                hint: 'ادخل كلمة المرور',
                lable: 'كلمة المرور',
                suffixIcon: Icons.remove_red_eye,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              AppTextFiled(
                controller: _password2EditingController,
                hint: 'ادخل العمل الخاص بك',
                lable: 'المهنة او العمل',
                suffixIcon: Icons.work,
                obscureText: false,
              ),
              const SizedBox(height: 10),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: DropdownButton(
                    hint: const Text('اختار المدينة '),
                    value: _selectedLocation,
                    items: _locations.map((location) {
                      return DropdownMenuItem(
                        child: Text(location),
                        value: location,
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLocation = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  performRegister();
                },
                child: const Text(
                  'تسجيل الحساب',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF042C4C),
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> performRegister() async {
    if (checkData()) {
      await register();
    }
  }

  bool checkData() {
    if (_emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty &&
        _password2EditingController.text.isNotEmpty &&
        _selectedLocation.toString().isNotEmpty) {
      return true;
    }
    showSnackBar(
      context: context,
      message: 'Enter required data!',
      error: true,
    );
    return false;
  }

  Future<void> register() async {
    await FbAuthController().createAccount(
      context: context,
      email: _emailEditingController.text,
      username: _userEditingController.text,
      city: _selectedLocation.toString(),
      password: _passwordEditingController.text,
      type: _password2EditingController.text,
      number: 1,
    );
    Navigator.pushNamed(context, '/sginin_screen');
  }
}
