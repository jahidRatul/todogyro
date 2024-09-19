import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:link3app/core/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'todo_dashboard.dart';

class SplashToDoScreen extends StatefulWidget {
  const SplashToDoScreen({super.key});

  @override
  State<SplashToDoScreen> createState() => _SplashToDoScreenState();
}

class _SplashToDoScreenState extends State<SplashToDoScreen> {

  @override
  void initState() {
    navigateToListScreen();
    super.initState();
  }
  navigateToListScreen(){
    Future.delayed(Duration(seconds: 5), () {
      print(Duration);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TodoDashboard()),
      );
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.baseWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "images/todo.gif",
              height: 125.0,
              width: 125.0,

            ),
            Text("Daily To Do App",
                style: GoogleFonts.sigmar(
                    color: Colors.black,
                    fontSize: 21
                )
            ),
          ],
        ),
      ),
    );
  }
}
