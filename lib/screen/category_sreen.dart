import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joapp/screen/post_screen.dart';
import '../models/category.dart';


class CategoryScreen1 extends StatefulWidget {
  const CategoryScreen1({Key? key}) : super(key: key);

  @override
  State<CategoryScreen1> createState() => _CategoryScreen1State();
}

class _CategoryScreen1State extends State<CategoryScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صفحة الفئات',style: TextStyle(fontSize: 22.sp),),
        centerTitle: true,
        backgroundColor: Color(0xFF042C4C),
        toolbarHeight: 70,     leadingWidth: 0,
        leading: const SizedBox.shrink(),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 7
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Container(
              margin: EdgeInsets.only(right: 10),
              clipBehavior: Clip.antiAlias,
              width: 200.w,
              height: 400.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      category.image,
                    ),
                  )),
              child: InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostScreen(category: category),
                    ),
                  );
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.black.withOpacity(.8),
                            Colors.black.withOpacity(.2),
                          ])),
                  child: Center(
                    child: Text(category.name, style: TextStyle(fontSize: 30.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
