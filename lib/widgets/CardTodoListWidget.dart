import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_firebase/provider/ServiceProvider.dart';

class CardTodoListWidget extends ConsumerWidget {
  const CardTodoListWidget({
    super.key,
    required this.getIndex,
  });

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
    return todoData.when(
        data: (todoData) {
          Color categoryColor = Colors.white;
          final getCategory = todoData[getIndex].category;
          switch (getCategory) {
            case 'Learning':
              categoryColor = Colors.green;
              break;

            case 'Working':
              categoryColor = Colors.blue;
              break;

            case 'General':
              categoryColor = Colors.amber;
              break;
          }
          return Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: categoryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  width: 20,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: IconButton(
                              icon: Icon(CupertinoIcons.delete),
                              onPressed: () => ref
                                  .read(serviceProvider)
                                  .deleteTask(todoData[getIndex].docID)),
                          title: Text(
                            todoData[getIndex].titleTask,
                            maxLines: 1,
                            style: TextStyle(
                                decoration: todoData[getIndex].isDone
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                          subtitle: Text(todoData[getIndex].description,
                              maxLines: 1,
                              style: TextStyle(
                                  decoration: todoData[getIndex].isDone
                                      ? TextDecoration.lineThrough
                                      : null)),
                          trailing: Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              activeColor: Colors.blue.shade700,
                              shape: CircleBorder(),
                              value: todoData[getIndex].isDone,
                              onChanged: (value) => ref
                                  .read(serviceProvider)
                                  .updateTask(todoData[getIndex].docID, value),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -12),
                          child: Container(
                            child: Column(children: [
                              Divider(
                                thickness: 1.5,
                                color: Colors.grey.shade200,
                              ),
                              Row(
                                children: [
                                  Text('Today'),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(todoData[getIndex].timeTask)
                                ],
                              )
                            ]),
                          ),
                        )
                      ]),
                ))
              ],
            ),
          );
        },
        error: (error, StackTrace) => Center(
              child: Text('Error'),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
