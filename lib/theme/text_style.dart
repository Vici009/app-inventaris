import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle reg({Color? color, double? fontSize}) =>
      _textStylePoppins(color, fontSize, FontWeight.w400);

  static TextStyle medium({Color? color, double? fontSize}) =>
      _textStylePoppins(color, fontSize, FontWeight.w500);

  static TextStyle semiBold({Color? color, double? fontSize}) =>
      _textStylePoppins(color, fontSize, FontWeight.w600);

  static TextStyle bold({Color? color, double? fontSize}) =>
      _textStylePoppins(color, fontSize, FontWeight.w700);

  static TextStyle _textStylePoppins(
      Color? color, double? size, FontWeight fontWeight) {
    return GoogleFonts.poppins(
        fontWeight: fontWeight, fontSize: size ?? 12, color: color);
  }
}
