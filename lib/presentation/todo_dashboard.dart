
import 'dart:convert';
import 'package:link3app/data_model/item_data.dart';
import 'package:link3app/presentation/task_list_screen.dart';
import 'package:link3app/widgets/snack_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:link3app/core/constants/app_colors.dart';
import 'package:link3app/core/constants/app_sizes.dart';
import 'package:link3app/data_model/task_list_data.dart';




class TodoDashboard extends StatefulWidget {
  @override
  _TodoDashboardState createState() => _TodoDashboardState();
}

class _TodoDashboardState extends State<TodoDashboard> {

  final _ctrlTaskListName = TextEditingController();
  List <TaskListData> allTaskList=[];
  List<ItemData> itemDataList = [];
  List<int> counterArray = [];

  int totalComplete=0;
  int totalIncomplete=0;
  DateTime today = DateTime.now();

  Future<void> _saveTaskLists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonData =
    allTaskList.map((taskList) => json.encode(taskList.toJson())).toList();
    prefs.setStringList('taskLists', jsonData);
  }
  Future<void> _loadTaskLists() async {
    totalComplete=0;
    totalIncomplete=0;
     counterArray = [];



    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonData = prefs.getStringList('taskLists');
    if (jsonData != null) {
      setState(() {
        allTaskList = jsonData
            .map((taskList) => TaskListData.fromJson(json.decode(taskList)))
            .toList();
      });
      allTaskList.forEach((taskList) {
        _loadTaskData(taskList.name);

        print("Task List: ${taskList.name}}");
      });
    }


  }
  Future<void> _loadTaskData(String? name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonData = prefs.getStringList(name??'');
    if (jsonData != null) {
      setState(() {
        itemDataList = jsonData.map((task) => ItemData.fromJson(json.decode(task))).toList();
        int countItemLoop =0;
        if(itemDataList.isNotEmpty){
          itemDataList.forEach((item){
            countItemLoop=countItemLoop+1;
            print("item List: ${item.title}, Items: ${item.time}");

            if(item.checked==true){
              totalComplete=totalComplete+1;
            }
            if(item.checked==null||item.checked==false){
              totalIncomplete=totalIncomplete+1;
            }
            if(item.time!=null && _isSameDate(item.time, today)){

              _showDueDateAlert(item.title??"");
            }
          });
          counterArray.add(countItemLoop);
        }
      });
    }
    else{
      counterArray.add(0);
    }
  }

  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void _showDueDateAlert(String taskName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Task Due Today"),
          content: Text("The task \"$taskName\" is due today."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                            if(_ctrlTaskListName.text.trim().isNotEmpty){
                              allTaskList.add(TaskListData(name: _ctrlTaskListName.text,));
                              _saveTaskLists();
                              _loadTaskLists();
                              setState(() {
                              });
                              _ctrlTaskListName.clear();
                              Navigator.pop(context);
                            }
                            else{
                              getSnackBar(context: context,text: "Input Task List");

                            }
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
                subtitle: Text("$totalIncomplete Incomplete, $totalComplete completed",
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
            Expanded(
              child: ListView.separated(
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
                      trailing: Text("(${counterArray[index]})"),
                      tileColor: AppColors.baseWhite,
                      title: Text(allTaskList[index].name??""),
                      textColor: AppColors.subTextColor,
                      titleTextStyle:TextStyle(fontSize: AppSizes.szFontLabel) ,

                      onTap: ()async{
                       await Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskListScreen(taskListData: allTaskList[index],))).then((val){
                         _loadTaskLists();
                       });
                      },
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}


