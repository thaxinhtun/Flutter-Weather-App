import 'package:flutter/material.dart';

import '../util/style.dart';

class WeatherDetail extends StatelessWidget {
  final String img;
  final String firstText;
  final String secondText;
  final FontWeight firstTextWeight;
  final FontWeight secondTextWeight;

  const WeatherDetail(
      {super.key,
      required this.img,
      required this.firstText,
      required this.secondText,
      required this.firstTextWeight,
      required this.secondTextWeight});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          img,
          scale: 8,
        ),
        kHorizontalSpace(5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kCustomText(firstText, 14, firstTextWeight),
            kCustomText(secondText, 14, secondTextWeight)
          ],
        )
      ],
    );
  }
}
