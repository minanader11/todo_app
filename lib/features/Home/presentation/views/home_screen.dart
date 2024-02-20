import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_config_provider.dart';
import 'package:todo_app/core/myTheme.dart';
import 'package:todo_app/core/show_modal_sheet.dart';
import 'package:todo_app/features/Home/presentation/manager/task_provider.dart';
import 'package:todo_app/features/Home/presentation/views/modal_sheet.dart';
import 'package:todo_app/features/Home/presentation/views/todo_tab.dart';
import 'package:todo_app/features/Home/presentation/views/widgets/task_list_item.dart';
import 'package:todo_app/features/settings/presentaion/views/settings_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedItem = 0;
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<TaskProvider>(context);
    var configProvider = Provider.of<AppConfigProvider>(context);
    List<Widget> tabs = [
      TodoTab(),
      SettingsTab(),

    ];
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.app_title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await showModalSheet(context).then((value) {
                // if(taskProvider.date.day==DateTime.now().day&&taskProvider.calendarDate.day==DateTime.now().day){
                taskProvider.filteringTasks(taskProvider.calendarDate);

                //}
                setState(() {});
              });
            },
            child: Icon(
              Icons.add,
              color: MyTheme.whiteColor,
            )),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: configProvider.themeMode == ThemeMode.light
              ? MyTheme.whiteColor
              : MyTheme.blackColor,
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          child: Wrap(children: [
            BottomNavigationBar(
                onTap: (value) {
                  selectedItem = value;
                  taskProvider.filteringTasks(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
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
                      label: ''),
                ]),
          ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: tabs[selectedItem]);
  }
}
