import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_config_provider.dart';
import 'package:todo_app/core/firebaseUtils.dart';
import 'package:todo_app/core/myTheme.dart';
import 'package:todo_app/core/show_date_picker.dart';
import 'package:todo_app/features/Home/data/task_model.dart';
import 'package:todo_app/features/Home/presentation/manager/task_provider.dart';

class EditSheet extends StatefulWidget {
   EditSheet({super.key,required this.task});
   Task task;

  @override
  State<EditSheet> createState() => _ModalSheetState();
}

class _ModalSheetState extends State<EditSheet> {
  final _formKey = GlobalKey<FormState>();
  var format = DateFormat.yMd();

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final configProvider = Provider.of<AppConfigProvider>(context);
    TextEditingController nameController= TextEditingController(text: widget.task.taskName);
    TextEditingController descriptionController= TextEditingController(text: widget.task.taskDescription);
    var selectedDate = widget.task.taskDate;
    void validateForm() {
      bool validate = _formKey.currentState!.validate();
      if (validate) {
        _formKey.currentState!.save();
         widget.task=Task(taskDate: selectedDate, taskName: nameController.text, taskDescription: descriptionController.text,id: widget.task.id);
       taskProvider.updateTask(widget.task);
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
          children: [
            const Text('Edit your Task'),
            TextFormField(
              controller: nameController,
              onSaved: (value) => nameController.text=value!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                  hintText: 'Edit your Task  Name',
                  hintStyle: Theme.of(context).textTheme.bodyMedium),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter your task ';
                }
              },
            ),
            TextFormField(
              controller: descriptionController,
              onSaved: (value) => descriptionController.text=value!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                  hintText: 'Edit Your description',
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
                  'Edit Time',
                )),
            TextButton(
              style: TextButton.styleFrom(
                  primary: configProvider.themeMode == ThemeMode.light
                      ? MyTheme.dateColor
                      : MyTheme.whiteColor),
              onPressed: () async {
                selectedDate = await selectDate(context);
                widget.task.taskDate=selectedDate;
                setState(() {});
              },
              child: Text(
                format.format(selectedDate!).toString(),
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            IconButton(
              onPressed: () {
                validateForm();
                taskProvider.getAllTasks();
                Navigator.of(context).pop();
                showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Task edited Successfully'),
                      content:  SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('${nameController.text} is edited'),

                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Ok!'),
                          onPressed: () {
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
            )
          ],
        ),
      ),
    );
  }
}
