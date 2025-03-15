import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scan_track/utils/colors_data.dart';
import 'package:scan_track/utils/reponsive_font_size.dart';

class CustomSettingItem extends StatelessWidget {
  const CustomSettingItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });
  final IconData icon;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
                colors: [ColorsData.primaryColor, ColorsData.secondryColor])),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.white,
          ),
          title: Text(
            title,
            style: GoogleFonts.aBeeZee(
              color: Colors.white,
              fontSize: getResponsiveFontSize(context, baseFontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
