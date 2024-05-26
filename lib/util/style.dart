import 'package:flutter/material.dart';

// constant style widgets.

Widget kCustomText(String text, double size, FontWeight weight) {
  return Text(
    text,
    style: TextStyle(color: Colors.white, fontSize: size, fontWeight: weight),
  );
}

Widget kverticalSpace(double h) {
  return SizedBox(
    height: h,
  );
}

Widget kHorizontalSpace(double w) {
  return SizedBox(
    width: w,
  );
}
