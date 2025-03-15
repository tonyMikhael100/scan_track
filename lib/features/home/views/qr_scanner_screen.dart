import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scan_track/features/home/view%20model/home_cubit.dart';
import 'package:scan_track/generated/l10n.dart';
import 'package:scan_track/utils/colors_data.dart';

class QRScannerScreen extends StatelessWidget {
  final MobileScannerController cameraController = MobileScannerController();

  bool isScanned = false;
  // To prevent multiple scans
  @override
  Widget build(BuildContext context) {
    var myHomeCubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).scan),
        actions: [
          IconButton(
            icon: Icon(Icons.flash_on),
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            icon: Icon(Icons.flip_camera_ios),
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController, // Attach the controller
            onDetect: (capture) {
              if (!isScanned) {
                isScanned = true;
                final List<Barcode> barcodes = capture.barcodes;
                final String? qrData = barcodes.first.rawValue;
                myHomeCubit.insertAttendance(
                    attendceClassId: myHomeCubit.classNumberChooseScanView!,
                    attendanceStudentQrCode: int.parse(qrData!));
                Get.back();
              }
            },
          ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: ColorsData.primaryColor, width: 4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
