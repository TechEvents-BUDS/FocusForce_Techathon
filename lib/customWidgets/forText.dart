import 'package:cmslms/utils/colors.dart';
import 'package:flutter/material.dart';

myText(
  String text, [
  double size = 14,
  bool isbold = false,
  Color color = Colors.black,
]) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      fontWeight: (isbold) ? FontWeight.bold : FontWeight.normal,
      color: color,
    ),
  );
}

TextStyle headingStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

TextStyle subtitleStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
  color: Colors.grey[800],
);

TextStyle bodyStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
  color: Colors.grey[700],
);

TextStyle captionStyle = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
  color: Colors.grey[600],
);

TextStyle MainPageUp = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: AppColors.WhiteColor,
);


TextStyle popupheader = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: AppColors.WhiteColor,
);
