import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scan_track/utils/colors_data.dart';
import 'package:scan_track/utils/fonts_data.dart';

class CustomStudentItem extends StatelessWidget {
  const CustomStudentItem(
      {super.key, required this.studentName, required this.qrCode});
  final String studentName;
  final int qrCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blueGrey,
          ColorsData.primaryColor,
        ]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            overflow: TextOverflow.clip,
            studentName,
            style: FontsData().getBody(context, color: Colors.white),
          ),
          Row(
            children: [
              Icon(
                FontAwesomeIcons.qrcode,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "${qrCode} ",
                style: FontsData().getBody(context, color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
