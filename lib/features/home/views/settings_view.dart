import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scan_track/features/home/views/no_data_view.dart';
import 'package:scan_track/features/login/view%20model/auth_cubit.dart';
import 'package:scan_track/generated/l10n.dart';
import 'package:scan_track/utils/colors_data.dart';
import 'package:scan_track/utils/constants.dart';
import 'package:scan_track/utils/fonts_data.dart';
import 'package:scan_track/utils/reponsive_font_size.dart';
import 'package:scan_track/widgets/add_user_bottomsheet.dart';
import 'package:scan_track/widgets/custom_elevated_button.dart';
import 'package:scan_track/widgets/custom_setting_item.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var myAuthCubit = BlocProvider.of<AuthCubit>(context);
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).settings,
              style: FontsData().getHeadline1(context),
            ),
            Icon(Icons.settings),
          ],
        ),
        Row(
          children: [
            Text(
              S.of(context).welcome_back,
              style: FontsData().getBody(context),
            ),
            Text(
              " " + sharedPreferences!.getString('username').toString(),
              style: GoogleFonts.aBeeZee(
                  color: ColorsData.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: getResponsiveFontSize(context, baseFontSize: 22)),
            )
          ],
        ),
        Divider(),
        // CustomSettingItem(
        //   icon: Icons.settings,
        //   title: "Settings",
        //   onTap: () {
        //   },
        // ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (sharedPreferences!.getInt('userControl') == 1) {
              return CustomSettingItem(
                icon: Icons.delete_forever,
                title: S.of(context).delete_user,
                onTap: () {
                  myAuthCubit.fetchUsers();
                  Get.bottomSheet(
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is FetchAllUserState) {
                          return Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListView.builder(
                              itemCount: myAuthCubit.users.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    myAuthCubit.users[index].username
                                        .toString(),
                                    style: FontsData().getBody(context),
                                  ),
                                  trailing: myAuthCubit.userName ==
                                          myAuthCubit.users[index].username
                                              .toString()
                                      ? null
                                      : IconButton(
                                          onPressed: () {
                                            myAuthCubit.deleteUser(
                                                userId: myAuthCubit
                                                    .users[index].id);
                                            Get.back();
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                );
                              },
                            ),
                          );
                        } else {
                          return NoDataView();
                        }
                      },
                    ),
                  ).then((_) {
                    myAuthCubit.users.removeRange(0, myAuthCubit.users.length);
                  });
                },
              );
            } else {
              return SizedBox(
                height: 1,
              );
            }
          },
        ),
        sharedPreferences!.getInt('userControl') == 1
            ? CustomSettingItem(
                icon: Icons.add,
                title: S.of(context).add_user,
                onTap: () {
                  Get.bottomSheet(
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return AddUserBottomSheet(
                            usernameController: usernameController,
                            passwordController: passwordController,
                            myAuthCubit: myAuthCubit,
                            width: width);
                      },
                    ),
                  );
                },
              )
            : SizedBox(
                width: 1,
              ),
        SizedBox(
          height: 10,
        ),
        CustomElevatedButton(
          width: width,
          text: S.of(context).sign_out,
          bgColor: Colors.redAccent,
          onPressed: () {
            myAuthCubit.signOutUser();
          },
        ),
      ],
    );
  }
}
