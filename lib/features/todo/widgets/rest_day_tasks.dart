import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo/common/models/task_model.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/expnsion_tile.dart';
import 'package:todo/features/todo/controllers/expansion_provider.dart';
import 'package:todo/features/todo/controllers/todo_provider.dart';
import 'package:todo/features/todo/screens/update_task.dart';
import 'package:todo/features/todo/widgets/todo_tile.dart';

class RemainingTaskList extends ConsumerWidget {
  const RemainingTaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TaskModel> listData = ref.watch(todoStateProvider);
    var color = ref.read(todoStateProvider.notifier).getRandomColor();
    String overmorrow = ref.read(todoStateProvider.notifier).getOvermorrow();
    String tomorrow = ref.read(todoStateProvider.notifier).getTomorrow();
    String today = ref.read(todoStateProvider.notifier).getToday();

    var filteredList = listData
        .where((element) =>
            !element.date.contains(today) &&
            !element.date.contains(tomorrow) &&
            !element.date.contains(overmorrow))
        .toList();
    if (filteredList.length >= 2) {
      filteredList.sort((a, b) {
        // First, compare dates
        int dateComparison = a.date.compareTo(b.date);
        if (dateComparison != 0) {
          return dateComparison;
        }
        // If dates are equal, compare start times
        return a.startTime!.compareTo(b.startTime!);
      });
    }

    return CustomExpansionTile(
      text: 'Beyond',
      text2: "Rest of the task are shown here",
      onExpansionChanged: (bool expanded) {
        ref.read(expansionState1Provider.notifier).setStart(!expanded);
      },
      trailing: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: ref.watch(expansionState1Provider)
            ? const Icon(
                AntDesign.circledown,
                color: AppConstants.kLight,
              )
            : const Icon(
                AntDesign.closecircle,
                color: AppConstants.kBlueLight,
              ),
      ),
      children: [
        for (final todo in filteredList)
          TodoTile(
            title: todo.title,
            description: todo.description,
            start: todo.startTime,
            end: todo.endTime,
            color: color,
            switcher: const SizedBox.shrink(),
            editWidget: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UpdateTaskScreen(
                      id: todo.id ?? 0,
                      title: todo.title,
                      description: todo.description,
                    ),
                  ),
                );
              },
              child: const Icon(MaterialCommunityIcons.circle_edit_outline),
            ),
            delete: () {
              ref.read(todoStateProvider.notifier).deleteTodo(todo.id ?? 0);
            },
          ),
      ],
    );
  }
}
