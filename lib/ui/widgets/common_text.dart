import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextWidget extends StatelessWidget {
  TextWidget(
      {super.key,
      this.size,
      this.fontWeight,
      required this.text,
      this.color,
      required this.alignmentGeometry});
  double? size;
  FontWeight? fontWeight;
  String text;
  Color? color;
  AlignmentGeometry alignmentGeometry;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: alignmentGeometry,
        child: Text(text,
            style: TextStyle(
                color: color, fontSize: size, fontWeight: fontWeight)),
      ),
    );
  }
}
