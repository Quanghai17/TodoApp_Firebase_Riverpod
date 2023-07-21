import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_firebase/model/TodoModel.dart';
import 'package:todo_firebase/provider/DateTimeProvider.dart';
import 'package:todo_firebase/provider/RadioProvider.dart';
import 'package:todo_firebase/provider/ServiceProvider.dart';
import 'package:todo_firebase/widgets/DateTimeWidget.dart';
import 'package:todo_firebase/widgets/RadioWidget.dart';
import 'package:todo_firebase/widgets/TextFile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewTaskModel extends ConsumerWidget {
  AddNewTaskModel({
    super.key,
  });

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateProv = ref.watch(dateProvider);
    return Container(
      padding: EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.80,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
            width: double.infinity,
            child: Text(
              'New Task Todo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )),
        Divider(
          thickness: 1.5,
          color: Colors.grey.shade200,
        ),
        const Text(
          'Title task',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        const SizedBox(
          height: 6,
        ),
        TextFileWidget(
          hintText: 'Add Task Name',
          maxLine: 1,
          txtController: titleController,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Description',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        const SizedBox(
          height: 6,
        ),
        TextFileWidget(
          hintText: 'Add Description',
          maxLine: 3,
          txtController: descriptionController,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Category',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        Row(
          children: [
            Expanded(
              child: RadioWidget(
                categColor: Colors.green,
                titleRadio: 'LRN',
                valueInput: 1,
                onChangeValue: () =>
                    ref.read(radioProvider.notifier).update((state) => 1),
              ),
            ),
            Expanded(
              child: RadioWidget(
                categColor: Colors.blue,
                titleRadio: 'WRK',
                valueInput: 2,
                onChangeValue: () =>
                    ref.read(radioProvider.notifier).update((state) => 2),
              ),
            ),
            Expanded(
              child: RadioWidget(
                categColor: Colors.amberAccent,
                titleRadio: 'GEN',
                valueInput: 3,
                onChangeValue: () =>
                    ref.read(radioProvider.notifier).update((state) => 3),
              ),
            ),
          ],
        ),

        //Date and time

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DateTimeWidget(
              titleText: 'Date',
              valueText: dateProv.toString(),
              iconSection: CupertinoIcons.calendar,
              onTap: () async {
                final getValue = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2025));

                if (getValue != null) {
                  final format = DateFormat.yMd();
                  ref
                      .read(dateProvider.notifier)
                      .update((state) => format.format(getValue));
                }
              },
            ),
            SizedBox(width: 22),
            DateTimeWidget(
              titleText: 'Time',
              valueText: ref.watch(timeProvider),
              iconSection: CupertinoIcons.clock,
              onTap: () async {
                final getTime = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());

                if (getTime != null) {
                  ref
                      .read(timeProvider.notifier)
                      .update((state) => getTime.format(context));
                }
              },
            )
          ],
        ),

        //Button Section
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue.shade800,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  side: BorderSide(color: Colors.blue)),
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            )),
            const SizedBox(
              width: 22,
            ),
            Expanded(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  side: BorderSide(color: Colors.blue)),
              onPressed: () {
                final getRadioValue = ref.read(radioProvider);
                String category = '';

                switch (getRadioValue) {
                  case 1:
                    category = 'Learning';
                    break;
                  case 2:
                    category = 'Working';
                    break;
                  case 3:
                    category = 'General';
                    break;
                }

                ref.read(serviceProvider).addNewTask(TodoModel(
                      titleTask: titleController.text,
                      description: descriptionController.text,
                      category: category,
                      dateTask: ref.read(dateProvider),
                      timeTask: ref.read(timeProvider),
                      isDone: false,
                    ));

                print('Data saving');

                titleController.clear();
                descriptionController.clear();
                ref.read(radioProvider.notifier).update((state) => 0);
                Navigator.pop(context);
              },
              child: const Text('Submit'),
            )),
          ],
        )
      ]),
    );
  }
}
