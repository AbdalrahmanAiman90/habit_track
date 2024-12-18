import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_track/core/theme/color.dart';
import 'package:habit_track/core/theme/style.dart';
import 'package:habit_track/feature/home/presentation/cubit/goal_cubit/cubit/goal_cubit.dart';
import 'package:habit_track/feature/home/presentation/cubit/habit_cubit/habit_cubit.dart';

//todo check
class UserGoalAndHabit extends StatelessWidget {
  const UserGoalAndHabit({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.subText),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "All Habits",
                    style: TextAppStyle.subMainTittel.copyWith(fontSize: 22),
                  ),
                  Text(
                      '${context.read<HabitOperationCubit>().notToDohabitList.length + context.read<HabitOperationCubit>().toDohabitList.length}',
                      style: const TextStyle(
                          color: AppColor.primeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ],
              ),
              // Add a Vertical Divider
              const VerticalDivider(
                color: AppColor.subText, // Color of the divider
                thickness: 1, // Thickness of the divider
                width: 20, // Space taken by the divider
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "All Goals ",
                    style: TextAppStyle.subMainTittel.copyWith(fontSize: 22),
                  ),
                  Text('${context.read<GoalCubit>().goalList.length}',
                      style: const TextStyle(
                          color: AppColor.primeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
