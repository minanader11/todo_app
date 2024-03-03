import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_config_provider.dart';
import 'package:todo_app/core/firebaseUtils.dart';
import 'package:todo_app/core/myTheme.dart';
import 'package:todo_app/core/show_modal_sheet.dart';
import 'package:todo_app/features/Home/data/task_model.dart';
import 'package:todo_app/features/Home/presentation/manager/auth_provider.dart';
import 'package:todo_app/features/Home/presentation/manager/task_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/features/Home/presentation/views/edit_sheet.dart';

class TaskListITem extends StatelessWidget {
  TaskListITem({super.key,required this.task});
  Task task;
  @override
  Widget build(BuildContext context) {
    var configProvider = Provider.of<AppConfigProvider>(context);
    void doNothing(BuildContext context) {}
    var format = DateFormat.yMd();
    var dateString = format.format(DateTime.now());
    var taskProvider=Provider.of<TaskProvider>(context);
    var authProvider=Provider.of<AuthProviders>(context);
    return InkWell(
      onTap: ()async{
        return await showModalSheet(context, EditSheet(task: task,));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                onPressed: (context){
                taskProvider.filteredTasks.remove(task);
                taskProvider.tasks.remove(task);
                taskProvider.deleteTask(task,authProvider.user!.id);
                },
                backgroundColor: MyTheme.redColor,
                foregroundColor: MyTheme.whiteColor,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: configProvider.themeMode==ThemeMode.light?MyTheme.whiteColor:MyTheme.blackColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin:
                      EdgeInsets.only(left: 17, right: 5, top: 27, bottom: 27),
                  color:task.taskStatus! ?MyTheme.greenColor :MyTheme.primaryColor,
                  width: 3,
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.taskName??'',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: task.taskStatus! ?MyTheme.greenColor :MyTheme.primaryColor),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 20,
                            color: configProvider.themeMode==ThemeMode.light?MyTheme.blackColor:MyTheme.whiteColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            format.format(task.taskDate ?? DateTime.now()),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    task.taskStatus= !task.taskStatus!;
                    taskProvider.notifyListeners();
                  },
                  child: task.taskStatus! ?Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                    child: Text(AppLocalizations.of(context)!.done,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: MyTheme.greenColor),),
                  ): Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: MyTheme.primaryColor),
                    child:Icon(
                      Icons.check,
                      color: MyTheme.whiteColor,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
