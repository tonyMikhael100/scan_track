import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scan_track/features/home/views/nav_bar_view.dart';
import 'package:scan_track/features/login/view%20model/auth_cubit.dart';
import 'package:scan_track/generated/l10n.dart';
import 'package:scan_track/utils/colors_data.dart';
import 'package:scan_track/utils/fonts_data.dart';
import 'package:scan_track/utils/reponsive_font_size.dart';
import 'package:scan_track/widgets/custom_elevated_button.dart';
import 'package:scan_track/widgets/custom_text_form_field.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController usernameSignIn = TextEditingController();
  final TextEditingController passwordSignIn = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var myAuthCubit = BlocProvider.of<AuthCubit>(context);
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  ColorsData.primaryColor,
                  ColorsData.secondryColor
                ]),
              ),
            ),
            Container(
              width: width * 0.9,
              height: height * 0.9,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ScanTrack",
                          style: FontsData().getHeadline1(context),
                        ),
                        Flexible(
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: 200,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      S.of(context).sign_in,
                      style: FontsData().getBody(context),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: usernameSignIn,
                            hintText: S.of(context).user_name,
                            suffixIcon: Icons.person,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email cannot be empty";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              usernameSignIn.text = value;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                            isPassword: true,
                            controller: passwordSignIn,
                            hintText: S.of(context).password,
                            suffixIcon: Icons.password,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return S.of(context).this_filed_cant_be_empty;
                              } else if (value!.length < 6) {
                                return S
                                    .of(context)
                                    .Password_must_be_at_least_6_characters;
                              }
                              return null;
                            },
                            onChanged: (value) {
                              passwordSignIn.text = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomElevatedButton(
                      bgColor: ColorsData.secondryColor,
                      text: S.of(context).sign_in,
                      width: width * 0.9,
                      fontSize: 16,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          myAuthCubit.signIn(
                              usernameSignIn.text, passwordSignIn.text);
                        }
                      },
                    ),



                    
                    Spacer(),
                    Center(
                      child: Text(
                        'powerd by@Commercial Upgrador ',
                        style: GoogleFonts.aBeeZee(
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'version : 1',
                        style: GoogleFonts.aBeeZee(
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
