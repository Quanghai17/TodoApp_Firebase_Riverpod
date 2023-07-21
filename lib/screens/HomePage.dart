import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_firebase/components/AddNewTaskModel.dart';
import 'package:todo_firebase/provider/ServiceProvider.dart';
import 'package:todo_firebase/widgets/CardTodoListWidget.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.amber.shade300,
            radius: 25,
            child: Image.asset('assets/user.png'),
          ),
          title: Text(
            'Hello I\m',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade400,
            ),
          ),
          subtitle: const Text(
            'QuangHai17',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.calendar)),
                IconButton(
                    onPressed: () {}, icon: const Icon(CupertinoIcons.bell)),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today\'s Task',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      'Wednesday, 11 May',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    )
                  ],
                ),
                ElevatedButton(
                    onPressed: () => showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        context: context,
                        builder: (context) => AddNewTaskModel()),
                    child: Text('+New Task')),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //Card List Task
            ListView.builder(
              itemCount: todoData.value!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => CardTodoListWidget(
                getIndex: index,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
