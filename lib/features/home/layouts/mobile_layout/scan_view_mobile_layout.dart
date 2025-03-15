import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:scan_track/features/home/view%20model/home_cubit.dart';
import 'package:scan_track/features/home/views/qr_scanner_screen.dart';
import 'package:scan_track/generated/l10n.dart';
import 'package:scan_track/utils/colors_data.dart';
import 'package:scan_track/utils/fonts_data.dart';
import 'package:scan_track/widgets/custom_elevated_button.dart';
import 'package:scan_track/widgets/custom_stream_builder.dart';

class ScanViewMobileLayout extends StatelessWidget {
  const ScanViewMobileLayout({
    super.key,
    required this.width,
    required this.myHomeCubit,
  });

  final double width;
  final HomeCubit myHomeCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          S.of(context).scan,
          style: FontsData().getHeadline1(context),
        ),
        Icon(
          Icons.qr_code_scanner_rounded,
          color: ColorsData.secondryColor,
          size: width * 0.8,
        ),
        CustomElevatedButton(
          width: width,
          text: "${myHomeCubit.classNameChoosenScanView}",
          bgColor: Colors.grey,
          onPressed: () {
            Get.bottomSheet(
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: CustomStreamBuilder(
                    stream: myHomeCubit.fetchClassesStream(),
                    builderFunction: (data) {
                      return ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          itemCount: data.length,
                          itemBuilder: (contex, index) {
                            return ListTile(
                              title: Text(
                                "${data[index].className}",
                                style: FontsData().getBody(context),
                              ),
                              subtitle: Text(
                                "${data[index].groupName}",
                                style:
                                    FontsData().getCaption(context),
                              ),
                              onTap: () {
                                myHomeCubit
                                        .classNumberChooseScanView =
                                    data[index].id;
                                myHomeCubit.classNameChoosenScanView =
                                    data[index].className;
                                myHomeCubit.chooseClassName();
                                Get.back();
                              },
                            );
                          });
                    }),
              ),
            );
          },
        ),
        Visibility(
          visible: myHomeCubit.checkVisibileScanButton(),
          child: CustomElevatedButton(
            icon: Icons.qr_code_scanner_sharp,
            width: width,
            fontSize: 22,
            text:  S.of(context).scan,
            bgColor: ColorsData.primaryColor,
            onPressed: () async {
              await Get.to(() => QRScannerScreen());
            },
          ),
        ),
      ],
    );
  }
}

