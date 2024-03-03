import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_config_provider.dart';
import 'package:todo_app/core/firebaseUtils.dart';
import 'package:todo_app/core/myTheme.dart';
import 'package:todo_app/core/show_date_picker.dart';
import 'package:todo_app/features/Home/data/task_model.dart';
import 'package:todo_app/features/Home/presentation/manager/auth_provider.dart';
import 'package:todo_app/features/Home/presentation/manager/task_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ModalSheet extends StatefulWidget {
  const ModalSheet({super.key});

  @override
  State<ModalSheet> createState() => _ModalSheetState();
}

class _ModalSheetState extends State<ModalSheet> {
  final _formKey = GlobalKey<FormState>();
  var format = DateFormat.yMd();
  var selectedDate = DateTime.now();
  String taskName = '';
  String taskDescription = '';

  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<TaskProvider>(context);
    var configProvider = Provider.of<AppConfigProvider>(context);

    var authProvider=Provider.of<AuthProviders>(context);
    void validateForm() {
      bool validate = _formKey.currentState!.validate();
      if (validate) {
        _formKey.currentState!.save();
        Task task = Task(
            taskDate: selectedDate,
            taskName: taskName,
            taskDescription: taskDescription);
        FirebaseUtils.addTaskToFirestore(task,authProvider.user!.id).timeout(
          Duration(milliseconds: 500),
          onTimeout: () {},
        );
        //taskProvider.tasks.add(Task(
        //   taskDate: selectedDate,
        //   taskName: taskName,
        //   taskDescription: taskDescription));
        //   taskProvider.date = selectedDate;
      }
    }

    return Container(
      color: configProvider.themeMode == ThemeMode.light
          ? MyTheme.whiteColor
          : MyTheme.blackColor,
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.center,
                child: Text(AppLocalizations.of(context)!.add_a_new_task)),
            TextFormField(
              onSaved: (newValue) => taskName = newValue!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.enter_your_task,
                  hintStyle: Theme.of(context).textTheme.bodyMedium),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter your task ';
                }
              },
            ),
            TextFormField(
              onSaved: (newValue) => taskDescription = newValue!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(context)!.enter_your_description,
                  hintStyle: Theme.of(context).textTheme.bodyMedium),
              maxLines: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter task description';
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context)!.select_time,
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                style: TextButton.styleFrom(
                    primary: configProvider.themeMode == ThemeMode.light
                        ? MyTheme.dateColor
                        : MyTheme.whiteColor),
                onPressed: () async {
                  selectedDate = await selectDate(context);
                  setState(() {
                    print(selectedDate);
                  });
                },
                child: Text(
                  format.format(selectedDate).toString(),
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {
                  validateForm();
                  taskProvider.getAllTasks(authProvider.user!.id);

                  Navigator.of(context).pop();
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: MyTheme.primaryColor,
                        title: Text(
                          AppLocalizations.of(context)!.task_added_successfully,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: MyTheme.blackColor),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(
                                  '${taskName.toString()} ${AppLocalizations.of(context)!.is_added}'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              AppLocalizations.of(context)!.ok,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: MyTheme.greenColor),
                            ),
                            onPressed: () {
                              taskProvider.getAllTasks(authProvider.user!.id);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );

                  //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen(),));
                },
                icon: const Icon(
                  Icons.check,
                  color: MyTheme.whiteColor,
                ),
                style: IconButton.styleFrom(
                    backgroundColor: MyTheme.primaryColor, iconSize: 30),
              ),
            )
          ],
        ),
      ),
    );
  }
}
