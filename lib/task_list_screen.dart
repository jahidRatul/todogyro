import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:link3app/core/constants/app_colors.dart';
import 'package:link3app/core/constants/app_sizes.dart';
import 'package:link3app/data_model/item_data.dart';
import 'task_details_screen.dart';
import 'data_model/task_list_data.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskListScreen extends StatefulWidget {
  TaskListScreen({required this.taskListData, super.key});
  TaskListData? taskListData;

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  TextEditingController _ctrlTaskName = TextEditingController();
  DateTime? selectedDate;

  List<ItemData> itemDataList = [];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,useRootNavigator: false,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      confirmText: "Done",
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(

            colorScheme: ColorScheme.light(primary: AppColors.primaryBlue),
              datePickerTheme: DatePickerThemeData(
            weekdayStyle: TextStyle(
              color: AppColors.primaryBlue
            ),
            confirmButtonStyle: ButtonStyle(
              shape:WidgetStateProperty.all(RoundedRectangleBorder( borderRadius: BorderRadius.circular(AppSizes.padDefaultMicro*.5), )),
              backgroundColor: WidgetStatePropertyAll(AppColors.primaryBlue),
              foregroundColor:WidgetStatePropertyAll(AppColors.baseWhite),padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: AppSizes.padDefaultMin))
            ),
                cancelButtonStyle: ButtonStyle(
                    foregroundColor:WidgetStatePropertyAll(AppColors.baseDark),padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: AppSizes.padDefaultMin))

                )
          )
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void initState() {
    super.initState();
    _loadTaskData(); // Load data when the screen is initialized
  }

  Future<void> _saveTaskData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert the list of tasks to a JSON string
    List<String> jsonData = itemDataList.map((task) => json.encode(task.toJson())).toList();

    // Save the JSON string in SharedPreferences
    prefs.setStringList("${widget.taskListData?.name}", jsonData);
  }

  Future<void> _loadTaskData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the saved JSON data from SharedPreferences
    List<String>? jsonData = prefs.getStringList("${widget.taskListData?.name}");

    if (jsonData != null) {
      // Convert the JSON data back to ItemData objects
      setState(() {
        itemDataList = jsonData.map((task) => ItemData.fromJson(json.decode(task))).toList();
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold(
        backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("Lists"),
        titleTextStyle: TextStyle(
        fontSize: AppSizes.szFontLabel,
        fontWeight: FontWeight.w500,
          color: AppColors.baseDark
      ),
      ),
        floatingActionButton: SizedBox(
          width: AppSizes.scrX*.9,
          child: ElevatedButton(

            child: Row(
              children: [
                Container(
                  child: Icon(
                    Icons.add_circle_outlined,color: AppColors.primaryBlue,),
                ),
                SizedBox(width: AppSizes.padDefaultMicro),
                Text("Add a Task",
                  style: TextStyle(
                    color: AppColors.baseDark,
                  ),
                )
              ],
            ),
            onPressed: () {

              showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setModalState) {
                      return Container(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom, // Adjusts for the keyboard
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(AppSizes.padDefaultMicro),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Checkbox(
                                      value: false,
                                      onChanged: (val) {},
                                      side: BorderSide(color: AppColors.checkBoxColor, width: 2),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: _ctrlTaskName,
                                        textCapitalization: TextCapitalization.sentences,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Add a task',
                                          hintStyle: TextStyle(
                                            color: AppColors.addTaskTxtInputColor,
                                          ),
                                        ),
                                        onChanged: (val){
                                          setModalState(() {});
                                        },
                                      ),

                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if(_ctrlTaskName.text.trim().isNotEmpty){
                                          itemDataList.add(ItemData(time: selectedDate,title: _ctrlTaskName.text.trim()));
                                          _saveTaskData();
                                          setState(() {
                                          });
                                          setModalState(() {});
                                          selectedDate=null;
                                          _ctrlTaskName.clear();

                                        }
                                      },
                                      icon: Icon(
                                        Icons.check_circle,
                                        color: _ctrlTaskName.text.trim().isNotEmpty
                                            ? AppColors.primaryBlue
                                            : AppColors.disableColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.notifications,
                                      color: AppColors.iconColors,
                                    ),
                                    SizedBox(
                                      width: AppSizes.padDefaultMicro,
                                    ),
                                    Icon(
                                      Icons.sticky_note_2_rounded,
                                      color: AppColors.iconColors,
                                    ),

                                    IconButton(
                                      onPressed: () {
                                        _selectDate(context).then((_) {
                                          setModalState(() {});
                                        });
                                      },
                                      icon: Icon(
                                        Icons.calendar_month,
                                        color: selectedDate != null?AppColors.primaryBlue:AppColors.iconColors,
                                      ),
                                    ),
                                    Text(selectedDate != null
                                        ? DateFormat('EEE, dd MMM').format(selectedDate!) : "",
                                      style: TextStyle(
                                        color:AppColors.primaryBlue
                                      ),
                                    ),
                                    Spacer(),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
                                        onPressed: (){
                                          Navigator.pop(context);
                                        }, child: Text("Done",
                                      style: TextStyle(
                                        color: AppColors.baseWhite
                                      ),

                                    ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal:AppSizes.padDefaultMin,vertical: AppSizes.padDefaultMicro),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.taskListData?.name} (${itemDataList?.length??0})" ,
                style: TextStyle(
                  fontSize: AppSizes.szFontTitle,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: AppSizes.padDefaultMicro),
              ListView.separated(
                separatorBuilder: (BuildContext context, int index){
                  return  SizedBox(height: AppSizes.padDefaultMicro);
                },
                shrinkWrap: true,
                itemCount: itemDataList?.length??0,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(contentPadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.padDefaultMicro),
                    ),
                    leading: Checkbox(
                      value: itemDataList[index]?.checked??false,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onChanged: (val){
                        itemDataList[index]?.checked = val;
                        _saveTaskData();
                        setState(() {
                        });
                      }
                      ,
                    ),
                    tileColor: AppColors.baseWhite,dense: true,
                    title: Text(itemDataList[index].title??""),
                    subtitle: Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color:AppColors.iconColors,
                          size: AppSizes.padDefaultMicro,
                        ),
                        SizedBox(width: AppSizes.padDefaultMicro*.3,),
                        Text( itemDataList[index].time !=null? DateFormat('EEE, dd MMM').format(itemDataList[index].time) :"",
                          style: TextStyle(

                              color: AppColors.dateColor
                          ),
                        ),
                      ],
                    ),
                    textColor: AppColors.subTextColor,
                    titleTextStyle:TextStyle(fontSize: AppSizes.szFontLabel) ,
                    trailing: Padding(
                      padding:  EdgeInsets.only(right: AppSizes.padDefaultMicro),
                      child: Icon(Icons.star_border_outlined,),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailScreen(
                            taskList: itemDataList[index],
                            index: index,
                            onDelete: _deleteTaskList,
                          ),
                        ),
                      );
                    },

                  );
              },
              ),


            ],
          ),
        ),
      ),
    );
  }
  Future<void> _deleteTaskList(int index) async {
    setState(() {
      itemDataList.removeAt(index);
    });
    _saveTaskData();  // Update the saved data
  }
}
