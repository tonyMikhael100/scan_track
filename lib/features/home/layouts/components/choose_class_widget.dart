import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:scan_track/features/home/view%20model/home_cubit.dart';
import 'package:scan_track/features/home/views/no_data_view.dart';
import 'package:scan_track/widgets/custom_classes_listview.dart';
import 'package:scan_track/widgets/custom_elevated_button.dart';

class ChooseClassWidget extends StatelessWidget {
  const ChooseClassWidget({
    super.key,
    required this.width,
    required this.myHomeCubit,
    required this.height,
  });

  final double width;
  final HomeCubit myHomeCubit;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      width: width,
      text: myHomeCubit.classNameChoosen,
      bgColor: Colors.grey,
      onPressed: () {
        Get.bottomSheet(
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)),
            child: SingleChildScrollView(
                child: StreamBuilder(
                    stream: myHomeCubit.fetchClassesStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (!snapshot.hasData ||
                          snapshot.data!.isEmpty) {
                        return Container(
                            width: double.infinity,
                            height: height / 2,
                            child: Center(child: NoDataView()));
                      }
                      final data = snapshot.data;
                      return CustomClassesListView(classesList: data);
                    })),
          ),
        );
      },
    );
  }
}
