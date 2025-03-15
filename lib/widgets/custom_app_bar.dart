import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scan_track/utils/colors_data.dart';
import 'package:scan_track/utils/reponsive_font_size.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ScanTrack",
                style: GoogleFonts.abel(
                  fontSize: getResponsiveFontSize(context, baseFontSize: 36),
                  color: ColorsData.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Flexible(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
