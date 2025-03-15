import 'package:flutter/material.dart';
import 'package:scan_track/features/login/view%20model/auth_cubit.dart';
import 'package:scan_track/utils/colors_data.dart';
import 'package:scan_track/utils/fonts_data.dart';
import 'package:scan_track/widgets/custom_elevated_button.dart';
import 'package:scan_track/widgets/custom_text_filed.dart';

class AddUserBottomSheet extends StatelessWidget {
  const AddUserBottomSheet({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.myAuthCubit,
    required this.width,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final AuthCubit myAuthCubit;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            CustomTextField(
              controller: usernameController,
              hintText: 'username',
              onChanged: (value) {
                usernameController.text = value;
              },
              isEnable: true,
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: passwordController,
              hintText: 'password',
              onChanged: (value) {
                passwordController.text = value;
              },
              isEnable: true,
            ),
            SizedBox(
              height: 20,
            ),
            RadioListTile<String>(
              title: Text(
                'make this user can delete other user ?',
                style: FontsData().getBody(context),
              ),
              value: 'yes',
              groupValue: myAuthCubit.selectedPermission,
              onChanged: (value) {
                myAuthCubit.selectedPermission = value!;
                print(myAuthCubit.selectedPermission);
                myAuthCubit.changeUserControl();
              },
            ),
            RadioListTile<String>(
              title: Text(
                "make this user can't delete other user ?",
                style: FontsData().getBody(context),
              ),
              value: 'no',
              groupValue: myAuthCubit.selectedPermission,
              onChanged: (value) {
                myAuthCubit.selectedPermission = value!;
                print(myAuthCubit.selectedPermission);
                myAuthCubit.changeUserControl();
              },
            ),
            CustomElevatedButton(
              width: width,
              text: 'Add',
              bgColor: ColorsData.primaryColor,
              onPressed: () {
                myAuthCubit.signUpUser(
                  userName: usernameController.text,
                  password: passwordController.text,
                  userControl:
                      myAuthCubit.selectedPermission == 'yes'
                          ? 1
                          : 0,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
