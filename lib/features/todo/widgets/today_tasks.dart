import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo/common/models/task_model.dart';
import 'package:todo/features/todo/controllers/todo_provider.dart';
import 'package:todo/features/todo/screens/update_task.dart';
import 'package:todo/features/todo/widgets/todo_tile.dart';

class TodayTask extends ConsumerWidget {
  const TodayTask({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TaskModel> listData = ref.watch(todoStateProvider);
    String today = ref.read(todoStateProvider.notifier).getToday();
    var todayList = listData
        .where((element) =>
            element.isCompleted == 0 && element.date.contains(today))
        .toList();

    return ListView.builder(
      itemCount: todayList.length,
      itemBuilder: (context, index) {
        final data = todayList[index];
        bool isCompleted = ref.read(todoStateProvider.notifier).getStatus(data);
        dynamic color = ref.read(todoStateProvider.notifier).getRandomColor();
        return TodoTile(
          delete: () {
            ref.read(todoStateProvider.notifier).deleteTodo(data.id ?? 0);
          },
          editWidget: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UpdateTaskScreen(
                    id: data.id ?? 0,
                    title: data.title,
                    description: data.description,
                  ),
                ),
              );
            },
            child: const Icon(MaterialCommunityIcons.circle_edit_outline),
          ),
          title: data.title,
          description: data.description,
          start: data.startTime,
          end: data.endTime,
          color: color,
          switcher: Switch(
            value: isCompleted,
            onChanged: (value) {
              ref.read(todoStateProvider.notifier).markAsCompleted(
                    data.id ?? 0,
                    data.title,
                    data.description,
                    data.date,
                    data.startTime!,
                    data.endTime!,
                  );
            },
          ),
        );
      },
    );
  }
}
