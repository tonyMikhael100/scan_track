import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scan_track/utils/colors_data.dart';
import 'package:scan_track/utils/reponsive_font_size.dart';

class CustomClassDetails extends StatelessWidget {
  const CustomClassDetails({
    super.key,
    required this.className,
    required this.groupName,
    required this.onPressedEdit,
    required this.onpressedDelete,
  });
  final String className;
  final String groupName;
  final void Function(BuildContext)? onPressedEdit;
  final void Function(BuildContext)? onpressedDelete;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            onPressed: onPressedEdit,
            backgroundColor: ColorsData.secondryColor,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: onpressedDelete,
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [ColorsData.primaryColor, ColorsData.secondryColor]),
          borderRadius: BorderRadius.circular(15),
          color: ColorsData.secondryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              className,
              style: GoogleFonts.abel(
                  fontSize: getResponsiveFontSize(context, baseFontSize: 22),
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              groupName,
              style: GoogleFonts.abel(
                fontSize: getResponsiveFontSize(context, baseFontSize: 18),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
