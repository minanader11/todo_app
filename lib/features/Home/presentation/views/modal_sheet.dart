import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_config_provider.dart';
import 'package:todo_app/core/myTheme.dart';
import 'package:todo_app/core/show_date_picker.dart';
import 'package:todo_app/features/Home/data/task_model.dart';
import 'package:todo_app/features/Home/presentation/manager/task_provider.dart';
import 'package:todo_app/features/Home/presentation/views/home_screen.dart';

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
    void validateForm() {
      bool validate = _formKey.currentState!.validate();
      if (validate) {
        _formKey.currentState!.save();
        taskProvider.tasks.add(Task(
            taskDate: selectedDate,
            taskName: taskName,
            taskDescription: taskDescription));
        taskProvider.date = selectedDate;
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
          children: [
            const Text('Add a New Task'),
            TextFormField(
              onSaved: (newValue) => taskName = newValue!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                  hintText: 'Enter Your Task',
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
                  hintText: 'Enter Your description',
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
           const  Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Time',
                )),
            TextButton(
              style: TextButton.styleFrom(
                  primary: configProvider.themeMode == ThemeMode.light
                      ? MyTheme.dateColor
                      : MyTheme.whiteColor),
              onPressed: () async {
                selectedDate = await selectDate(context);
                setState(() {});
              },
              child: Text(
                format.format(selectedDate).toString(),
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            IconButton(
              onPressed: () {
                validateForm();
                Navigator.of(context).pop();
                //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen(),));
              },
              icon: const Icon(
                Icons.check,
                color: MyTheme.whiteColor,
              ),
              style: IconButton.styleFrom(
                  backgroundColor: MyTheme.primaryColor, iconSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
