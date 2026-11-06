import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String msg) {
  final brightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
  final isDark = brightness == Brightness.dark;
  final bg = isDark
      ? const Color(0xFF4DB6AC).withValues(alpha: 0.85)
      : const Color(0xff0c5656).withValues(alpha: 0.85);
  final fg = isDark ? const Color(0xFF003731) : Colors.white;
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: bg,
    textColor: fg,
    fontSize: 16.0,
  );
}

