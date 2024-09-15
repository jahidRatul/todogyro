import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:link3app/core/constants/app_colors.dart';
import 'package:link3app/core/constants/app_sizes.dart';
import 'package:link3app/task_list_screen.dart';

class TodoDashboard extends StatefulWidget {
  @override
  _TodoDashboardState createState() => _TodoDashboardState();
}

class _TodoDashboardState extends State<TodoDashboard> {
  final _taskController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        floatingActionButton: FloatingActionButton(

          backgroundColor:  AppColors.primaryBlue,
          shape: const CircleBorder(),
            child:  Icon(Icons.add,
                color: AppColors.baseWhite,
                size: 28),

            onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskListScreen()));

            }
        ),
        
        body:Column(
          children: [
            Container(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage("https://picsum.photos/200"),
                  radius: AppSizes.padDefaultMin,
                ),
                title: Text("Zobayed Ahmed",
                  style: TextStyle(
                    fontSize: AppSizes.szFontTitle,
                    fontWeight: FontWeight.w500,

                  ),
                ),
                subtitle: Text("5 Completed, 5 Uncompleted",
                  style: TextStyle(
                    fontSize: AppSizes.szFontNormalText,
                    color: AppColors.subTextColor
                  ),
                ),
                trailing: Icon(
                  Icons.search,
                  size: AppSizes.padDefault*.8,

                ),
              ),
            ),
            Divider(),
            ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: AppSizes.padDefaultMicro);
                },
              shrinkWrap: true,
              padding: EdgeInsets.all(AppSizes.padDefaultMicro),
              itemCount: 2,
                itemBuilder: (BuildContext context, index){
                  return ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.padDefaultMicro),
                    ),
                    leading: Icon(
                      Icons.list,color: AppColors.primaryBlue,size: AppSizes.padDefault,
                    ),
                    tileColor: AppColors.baseWhite,
                    title: Text("List Name"),
                    textColor: AppColors.subTextColor,
                    titleTextStyle:TextStyle(fontSize: AppSizes.szFontLabel) ,
                    trailing: Text("1",
                    style: TextStyle(color: AppColors.primaryBlue,fontSize: AppSizes.szFontLabel),
                    ),

                  );
                }
            )
          ],
        ),
      ),
    );
  }
}

