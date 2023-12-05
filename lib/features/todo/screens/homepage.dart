import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/custom_text.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/text_style.dart';
import 'package:todo/features/todo/controllers/todo_provider.dart';
import 'package:todo/features/todo/screens/add.dart';
import 'package:todo/features/todo/widgets/completed_tasks.dart';
import 'package:todo/features/todo/widgets/overmorrow_list.dart';
import 'package:todo/features/todo/widgets/rest_day_tasks.dart';
import 'package:todo/features/todo/widgets/today_tasks.dart';
import 'package:todo/features/todo/widgets/tomorrow_list.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();

  late final TabController tabController =
      TabController(length: 2, vsync: this);

  @override
  void dispose() {
    searchController.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(todoStateProvider.notifier).refresh(); // Watch changes
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        // Help us increase size of normal app bar
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: 'Dashboard',
                      style: appstyle(18, AppConstants.kLight, FontWeight.bold),
                    ),
                    Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: const BoxDecoration(
                        color: AppConstants.kLight,
                        borderRadius: BorderRadius.all(
                          Radius.circular(9),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AddTask(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.add,
                          color: AppConstants.kbkDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextField(
                hintText: 'Search',
                controller: searchController,
                prefixIcon: Container(
                  padding: const EdgeInsets.all(14),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      AntDesign.search1,
                      color: AppConstants.kGreyLight,
                    ),
                  ),
                ),
                suffixIcon: const Icon(
                  FontAwesome.sliders,
                  color: AppConstants.kGreyLight,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              SizedBox(height: 25.h),
              Row(
                children: [
                  const Icon(
                    FontAwesome.tasks,
                    size: 20,
                    color: AppConstants.kLight,
                  ),
                  SizedBox(width: 10.w),
                  ReusableText(
                    text: "Today's Tasks",
                    style: appstyle(
                      18,
                      AppConstants.kLight,
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              Container(
                decoration: BoxDecoration(
                  color: AppConstants.kLight,
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppConstants.kRadius),
                  ),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    color: const Color.fromRGBO(102, 119, 129, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        AppConstants.kRadius,
                      ),
                    ),
                  ),
                  controller: tabController,
                  labelPadding: EdgeInsets.zero,
                  isScrollable: false,
                  // labelColor: AppConstants.kBlueLight,
                  // labelStyle: appstyle(
                  //   24,
                  //   AppConstants.kBlueLight,
                  //   FontWeight.w700,
                  // ),
                  // unselectedLabelColor: AppConstants.kLight,
                  indicatorWeight: 0,
                  tabs: [
                    Tab(
                      child: SizedBox(
                        width: AppConstants.kWidth * 0.5,
                        child: Center(
                          child: ReusableText(
                            text: 'Pending',
                            style: appstyle(
                              16,
                              AppConstants.kbkDark,
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        width: AppConstants.kWidth * 0.5,
                        padding: EdgeInsets.only(left: 30.w),
                        child: Center(
                          child: ReusableText(
                            text: 'Completed',
                            style: appstyle(
                              16,
                              AppConstants.kbkDark,
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: AppConstants.kHeight * 0.33,
                width: AppConstants.kWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppConstants.kRadius),
                  ),
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Container(
                        color: AppConstants.kBkLight,
                        height: AppConstants.kHeight * 0.3,
                        child: const TodayTask(),
                      ),
                      Container(
                        color: AppConstants.kBkLight,
                        height: AppConstants.kHeight * 0.3,
                        child: const CompletedTask(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              const TomorrowList(),
              SizedBox(height: 20.h),
              const OvermorrowList(),
              SizedBox(height: 20.h),
              const RemainingTaskList(),
            ],
          ),
        ),
      ),
    );
  }
}
