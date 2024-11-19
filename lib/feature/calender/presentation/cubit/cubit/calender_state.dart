part of 'calender_cubit.dart';

@immutable
sealed class CalenderState {}

final class CalenderInitial extends CalenderState {}

final class getHabitForSpacficDateLoadin extends CalenderState {}

final class getHabitForSpacficDateSuccses extends CalenderState {
  HabitDialySummaryModel dataOfHabit;
  getHabitForSpacficDateSuccses({required this.dataOfHabit});
}

final class getHabitForSpacficDateFail extends CalenderState {
  String massage;
  getHabitForSpacficDateFail({required this.massage});
}

final class getSingleHabitSuccses extends CalenderState {
  String nameOfHabit;
  getSingleHabitSuccses({required this.nameOfHabit});
}
