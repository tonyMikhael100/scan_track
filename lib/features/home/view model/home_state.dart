part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeNavBarState extends HomeState {}

//classes
final class GroupDataLoadedState extends HomeState {}

final class NoGroupDataState extends HomeState {}

final class InsertDataState extends HomeState {}

final class DeleterClassState extends HomeState {}

final class UpdateClassState extends HomeState {}

final class SetClassDetailsState extends HomeState {}

//student
final class GenterateRandomNumberState extends HomeState {}

final class UpdateStudentState extends HomeState {}

final class GettClassAndGroupNamdByStudentIdState extends HomeState {}

final class ChangeBorderColorOfSelectedClassState extends HomeState {}

final class SearchStudentState extends HomeState {}

//attendance

final class InsertStudentAttendanceState extends HomeState {}

final class DeleterStudentAttendanceState extends HomeState {}

final class ChooseClassNameState extends HomeState {}

final class CheckVisibileScanButtonState extends HomeState {}

