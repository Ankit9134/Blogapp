import 'package:app_blog/View/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, String fontFamily,Color color, FontWeight fontWeight){
  if(fontFamily == FontManager.alice){
    return GoogleFonts.alice().copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  } else {
    return GoogleFonts.alexandria().copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}

dynamic getAliceStyle({double fontSize = AppSize.s12, required Color color}){
  return _getTextStyle(fontSize, FontManager.alice, color, FontWeight.w400);
}

dynamic getAlexandriaStyle({double fontSize = AppSize.s12, required Color color}){
  return _getTextStyle(fontSize, FontManager.alexandria, color, FontWeight.w600);
}
