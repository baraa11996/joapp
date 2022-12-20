import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutBording extends StatefulWidget {
  const OutBording({Key? key}) : super(key: key);

  @override
  _OutBordingState createState() => _OutBordingState();
}

class _OutBordingState extends State<OutBording> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40.h,),
            Text('JoApp',style: TextStyle(fontSize: 32,fontFamily: 'Muli',color: Color(0xFF042C4C),fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Container(
              width: 200,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/jobs1.jpg'),
                )
              ),
            ),
            SizedBox(height: 10,),
            Text('مرحبا بك',style: TextStyle(fontSize: 32,fontFamily: 'Muli',fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text('يتيح لك تطبيق جو اب الخدمات التي تحتاجها من تنزيل الوظائف المختلفة ان كنت صاحب عمل وتحتاج الى موظفين او يتيح لك التقديم على الوظائف المعروضة ان كنت تبحث عن وظيفة او عمل',style: TextStyle(fontSize: 18,fontFamily: 'Muli'),textAlign: TextAlign.center),
            SizedBox(height: 15.h,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sign_up_screen');
              },
              child: Text(
                'صاحب عمل ',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFF042C4C),
                  minimumSize: const Size(200, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )
              ),
            ),
            SizedBox(height: 15,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sign_up_emp_screen');
              },
              child: Text(
                'موظف',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFF042C4C),
                  minimumSize: const Size(200, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )
              ),
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/sginin_screen');
                  },
                  child: Text(
                    ' لدي حساب بالفعل',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
