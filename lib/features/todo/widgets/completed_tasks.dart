import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo/common/models/task_model.dart';
// import 'package:todo/common/utils/constants.dart';
import 'package:todo/features/todo/controllers/todo_provider.dart';
import 'package:todo/features/todo/widgets/todo_tile.dart';

class CompletedTask extends ConsumerWidget {
  const CompletedTask({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TaskModel> listData = ref.watch(todoStateProvider);
    List lastMonth = ref.read(todoStateProvider.notifier).last30Days();
    var completedList = listData
        .where(
          (element) =>
              element.isCompleted == 1 ||
              lastMonth.contains(
                element.date.substring(0, 10),
              ),
        )
        .toList();

    return ListView.builder(
      itemCount: completedList.length,
      itemBuilder: (context, index) {
        final data = completedList[index];
        bool isCompleted = ref.read(todoStateProvider.notifier).getStatus(data);
        dynamic color = ref.read(todoStateProvider.notifier).getRandomColor();
        return TodoTile(
          delete: () {
            ref.read(todoStateProvider.notifier).deleteTodo(data.id ?? 0);
          },
          editWidget: const SizedBox.shrink(),
          title: data.title,
          description: data.description,
          start: data.startTime,
          end: data.endTime,
          color: color,
          switcher: Switch(
            value: isCompleted,
            onChanged: (value) {
              ref.read(todoStateProvider.notifier).markAsNotCompleted(
                    data.id ?? 0,
                    data.title,
                    data.description,
                    data.date,
                    data.startTime!,
                    data.endTime!,
                  );
            },
          ),
          // switcher: const Icon(
          //   MaterialCommunityIcons.check_circle,
          //   size: 30,
          // ),
        );
      },
    );
  }
}
