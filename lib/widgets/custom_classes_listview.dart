import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:scan_track/core/models/class_model.dart';
import 'package:scan_track/features/home/view%20model/home_cubit.dart';
import 'package:scan_track/features/home/views/students_at_Class.dart';
import 'package:scan_track/widgets/custom_group_details.dart';
import 'package:scan_track/widgets/custon_bottomsheet_body.dart';

class CustomClassesListView extends StatelessWidget {
  const CustomClassesListView({
    super.key,
    required this.classesList,
    this.onTap,
  });
  final List<ClassModel>? classesList;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    var myHomeCubit = BlocProvider.of<HomeCubit>(context);
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: classesList!.length,
      itemBuilder: (context, index) {
        final TextEditingController classNameController =
            TextEditingController(text: '${classesList![index].className}');
        final TextEditingController groupNameController =
            TextEditingController(text: '${classesList![index].groupName}');
        return InkWell(
          onTap: onTap == null
              ? () {
                  myHomeCubit.setClassDetail(
                      className: classesList![index].className,
                      classId: classesList![index].id);
                  print(classesList![index].className);
                  Get.back();
                }
              //if i want to set class details with navigat to studenAtClass view
              : () {
                  myHomeCubit.setClassDetail(
                      className: classesList![index].className,
                      classId: classesList![index].id);
                  Get.to(() => StudentsAtClass());
                },
          child: CustomClassDetails(
            className: classesList![index].className,
            groupName: classesList![index].groupName,
            onPressedEdit: (_) {
              Get.bottomSheet(
                CustomBottomSheetBody(
                  height: height,
                  firtTextField: classNameController,
                  SecondTextField: groupNameController,
                  width: width,
                  buttonText: 'Edit',
                  firstHintText: "${classesList![index].className}",
                  secondHintText: "${classesList![index].groupName}",
                  onPressed: () {
                    myHomeCubit.upadateClass(
                        className: classNameController.text,
                        groupName: groupNameController.text,
                        id: classesList![index].id);
                    Get.back();
                  },
                ),
              );
            },
            onpressedDelete: (_) {
              myHomeCubit.deleteClass(id: classesList![index].id);
            },
          ),
        );
      },
    );
  }
}
