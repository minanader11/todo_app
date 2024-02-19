import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/myTheme.dart';

class TaskListITem extends StatelessWidget {
  const TaskListITem({super.key});

  @override
  Widget build(BuildContext context) {
    void doNothing(BuildContext context) {}
    var format = DateFormat.yMd();
    var dateString = format.format(DateTime.now());
    return Container(
      margin: EdgeInsets.all(10),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
              onPressed: doNothing,
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
            color: MyTheme.whiteColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: 17, right: 5, top: 27, bottom: 27),
                color: MyTheme.primaryColor,
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
                      'Play Basketball',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: MyTheme.primaryColor),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          size: 20,
                          color: MyTheme.blackColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          dateString,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: MyTheme.primaryColor),
                child: Icon(
                  Icons.check,
                  color: MyTheme.whiteColor,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
