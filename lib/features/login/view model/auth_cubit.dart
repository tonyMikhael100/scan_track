import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:meta/meta.dart';
import 'package:scan_track/core/models/user_model.dart';
import 'package:scan_track/features/home/views/nav_bar_view.dart';
import 'package:scan_track/features/login/views/login_view.dart';
import 'package:scan_track/utils/colors_data.dart';
import 'package:scan_track/utils/constants.dart';
import 'package:scan_track/utils/my_functions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  List<UserModel> users = [];
  String userName = '';
  int userControl = 0;
  String? selectedPermission = 'no';

  Future<void> signIn(String userName, String password) async {
    final supabase = Supabase.instance.client;

    try {
      final response = await supabase
          .from('user')
          .select()
          .eq('username', userName)
          .eq('password', password);
      print(response);
      if (response.isNotEmpty) {
        navBarIndex = 0;
        Get.to(() => NavBarView());
        await sharedPreferences!.setBool('isSignedIn', true);
        await sharedPreferences!.setString('username', userName);

        await sharedPreferences!
            .setInt('userControl', response[0]['user_control']);

        print('Login successful! User: ${userName}');
        this.userName = userName;
        this.userControl = response[0]['user_control'];
      } else {
        customSnackbar(
            title: 'alert',
            message: "wrong username or password",
            color: Colors.redAccent);
      }
    } catch (error) {
      print('Login Error: $error');
      customSnackbar(
          title: 'alert', message: "faild sign in", color: Colors.redAccent);
    }
  }

  Future<void> signUpUser({
    required String userName,
    required String password,
    required userControl,
  }) async {
    final supabase = Supabase.instance.client;
    var response;
    try {
      response = await supabase.from('user').insert({
        'username': userName,
        'password': password,
        'user_control': userControl,
      });
      Get.back();
      customSnackbar(
          title: "alert",
          message: "added user successful",
          color: ColorsData.secondryColor);
    } catch (error) {
      customSnackbar(
          title: "alert",
          message: "failed to add user",
          color: Colors.redAccent);
      print('Signup Error: $error');
    }
  }

  void signOutUser() async {
    try {
      print('User signed out successfully');
      Get.offAll(() => LoginView());
      await sharedPreferences!.setBool('isSignedIn', false);
      await sharedPreferences!.setString('username', '');
      await sharedPreferences!.setInt('userControl', 0);
    } catch (error) {
      print('Sign out Error: $error');
    }
  }

  Future<List<UserModel>> fetchUsers() async {
    final supabase = Supabase.instance.client;
    var response;
    response = await supabase.from('user').select();
    for (int i = 0; i < response.length; i++) {
      users.add(UserModel.toJson(response[i]));
    }
    emit(FetchAllUserState());
    return users;
  }

  Future<void> deleteUser({required int userId}) async {
    try {
      final supabase = Supabase.instance.client;
      await supabase.from('user').delete().eq('id', userId);
      customSnackbar(
          title: "alert",
          message: "delete user successful",
          color: ColorsData.secondryColor);
    } on Exception catch (e) {
      customSnackbar(
          title: "alert",
          message: "error can't delete user",
          color: Colors.redAccent);
    }
    emit(DeleteUserState());
  }

  changeUserControl() {
    emit(ChangeUserControlState());
  }
}
