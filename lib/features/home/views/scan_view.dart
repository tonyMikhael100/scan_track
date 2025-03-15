import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan_track/features/home/view%20model/home_cubit.dart';
import 'package:scan_track/features/home/layouts/mobile_layout/scan_view_mobile_layout.dart';
import 'package:scan_track/features/home/layouts/tablet_layouts/scan_view_table_layout.dart';

class ScanView extends StatelessWidget {
  const ScanView({super.key});

  @override
  Widget build(BuildContext context) {
    var myHomeCubit = BlocProvider.of<HomeCubit>(context);
    var width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constrains) {
            if (constrains.maxWidth < 600) {
              return ScanViewMobileLayout(
                  width: width, myHomeCubit: myHomeCubit);
            } else {
              return ScanViewTableLayout(
                  width: width, myHomeCubit: myHomeCubit);
            }
          },
        );
      },
    );
  }
}
