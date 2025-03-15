part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class FetchAllUserState extends AuthState {}

final class DeleteUserState extends AuthState {}

final class ChangeUserControlState extends AuthState {}
final class GoToNavBarState extends AuthState {}
