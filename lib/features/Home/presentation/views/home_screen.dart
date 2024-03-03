import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_config_provider.dart';
import 'package:todo_app/core/myTheme.dart';
import 'package:todo_app/core/show_modal_sheet.dart';
import 'package:todo_app/features/Home/presentation/manager/auth_provider.dart';
import 'package:todo_app/features/Home/presentation/manager/task_provider.dart';
import 'package:todo_app/features/Home/presentation/views/modal_sheet.dart';
import 'package:todo_app/features/Home/presentation/views/todo_tab.dart';
import 'package:todo_app/features/settings/presentaion/views/settings_screen.dart';

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
    var authProvider=Provider.of<AuthProviders>(context);

    List<Widget> tabs = const [
      TodoTab(),
      SettingsTab(),
    ];
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await showModalSheet(context,const  ModalSheet()).then((value) {
                setState(() {});
              });
            },
            child: const Icon(
              Icons.add,
              color: MyTheme.whiteColor,
            )),
        bottomNavigationBar: BottomAppBar(
          padding: EdgeInsets.zero,
          elevation: 0,
          color: configProvider.themeMode == ThemeMode.light
              ? MyTheme.whiteColor
              : MyTheme.blackColor,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: BottomNavigationBar(
              onTap: (value) {
                selectedItem = value;
                taskProvider.getAllTasks(authProvider.user!.id);
                setState(() {});
              },
              currentIndex: selectedItem,
              items: const [
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: tabs[selectedItem]);
  }
}
