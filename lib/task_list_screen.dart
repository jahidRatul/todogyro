import 'package:flutter/material.dart';
import 'package:link3app/core/constants/app_colors.dart';
import 'package:link3app/core/constants/app_sizes.dart';

import 'data_model/task_list_data.dart';

class TaskListScreen extends StatefulWidget {
  TaskListScreen({required this.taskListData, super.key});
  TaskListData? taskListData;

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  TextEditingController _ctrlTaskName = TextEditingController();



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
            onPressed: (){
              showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom, // Adjusts for the keyboard
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:  EdgeInsets.all(AppSizes.padDefaultMicro),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: [
                                Checkbox(
                                    value: false,
                                    onChanged: (val){},
                                  side: BorderSide(color: AppColors.checkBoxColor,width: 2),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _ctrlTaskName,
                                    textCapitalization: TextCapitalization.sentences,

                                    decoration: InputDecoration(
                                      border: InputBorder.none,

                                      hintText: 'Add a task',
                                      hintStyle: TextStyle(
                                        color: AppColors.addTaskTxtInputColor

                                      )
                                    ),
                                  ),
                                  ),

                                IconButton(onPressed: (){},
                                    icon: Icon(Icons.check_circle,
                                        color: _ctrlTaskName.text.trim().isNotEmpty ?AppColors.primaryBlue:AppColors.disableColor,
                                    ))
                              ],
                            ),
                            Row(
                              children: [
                              Icon(Icons.notifications,
                                color: AppColors.iconColors,
                              ),
                                SizedBox(width: AppSizes.padDefaultMicro,),
                                Icon(Icons.sticky_note_2_rounded,
                                color: AppColors.iconColors,
                              ),
                                SizedBox(width: AppSizes.padDefaultMicro,),
                                IconButton(
                                  onPressed: (){

                                  },
                                  icon: Icon(Icons.calendar_month,
                                  color: AppColors.iconColors,
                                ),)



                            ],)
                          ],
                        ),
                      ),
                    ),
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
                "${widget.taskListData?.name} (1)" ,
                style: TextStyle(
                  fontSize: AppSizes.szFontTitle,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: AppSizes.padDefaultMicro),


              ListTile(contentPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.padDefaultMicro),
                ),
                leading: Checkbox(
                  value: true,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (val){}
                  ,
                ),
                tileColor: AppColors.baseWhite,dense: true,
                title: Text("fazar"),
                subtitle: Text("friday 20,2024",
                  style: TextStyle(

                    color: AppColors.dateColor
                  ),
                ),
                textColor: AppColors.subTextColor,
                titleTextStyle:TextStyle(fontSize: AppSizes.szFontLabel) ,
                trailing: Padding(
                  padding:  EdgeInsets.only(right: AppSizes.padDefaultMicro),
                  child: Icon(Icons.star_border_outlined,),
                ),
                onTap: (){},

              ),

            ],
          ),
        ),
      ),
    );
  }
}
