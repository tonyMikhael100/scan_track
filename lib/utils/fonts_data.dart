import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scan_track/utils/reponsive_font_size.dart';

class FontsData {
  TextStyle? headline1;

  TextStyle? headline2;

  TextStyle? bodyText;

  TextStyle? caption;

  TextStyle getHeadline1(BuildContext context) {
    var headline1 = GoogleFonts.abel(
      fontSize: getResponsiveFontSize(context, baseFontSize: 32),
      fontWeight: FontWeight.bold,
    );
    return headline1;
  }

  TextStyle getHeadline2(BuildContext context) {
    var headline2 = GoogleFonts.abel(
      fontSize: getResponsiveFontSize(context, baseFontSize: 32),
      fontWeight: FontWeight.w600,
    );
    return headline2;
  }

  TextStyle getBody(BuildContext context, {Color? color}) {
    var bodyText = GoogleFonts.abel(
      fontSize: getResponsiveFontSize(context, baseFontSize: 18),
      color: color,
      fontWeight: FontWeight.w700,
    );
    return bodyText;
  }

  TextStyle getCaption(BuildContext context) {
    var headline1 = GoogleFonts.abel(
      fontSize: getResponsiveFontSize(context, baseFontSize: 14),
      fontStyle: FontStyle.italic,
    );
    return headline1;
  }
}
