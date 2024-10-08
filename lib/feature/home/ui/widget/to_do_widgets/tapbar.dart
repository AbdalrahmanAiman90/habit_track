import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/core/theme/color.dart';
import 'package:habit_track/core/theme/style.dart';
import 'package:habit_track/feature/home/cubit/cubit/home_cubit.dart';
import 'package:habit_track/feature/home/ui/widget/to_do_widgets/habit_continer.dart';

class TabBarToDo extends StatefulWidget {
  final bool showAll; // Pass showAll state from parent

  const TabBarToDo({super.key, required this.showAll});

  @override
  State<TabBarToDo> createState() => _TabBarToDoState();
}

class _TabBarToDoState extends State<TabBarToDo> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs: "To do" and "Not to do"
      child: Container(
        // Removed Expanded
        color: Colors.white,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Colors.white.withOpacity(.5),
            bottom: TabBar(
              unselectedLabelStyle: TextAppStyle.subTittel.copyWith(
                fontSize: 14.sp,
              ),
              unselectedLabelColor: AppColor.subText,
              labelColor: Colors.black,
              labelStyle: TextAppStyle.mainTittel.copyWith(fontSize: 30.sp),
              indicatorColor: Colors.white,
              dividerColor: Colors.white,
              tabs: [
                Tab(
                  height: 50.h,
                  text: 'To do',
                ),
                Tab(
                  height: 50.h,
                  text: 'Not to do',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              //! Widget 1: To Do Habits List
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is GetHabitSucsess) {
                    // Show limited or all habits based on widget.showAll
                    int habitCount = widget.showAll
                        ? state.habitData.length
                        : state.habitData.length >= 2
                            ? state.habitData.length
                            : 1; // Show 2 or all habits
                    return state.habitData.isEmpty
                        ? Center(child: Text("not Date"))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: habitCount,
                            itemBuilder: (context, index) {
                              return HabitContiner(
                                habitDate: state.habitData[index],
                              );
                            },
                          );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
              //! Widget 2: Not To Do Habits List
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  int habitCount =
                      context.read<HomeCubit>().notToDohabitList.length;
                  // Show 2 or all habits
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: habitCount,
                    itemBuilder: (context, index) {
                      return HabitContiner(
                        habitDate:
                            context.read<HomeCubit>().notToDohabitList[index],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
