part of 'habit_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class CreateHabitLoodin extends HomeState {}

final class creatHabiSuccses extends HomeState {}

final class CreatHabiFail extends HomeState {}

final class GetHabitLoading extends HomeState {}

final class GetHabitSucsess extends HomeState {}

final class GetNotToDoHabitSucsess extends HomeState {
  List<HabitModel> habitData;
  GetNotToDoHabitSucsess({required this.habitData});
}

final class GetHabitFail extends HomeState {
  String massage;
  GetHabitFail({required this.massage});
}

final class DoneHabitLooding extends HomeState {}

final class DoneHabitSuscsses extends HomeState {
  int index;
  bool? isMark;
  DoneHabitSuscsses({required this.index, this.isMark});
}

final class DoneHabitFail extends HomeState {}

final class DeleteHabitLooding extends HomeState {}

final class DeleteHabitSuscsses extends HomeState {
  String massage;
  DeleteHabitSuscsses({required this.massage});
}

final class DeleteHabitFail extends HomeState {}

final class UpdateHabitLooding extends HomeState {}

final class UpdateHabitSuscsses extends HomeState {
  String massage;
  UpdateHabitSuscsses({required this.massage});
}

final class UpdateHabitFail extends HomeState {}

final class GetAllGoalSuccsess extends HomeState {}
