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

class OvermorrowList extends ConsumerWidget {
  const OvermorrowList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TaskModel> listData = ref.watch(todoStateProvider);
    String overmorrow = ref.read(todoStateProvider.notifier).getOvermorrow();
    var color = ref.read(todoStateProvider.notifier).getRandomColor();
    var overmorrowList = listData
        .where((element) =>
            element.isCompleted == 0 && element.date.contains(overmorrow))
        .toList();
    return CustomExpansionTile(
      text: overmorrow.substring(5, 10),
      text2: "Tasks are shown here",
      onExpansionChanged: (bool expanded) {
        ref.read(expansionState0Provider.notifier).setStart(!expanded);
      },
      trailing: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: ref.watch(expansionState0Provider)
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
        for (final todo in overmorrowList)
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
