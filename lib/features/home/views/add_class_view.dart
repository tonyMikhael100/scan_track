import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:scan_track/features/home/view%20model/home_cubit.dart';
import 'package:scan_track/features/login/view%20model/auth_cubit.dart';
import 'package:scan_track/generated/l10n.dart';
import 'package:scan_track/utils/colors_data.dart';
import 'package:scan_track/widgets/custom_app_bar.dart';
import 'package:scan_track/widgets/custom_classes_listview.dart';
import 'package:scan_track/widgets/custom_elevated_button.dart';
import 'package:scan_track/widgets/custom_stream_builder.dart';
import 'package:scan_track/widgets/custom_text_form_field.dart';

class AddClassView extends StatelessWidget {
  AddClassView({super.key});
  final TextEditingController className = TextEditingController();
  final TextEditingController groupName = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    var myHomeCubit = BlocProvider.of<HomeCubit>(context);
    var myAuthCubit = BlocProvider.of<AuthCubit>(context);
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomAppBar(),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              CustomElevatedButton(
                width: width - 37,
                text: S.of(context).add_class,
                bgColor: ColorsData.secondryColor,
                onPressed: () {
                  Get.bottomSheet(
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return S
                                          .of(context)
                                          .this_filed_cant_be_empty;
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    className.text = value;
                                  },
                                  hintText: S.of(context).class_name,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return S
                                            .of(context)
                                            .this_filed_cant_be_empty;
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      groupName.text = value;
                                    },
                                    hintText: S.of(context).group_name),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomElevatedButton(
                                  width: width,
                                  text: S.of(context).add,
                                  bgColor: ColorsData.secondryColor,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      myHomeCubit.insertClass(
                                          className.text, groupName.text);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        )),
                  );
                },
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
          CustomStreamBuilder(
            stream: myHomeCubit.fetchClassesStream(),
            builderFunction: (data) => CustomClassesListView(
              classesList: data,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
