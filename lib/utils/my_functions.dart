import 'package:flutter/material.dart';
import 'package:get/get.dart';

customSnackbar({required String title, required String message, Color? color}) {
  Get.snackbar(title, message, backgroundColor: color, colorText: Colors.white);
}
