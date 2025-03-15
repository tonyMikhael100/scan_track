import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:scan_track/features/home/view%20model/home_cubit.dart';
import 'package:scan_track/features/home/views/student_infromation_view.dart';
import 'package:scan_track/generated/l10n.dart';
import 'package:scan_track/utils/colors_data.dart';
import 'package:scan_track/widgets/custom_app_bar.dart';
import 'package:scan_track/widgets/custom_stream_builder.dart';
import 'package:scan_track/widgets/custom_student_item.dart';
import 'package:scan_track/widgets/custom_student_list_homebody.dart';
import 'package:scan_track/widgets/custom_text_filed.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var myHomeCubit = BlocProvider.of<HomeCubit>(context);
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  isEnable: true,
                  controller: myHomeCubit.studentSearchController,
                  onChanged: (value) {
                    myHomeCubit.studentSearchController.text = value;
                    myHomeCubit.searchStudentStateMethod();
                  },
                  hintText: S.of(context).search_student_or_class,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: ColorsData.primaryColor,
                    borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                  color: Colors.white,
                ),
              ),
            ],
          ),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (myHomeCubit.studentSearchController.text.isEmpty) {
                return CustomStudentListHomeBody();
              } else {
                return SearchStudentListView();
              }
            },
          ),
        ],
      ),
    );
  }
}

class SearchStudentListView extends StatelessWidget {
  const SearchStudentListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var myHomeCubit = BlocProvider.of<HomeCubit>(context);
    return CustomStreamBuilder(
      stream: myHomeCubit.searchStudentBynameStream(
          studentName: myHomeCubit.studentSearchController.text),
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
