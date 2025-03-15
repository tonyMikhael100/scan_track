import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scan_track/core/models/class_model.dart';
import 'package:scan_track/features/home/view%20model/home_cubit.dart';
import 'package:scan_track/utils/colors_data.dart';
import 'package:scan_track/utils/reponsive_font_size.dart';

class CustomClassListviewEditStudent extends StatelessWidget {
  CustomClassListviewEditStudent(
      {super.key, required this.classModel, this.onTap});

  final List<ClassModel> classModel;
  final void Function()? onTap;
  int? indexedColorBorder;
  @override
  Widget build(BuildContext context) {
    var myHomeCubit = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return ListView.builder(
            itemCount: classModel.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  myHomeCubit.selectedClassInStudentEdit = classModel[index].id;
                  indexedColorBorder = index;
                  myHomeCubit.changeBorderColorOfSelectedClass();
                  print(myHomeCubit.selectedClassInStudentEdit);
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: indexedColorBorder == index
                        ? Border.all(color: Colors.redAccent, width: 3)
                        : null,
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(colors: [
                      ColorsData.primaryColor,
                      ColorsData.secondryColor
                    ]),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        classModel[index].className,
                        style: GoogleFonts.aBeeZee(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: getResponsiveFontSize(context,
                                baseFontSize: 16)),
                      ),
                      Text(
                        classModel[index].groupName,
                        style: GoogleFonts.aBeeZee(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: getResponsiveFontSize(context,
                                baseFontSize: 14)),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
