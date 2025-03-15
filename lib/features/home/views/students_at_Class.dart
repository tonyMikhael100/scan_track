import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:scan_track/features/home/view%20model/home_cubit.dart';
import 'package:scan_track/features/home/views/student_infromation_view.dart';
import 'package:scan_track/widgets/custom_stream_builder.dart';
import 'package:scan_track/widgets/custom_student_item.dart';

class StudentsAtClass extends StatelessWidget {
  const StudentsAtClass({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var myHomeCubit = BlocProvider.of<HomeCubit>(context);
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomStreamBuilder(
                stream: myHomeCubit.fetchStudentsByClassIdStream(
                    classId: myHomeCubit.classNumberChoosen),
                builderFunction: (data) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          myHomeCubit.getClassAndGroupNamdByStudentId(
                              id: data[index].id);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
