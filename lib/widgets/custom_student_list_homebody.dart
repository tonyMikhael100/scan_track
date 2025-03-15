import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:scan_track/features/home/view%20model/home_cubit.dart';
import 'package:scan_track/features/home/views/student_infromation_view.dart';
import 'package:scan_track/widgets/custom_stream_builder.dart';
import 'package:scan_track/widgets/custom_student_item.dart';

class CustomStudentListHomeBody extends StatelessWidget {
  const CustomStudentListHomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var myHomeCubit = BlocProvider.of<HomeCubit>(context);
    return CustomStreamBuilder(
      stream: myHomeCubit.fetchStudentsStream(),
      builderFunction: (data) {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                myHomeCubit.getClassAndGroupNamdByStudentId(id: data[index].id);
                Get.to(() => StudentInfromationView(
                      studentModel: data[index],
                    ));
              },
              child: CustomStudentItem(
                studentName: data[index].firstName,
                qrCode: data[index].qrCode,
              ),
            );
          },
        );
      },
    );
  }
}
