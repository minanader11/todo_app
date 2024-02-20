import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_config_provider.dart';
import 'package:todo_app/core/myTheme.dart';
import 'package:todo_app/core/show_modal_sheet.dart';
import 'package:todo_app/features/Home/presentation/manager/task_provider.dart';
import 'package:todo_app/features/Home/presentation/views/modal_sheet.dart';
import 'package:todo_app/features/Home/presentation/views/widgets/task_list_item.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedItem = 0;
  var selectedDate = DateTime.now();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<TaskProvider>(context);
    var configProvider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'To Do List',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async{
           await showModalSheet(context).then((value) {
             if(taskProvider.date.day==DateTime.now().day){
               taskProvider.filteringTasks(taskProvider.date);
             }
             setState(() {

             });
           });
            
          },
          child: Icon(
            Icons.add,
            color: MyTheme.whiteColor,
          )),
      bottomNavigationBar: BottomAppBar(
        color: configProvider.themeMode==ThemeMode.light?MyTheme.whiteColor:MyTheme.blackColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Wrap(children: [
          BottomNavigationBar(
              onTap: (value) {
                selectedItem = value;
                setState(() {});
              },
              currentIndex: selectedItem,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.list,
                      size: 35,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings,
                      size: 35,
                    ),
                    label: '')
              ]),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Consumer<TaskProvider>(builder: (context, value, child) =>
         Column(
          children: [
            EasyDateTimeLine(
              initialDate: selectedDate,
              onDateChange: (selectedDate) {
                taskProvider.filteringTasks(selectedDate);
              },
              headerProps:  EasyHeaderProps(

                monthPickerType: MonthPickerType.switcher,
                selectedDateStyle: Theme.of(context).textTheme.bodyMedium,
                monthStyle:Theme.of(context).textTheme.bodyMedium ,
                dateFormatter: DateFormatter.fullDateDMY(),
              ),
              dayProps: EasyDayProps(
                todayStyle: DayStyle(
                    decoration: BoxDecoration(
                        color: MyTheme.whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(8)))),
                inactiveDayStyle: DayStyle(
                    decoration: BoxDecoration(
                        color: MyTheme.whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(8)))),
                dayStructure: DayStructure.dayStrDayNum,
                activeDayStyle: DayStyle(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff3371FF),
                        Color(0xff8426D6),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            value.filteredTasks.isEmpty
                ? Expanded(child: Center(child: Text('No Tasks ')))
                : Expanded(
                    child: ListView.builder(
                    itemCount: value.filteredTasks.length,
                    itemBuilder: (context, index) =>
                        TaskListITem(task: value.filteredTasks[index]),
                  )),
          ],
        ),
      ),
    );
  }
}
