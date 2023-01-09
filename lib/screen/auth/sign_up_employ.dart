import 'package:flutter/material.dart';
import '../../controller/fb_auth_controller.dart';
import '../../helpers/helpers.dart';
import '../../widgets/app_text_filed.dart';

class SignUpEmpScreen extends StatefulWidget  {
  const SignUpEmpScreen({Key? key}) : super(key: key);

  @override
  _SignUpEmpScreenState createState() => _SignUpEmpScreenState();
}

class _SignUpEmpScreenState extends State<SignUpEmpScreen> with Helpers{
  late TextEditingController _emailEditingController;
  late TextEditingController _userEditingController;
  late TextEditingController _passwordEditingController;
  late TextEditingController _password2EditingController;

  List<String> _locations = ['غزة','خانيونس', 'رفح', 'الوسطى', 'الشمال']; // Option 2
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
        padding: EdgeInsets.only(
          top: 40,
          right: 20,
          left: 20,
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'تسجيل حساب موظف',
                    style: TextStyle(
                      fontSize: 25,
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
                height: 30,
              ),
              AppTextFiled(
                controller: _userEditingController,
                hint: 'ادخل اسم المستخدم',
                lable: 'اسم المستخدم',
                suffixIcon: Icons.person,
                obscureText: false,
              ),
              SizedBox(
                height: 20,
              ),
              AppTextFiled(
                controller: _emailEditingController,
                hint: 'ادخل البريد الالكتروني',
                lable: 'البريد الالكتروني',
                suffixIcon: Icons.email,
                obscureText: false,
              ),
              SizedBox(
                height: 20,
              ),
              AppTextFiled(
                controller: _passwordEditingController,
                hint: 'ادخل كلمة المرور',
                lable: 'كلمة المرور',
                suffixIcon: Icons.remove_red_eye,
                obscureText: true,
              ),
              SizedBox(
                height: 20,
              ),
              AppTextFiled(
                controller: _password2EditingController,
                hint: 'ادخل العمل الخاص بك',
                lable: 'المهنة او العمل',
                suffixIcon: Icons.work,
                obscureText: false,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: DropdownButton(
                    hint: Text('اختار المدينة '),
                    value: _selectedLocation,
                    items: _locations.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
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
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: ()  {
                  performRegister();
                },
                child: const Text(
                  'تسجيل الحساب',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF042C4C),
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
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
    bool status = await FbAuthController().createAccount(
      context: context,
      email: _emailEditingController.text,
      username: _userEditingController.text,
      city: _selectedLocation.toString(),
      password: _passwordEditingController.text,
      type: _password2EditingController.text,
      number: 2,
    );
    Navigator.pushNamed(context, '/sginin_screen');
  }
}
