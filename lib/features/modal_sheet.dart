import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/myTheme.dart';
import 'package:todo_app/core/show_date_picker.dart';

class ModalSheet extends StatefulWidget {
  const ModalSheet({super.key});

  @override
  State<ModalSheet> createState() => _ModalSheetState();
}

class _ModalSheetState extends State<ModalSheet> {
  final _formKey = GlobalKey<FormState>();
  var format = DateFormat.yMd();
  var selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text('Add a New Task'),
            TextFormField(
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: MyTheme.dateColor, fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                hintText: 'Enter Your Task',
              ),
            ),
            TextFormField(
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: MyTheme.dateColor, fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                hintText: 'Enter Your description',
              ),
              maxLines: 4,
            ),
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Time',
                )),
            TextButton(
                style: TextButton.styleFrom(primary: MyTheme.dateColor),
                onPressed: ()async {
                  selectedDate= await selectDate(context,selectedDate);
                  setState(() {

                  });
                },
                child: Text(format.format(selectedDate).toString()))
          ],
        ),
      ),
    );
  }
}
