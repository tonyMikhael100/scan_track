import 'package:flutter/material.dart';

double getResponsiveFontSize(BuildContext context, {required baseFontSize}) {
  double scaleFactor = getScaleFactor(context);

  double lowerLimit = baseFontSize * 0.8;
  double upperLimit = baseFontSize * 1.2;
  double responsiveFontSize = baseFontSize * scaleFactor;
  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  double width = MediaQuery.sizeOf(context).width;

  if (width < 600) {
    return width / 400;
  } else if (width < 900) {
    return width / 700;
  } else {
    return width / 1000;
  }
}
