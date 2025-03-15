import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scan_track/utils/reponsive_font_size.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.width,
    required this.text,
    this.fontSize = 18,
    required this.bgColor,
    required this.onPressed,
    this.icon,
    this.height = 30,
  });

  final double width;
  final String text;
  final double fontSize;
  final Color bgColor;
  final void Function()? onPressed;
  final IconData? icon;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton( 
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: getResponsiveFontSize(context, baseFontSize: fontSize),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            icon,
            color: Colors.white,
            size: getResponsiveFontSize(context, baseFontSize: fontSize),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        fixedSize: Size(width, height),
        backgroundColor: bgColor,
      ),
    );
  }
}
