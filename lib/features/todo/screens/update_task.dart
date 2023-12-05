import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/custom_btn.dart';
import 'package:todo/common/widgets/custom_text.dart';
import 'package:todo/common/widgets/text_style.dart';
import 'package:todo/features/todo/controllers/dates/dates_provider.dart';
import 'package:todo/features/todo/controllers/todo_provider.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

class UpdateTaskScreen extends ConsumerStatefulWidget {
  final int id;
  final String title, description;
  const UpdateTaskScreen({
    super.key,
    required this.title,
    required this.description,
    required this.id,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends ConsumerState<UpdateTaskScreen> {
  late final TextEditingController title;
  late final TextEditingController desc;

  @override
  void initState() {
    title = TextEditingController(text: widget.title);
    desc = TextEditingController(text: widget.description);
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
                  ref.read(todoStateProvider.notifier).updateItem(
                        widget.id,
                        title.text,
                        desc.text,
                        0,
                        scheduleDate.substring(0, 10),
                        start.substring(11, 16),
                        finish.substring(11, 16),
                      );
                  ref.read(startTimeStateProvider.notifier).setStart('');
                  ref.read(finishTimeStateProvider.notifier).setFinsh('');
                  ref.read(dateStateProvider.notifier).setDate('');
                  Navigator.of(context).pop();
                } else {
                  if (kDebugMode) print('Failed to add task');
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
