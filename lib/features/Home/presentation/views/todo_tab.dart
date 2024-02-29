import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_config_provider.dart';
import 'package:todo_app/core/myTheme.dart';
import 'package:todo_app/features/Home/presentation/manager/task_provider.dart';
import 'package:todo_app/features/Home/presentation/views/widgets/task_list_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class TodoTab extends StatefulWidget {
  const TodoTab({super.key});

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  @override
  Widget build(BuildContext context) {
    var selectedDate = DateTime.now();
    var taskProvider = Provider.of<TaskProvider>(context);
    var configProvider = Provider.of<AppConfigProvider>(context);
   if(taskProvider.tasks.isEmpty){
      taskProvider.getAllTasks();
      setState(() {

      });
    }
    return Column(
          children: [Stack(clipBehavior: Clip.none,children: [
            Container(color: MyTheme.primaryColor,height: MediaQuery.of(context).size.height*0.2,width:MediaQuery.of(context).size.width,child: Padding(
              padding:  EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height*0.06,horizontal: 20 ),
              child: Text(
                AppLocalizations.of(context)!.app_title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),),

            Padding(
              padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.08 ),
              child: EasyDateTimeLine(
                locale: configProvider.language,
                initialDate: DateTime.now(),
                onDateChange: (selectedDate) {
                  taskProvider.changeDate(selectedDate);
                  setState(() {

                  });
                },
                headerProps: EasyHeaderProps(
                  padding: EdgeInsets.zero,
                  monthPickerType: MonthPickerType.switcher,
                  selectedDateStyle: Theme.of(context).textTheme.bodyMedium,
                  monthStyle: Theme.of(context).textTheme.bodyMedium,
                  dateFormatter: const DateFormatter.fullDateDMY(),
                  showMonthPicker: true,
                  showSelectedDate: false,

                ),
                dayProps: EasyDayProps(
                  todayStyle: const  DayStyle(
                      decoration: BoxDecoration(
                          color: MyTheme.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                  inactiveDayStyle:const  DayStyle(
                      decoration: BoxDecoration(
                          color: MyTheme.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                  dayStructure: DayStructure.dayStrDayNumMonth,
                  activeDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          configProvider.themeMode == ThemeMode.light
                              ? MyTheme.backgroundColorDark
                              : MyTheme.backgroundColorLight,
                          MyTheme.primaryColor
                          // Color(0xff3371FF),
                          // Color(0xff8426D6),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],),

            taskProvider.tasks.isEmpty
                ?  Expanded(child: Center(child: Text(AppLocalizations.of(context)!.no_tasks)))
                : Expanded(
                    child: ListView.builder(
                    itemCount: taskProvider.tasks.length,
                    itemBuilder: (context, index) =>
                        TaskListITem(task: taskProvider.tasks[index]),
                  )),
          ],
      );

  }
}
