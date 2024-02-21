import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_config_provider.dart';
import 'package:todo_app/core/myTheme.dart';
import 'package:todo_app/features/Home/presentation/manager/task_provider.dart';
import 'package:todo_app/features/Home/presentation/views/widgets/task_list_item.dart';

class TodoTab extends StatelessWidget {
  const TodoTab({super.key});

  @override
  Widget build(BuildContext context) {
    var selectedDate = DateTime.now();
    var taskProvider = Provider.of<TaskProvider>(context);
    var configProvider = Provider.of<AppConfigProvider>(context);
    return Consumer<TaskProvider>(
      builder: (context, value, child) => Column(
        children: [
          EasyDateTimeLine(
            locale: configProvider.language,
            initialDate: selectedDate,
            onDateChange: (selectedDate) {
              taskProvider.calendarDate = selectedDate;
              taskProvider.filteringTasks(selectedDate);
            },
            headerProps: EasyHeaderProps(
              monthPickerType: MonthPickerType.switcher,
              selectedDateStyle: Theme.of(context).textTheme.bodyMedium,
              monthStyle: Theme.of(context).textTheme.bodyMedium,
              dateFormatter: const DateFormatter.fullDateDMY(),
              showMonthPicker: false,
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
          value.filteredTasks.isEmpty
              ? const Expanded(child: Center(child: Text('No Tasks ')))
              : Expanded(
                  child: ListView.builder(
                  itemCount: value.filteredTasks.length,
                  itemBuilder: (context, index) =>
                      TaskListITem(task: value.filteredTasks[index]),
                )),
        ],
      ),
    );
  }
}
