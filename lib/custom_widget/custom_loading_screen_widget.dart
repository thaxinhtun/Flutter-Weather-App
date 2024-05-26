import 'dart:ui';

import 'package:flutter/material.dart';

class CustomLoadingScreen extends StatelessWidget {
  const CustomLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Stack(children: [
          Align(
            alignment: const AlignmentDirectional(3, -0.3),
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.deepPurple),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(-3, -0.3),
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.deepPurple),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0, -1.2),
            child: Container(
              height: 300,
              width: 600,
              decoration: const BoxDecoration(
                  shape: BoxShape.rectangle, color: Colors.orange),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
            ),
          ),
          // ignore: prefer_const_constructors
          Center(
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          )
        ]));
  }
}
