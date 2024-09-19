import 'package:flutter/material.dart';
import 'package:link3app/core/constants/app_colors.dart';
import 'package:link3app/core/constants/app_sizes.dart';
import 'package:link3app/data_model/item_data.dart';
import 'package:link3app/data_model/task_list_data.dart';

class TaskDetailScreen extends StatefulWidget {
  final ItemData taskList;
  final int index;
  final Function(int) onDelete;

  TaskDetailScreen({required this.taskList, required this.index, required this.onDelete});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  bool showDelete =true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: Text(widget.taskList.title ?? "Task"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text("Remind Me",
              style: TextStyle(
                color: AppColors.iconColors
              ),
              ),
              leading: Icon(Icons.notifications_none,
                color: AppColors.iconColors,),
              onTap: () {
                // Add remind me functionality
              },
            ),
            ListTile(
              title: Text("Due Date",
                style: TextStyle(
                    color: AppColors.primaryBlue
                ),
              ),
              leading: Icon(Icons.calendar_today,
                color: AppColors.primaryBlue,
              ),
              subtitle: Text("Due Fri, 14 Sep",
                style: TextStyle(
                    color: AppColors.primaryBlue
                ),
              ), // Placeholder
              onTap: () {
                // Add due date picker functionality
              },
            ),
            ListTile(
              title: Text("Add Note",
                style: TextStyle(
                    color: AppColors.iconColors
                ),
              ),
              leading: Icon(Icons.note_add,
                color: AppColors.iconColors,
              ),
              onTap: () {
                // Add note functionality
              },
            ),
            Spacer(),
            Visibility(
              visible: showDelete,
              child: Padding(
                padding:  EdgeInsets.only(bottom: AppSizes.padDefaultMicro),
                child: ListTile(
                  title: Text("Delete",
                    style: TextStyle(
                        color: AppColors.iconColors
                    ),
                  ),
                  leading: Icon(Icons.delete_forever,
                    color: AppColors.redColor,
                  ),
                  onTap: () {
                   showDelete= false;
                   setState(() {
                   });
                  },
                ),
              ),
            ),

            Visibility(
              visible: showDelete==false,
              child: Padding(
                padding:  EdgeInsets.all(AppSizes.padDefaultMicro),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.baseWhite,
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(AppSizes.padDefaultMicro))
                    ),
                    onPressed: (){
                      widget.onDelete(widget.index);  // Call delete function
                      Navigator.pop(context);  //
                    },
                    child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(AppSizes.padDefaultMicro),
                      child: Text(
                        "\"${widget.taskList.title}\" will be permanently deleted.",
                        style: TextStyle(color: AppColors.deleteTxtColor),
                      ),
                    ),
                 Divider(
                   height: 0,
                 ),
                    Padding(
                      padding:  EdgeInsets.all(AppSizes.padDefaultMicro),
                      child: Text("Delete Task",
                        style: TextStyle(
                            color: AppColors.redColor
                        ),
                      ),
                    ),

                  ],
                )),
              ),
            ),
            Visibility(
              visible: showDelete==false,
              child: Padding(
                padding:  EdgeInsets.all(AppSizes.padDefaultMicro),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.baseWhite,
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(AppSizes.padDefaultMicro))
                      ),
                      onPressed: (){
                        showDelete= true;
                        setState(() {
                        });
                      },
                      child: Padding(
                        padding:  EdgeInsets.all(AppSizes.padDefaultMicro),
                        child: Text("Cancel",
                          style: TextStyle(
                              color: AppColors.primaryBlue
                          ),
                        ),
                      ),),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}