import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scan_track/generated/l10n.dart';
import 'package:scan_track/utils/colors_data.dart';
import 'package:scan_track/utils/reponsive_font_size.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.do_not_disturb,
          color: ColorsData.primaryColor,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          S.of(context).no_data,
          style: GoogleFonts.aBeeZee(
              color: ColorsData.primaryColor,
              fontSize: getResponsiveFontSize(context, baseFontSize: 25)),
        ),
      ],
    );
  }
}
