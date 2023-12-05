import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/helpers/notif_helper.dart';
import 'package:todo/common/models/task_model.dart';
import 'package:todo/common/routes/routes.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/custom_alert.dart';
import 'package:todo/common/widgets/custom_btn.dart';
import 'package:todo/common/widgets/custom_text.dart';
import 'package:todo/common/widgets/text_style.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:todo/features/todo/controllers/dates/dates_provider.dart';
import 'package:todo/features/todo/controllers/todo_provider.dart';

class AddTask extends ConsumerStatefulWidget {
  const AddTask({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<AddTask> {
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();
  late NotificationsHelper notifierHelper;
  late NotificationsHelper controller;
  List<int> notifdates = [];
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () {
      controller = NotificationsHelper(ref: ref);
    });
    notifierHelper = NotificationsHelper(ref: ref);
    notifierHelper.initializeNotifications();

    super.initState();
  }

  @override
  void dispose() {
    title.dispose();
    desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scheduleDate = ref.watch(dateStateProvider);
    var start = ref.watch(startTimeStateProvider);
    var finish = ref.watch(finishTimeStateProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            SizedBox(height: 20.h),
            CustomTextField(
              hintText: 'Add title',
              controller: title,
              hintStyle: appstyle(
                16,
                AppConstants.kGreyLight,
                FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              hintText: 'Description',
              controller: desc,
              hintStyle: appstyle(
                16,
                AppConstants.kGreyLight,
                FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            CustomBtn(
              onTap: () {
                picker.DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    maxTime: DateTime.now().add(
                      const Duration(days: 365),
                    ),
                    theme: const picker.DatePickerTheme(
                      doneStyle:
                          TextStyle(color: AppConstants.kGreen, fontSize: 16),
                    ), onConfirm: (date) {
                  ref.read(dateStateProvider.notifier).setDate(date.toString());
                  notifdates =
                      ref.read(startTimeStateProvider.notifier).dates(date);
                }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
              },
              height: 52.h,
              width: AppConstants.kWidth,
              boxDecoColor: AppConstants.kBlueLight,
              borderColor: AppConstants.kLight,
              text: scheduleDate == ''
                  ? 'Set Date'
                  : scheduleDate.toString().substring(0, 10),
              textStyleColor: AppConstants.kLight,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBtn(
                  onTap: () {
                    picker.DatePicker.showTimePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (date) {
                        ref.read(startTimeStateProvider.notifier).setStart(
                              date.toString(),
                            );
                      },
                      currentTime: DateTime.now(),
                      showSecondsColumn: false,
                    );
                  },
                  height: 52.h,
                  width: AppConstants.kWidth * 0.4,
                  boxDecoColor: AppConstants.kBlueLight,
                  borderColor: AppConstants.kLight,
                  text: start == "" ? 'Start Time' : start.substring(10, 16),
                  textStyleColor: AppConstants.kLight,
                ),
                CustomBtn(
                  onTap: () {
                    picker.DatePicker.showTimePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (date) {
                        ref.read(finishTimeStateProvider.notifier).setFinsh(
                              date.toString(),
                            );
                      },
                      currentTime: ref.read(startTimeStateProvider) == ''
                          ? DateTime.now().add(
                              const Duration(hours: 6),
                            )
                          : DateTime.parse(ref.read(startTimeStateProvider)),
                      showSecondsColumn: false,
                    );
                  },
                  height: 52.h,
                  width: AppConstants.kWidth * 0.4,
                  boxDecoColor: AppConstants.kBlueLight,
                  borderColor: AppConstants.kLight,
                  text: finish == "" ? 'End Time' : finish.substring(10, 16),
                  textStyleColor: AppConstants.kLight,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            CustomBtn(
              onTap: () {
                if (title.text.isNotEmpty &&
                    desc.text.isNotEmpty &&
                    scheduleDate.isNotEmpty &&
                    start.isNotEmpty &&
                    finish.isNotEmpty &&
                    double.parse(finish.substring(11, 13)) >
                        double.parse(start.substring(11, 13))) {
                  TaskModel task = TaskModel(
                    title: title.text,
                    description: desc.text,
                    isCompleted: 0,
                    date: scheduleDate.substring(0, 10),
                    endTime: finish.substring(11, 16),
                    startTime: start.substring(11, 16),
                    repeat: "yes",
                  );
                  // print(task.toMap().toString());
                  notifierHelper.scheduledNotification(
                    notifdates[0],
                    notifdates[1],
                    notifdates[2],
                    notifdates[3],
                    task,
                  );
                  ref.read(todoStateProvider.notifier).addItem(task);
                  ref.read(startTimeStateProvider.notifier).setStart('');
                  ref.read(finishTimeStateProvider.notifier).setFinsh('');
                  ref.read(dateStateProvider.notifier).setDate('');
                  Navigator.of(context).pushNamed(Routes.home);
                } else {
                  showAlertDialog(
                    context: context,
                    message: 'Failed to add task',
                    btmText: 'Go back',
                  );
                }
              },
              height: 52.h,
              width: AppConstants.kWidth * 0.4,
              boxDecoColor: AppConstants.kGreen,
              borderColor: AppConstants.kLight,
              text: 'Submit',
              textStyleColor: AppConstants.kLight,
            ),
          ],
        ),
      ),
    );
  }
}
