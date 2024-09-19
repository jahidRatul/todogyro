
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:link3app/core/constants/app_colors.dart';
import 'package:link3app/core/constants/app_sizes.dart';
import 'package:link3app/data_model/task_list_data.dart';
import 'package:link3app/task_list_screen.dart';



class TodoDashboard extends StatefulWidget {
  @override
  _TodoDashboardState createState() => _TodoDashboardState();
}

class _TodoDashboardState extends State<TodoDashboard> {

  final _ctrlTaskListName = TextEditingController();
  List <TaskListData> allTaskList=[];

  Future<void> _saveTaskLists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert the list of TaskListData to JSON string
    List<String> jsonData =
    allTaskList.map((taskList) => json.encode(taskList.toJson())).toList();

    // Save JSON string in SharedPreferences
    prefs.setStringList('taskLists', jsonData);
  }
  Future<void> _loadTaskLists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the JSON string from SharedPreferences

    List<String>? jsonData = prefs.getStringList('taskLists');

    if (jsonData != null) {
      setState(() {
        // Convert JSON string back to TaskListData objects

        allTaskList = jsonData
            .map((taskList) => TaskListData.fromJson(json.decode(taskList)))
            .toList();
      });
    }
    for(final items in allTaskList){


    }
  }

  @override
  void initState() {
    super.initState();
    _loadTaskLists();
  }


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
              showDialog(
                  context: context,
                  builder: (context)=>AlertDialog(
                    title: Text('Add a Task List'),
                    content: TextField(
                      controller: _ctrlTaskListName,
                      textCapitalization: TextCapitalization.sentences,

                    ),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.baseDark
                        ),
                          onPressed: (){
                            _ctrlTaskListName.clear();
                            Navigator.pop(context);
                          },
                          child: Text("Cancel",
                            style: TextStyle(
                              color: AppColors.baseWhite
                            ),
                          )
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlue
                          ),
                          onPressed: (){
                            allTaskList.add(TaskListData(name: _ctrlTaskListName.text,)); // Add new empty task list
                            _saveTaskLists();
                            setState(() {
                            });
                            _ctrlTaskListName.clear();
                            Navigator.pop(context);
                          },
                          child: Text("Submit",
                            style: TextStyle(
                                color: AppColors.baseWhite
                            ),
                          )
                      ),

                    ],
                  )
              );
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
              itemCount:allTaskList?.length??0,
                itemBuilder: (BuildContext context, index){
                  return ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.padDefaultMicro),
                    ),
                    leading: Icon(
                      Icons.list,color: AppColors.primaryBlue,size: AppSizes.padDefault,
                    ),
                    tileColor: AppColors.baseWhite,
                    title: Text(allTaskList[index].name??""),
                    textColor: AppColors.subTextColor,
                    titleTextStyle:TextStyle(fontSize: AppSizes.szFontLabel) ,
                    // trailing: Text(
                    //   '${allTaskList[index].name ?? 0}',  // Show the number of tasks
                    //   style: TextStyle(color: AppColors.primaryBlue, fontSize: AppSizes.szFontLabel),
                    // ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskListScreen(taskListData: allTaskList[index],)));
                    },

                  );
                }
            )
          ],
        ),
      ),
    );
  }
}


