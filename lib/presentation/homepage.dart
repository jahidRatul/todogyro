import 'package:flutter/material.dart';
import 'package:link3app/core/constants/app_sizes.dart';
import 'package:link3app/presentation/splash_to_do_screen.dart';
import 'sensor_home_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //#region sizing
    if(AppSizes.scrX==10){
      //Phone or Tab
      final data = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.single);
      AppSizes.isTab= data.size.shortestSide > 600;
      //Sizes
      Size screenSize = MediaQuery.of(context).size;
      double width = screenSize.width;
      double height = screenSize.height;
      print("scrX: ${screenSize.width}, scrY: ${screenSize.height}");
      AppSizes.updateSizes(width: width, height: height);
    }
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(AppSizes.padDefault),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
      
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff36E0E0),
                            padding: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppSizes.padDefaultMicro)
                            )
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  SplashToDoScreen()));
      
                        },
                        child: Text("A To-DoList",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 21
                            )
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff3F69FF),
                            padding: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSizes.padDefaultMicro)
                            )
      
                        ),
                        onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  SensorHomePage()),
                          );
                        },
                        child: Text("Sensor Tracking",
                            style: TextStyle(
                                color: Colors.white,
                              fontSize: 21
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
