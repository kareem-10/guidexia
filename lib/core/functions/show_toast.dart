import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String msg, {Brightness? brightness}) {
  final currentBrightness =
      brightness ??
      WidgetsBinding.instance.platformDispatcher.platformBrightness;

  final isDark = currentBrightness == Brightness.dark;

  final bg = isDark ? const Color(0xFF4DB6AC) : const Color(0xFF0C5656);

  final fg = isDark ? const Color(0xFF003731) : Colors.white;

  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: bg,
    textColor: fg,
    fontSize: 14.sp,
  );
}
