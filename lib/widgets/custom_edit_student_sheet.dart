import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:scan_track/core/models/studnet_model.dart';
import 'package:scan_track/features/home/view%20model/home_cubit.dart';
import 'package:scan_track/generated/l10n.dart';
import 'package:scan_track/utils/colors_data.dart';
import 'package:scan_track/widgets/custom_class_listview_edit_student.dart';
import 'package:scan_track/widgets/custom_elevated_button.dart';
import 'package:scan_track/widgets/custom_stream_builder.dart';
import 'package:scan_track/widgets/custom_text_form_field.dart';

class CustomEditStudentSheet extends StatelessWidget {
  const CustomEditStudentSheet({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.parentPhoneController,
    required this.myHomeCubit,
    required this.width,
    required this.studentModel,
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController parentPhoneController;
  final HomeCubit myHomeCubit;
  final double width;
  final StudentModel studentModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextFormField(
              controller: nameController,
              hintText: "student name",
              onChanged: (value) {
                nameController.text = value;
              },
              maxLength: 30,
              suffixIcon: FontAwesomeIcons.person,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              controller: phoneController,
              hintText: "phone",
              onChanged: (value) {
                phoneController.text = value;
              },
              maxLength: 11,
              suffixIcon: FontAwesomeIcons.phone,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              controller: parentPhoneController,
              hintText: "parent phonoe",
              onChanged: (value) {
                parentPhoneController.text = value;
              },
              maxLength: 11,
              suffixIcon: FontAwesomeIcons.phone,
            ),
            SizedBox(
              height: 10,
            ),
            CustomStreamBuilder(
              stream: myHomeCubit.fetchClassesStream(),
              builderFunction: (data) => CustomClassListviewEditStudent(
                classModel: data,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomElevatedButton(
              width: width,
              text: S.of(context).edit,
              bgColor: ColorsData.secondryColor,
              onPressed: () {
                myHomeCubit.upadateStudent(
                    studentId: studentModel.id,
                    studentName: nameController.text,
                    phone: phoneController.text,
                    parentPhone: parentPhoneController.text,
                    qrCode: studentModel.qrCode,
                    classId: myHomeCubit.selectedClassInStudentEdit);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
