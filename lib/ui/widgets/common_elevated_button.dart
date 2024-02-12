import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ElevatedBtnWidget extends StatelessWidget {
  Color color;
  String name;
  Color textColor;
  final VoidCallback? onpress;
  BorderSide? borderSide;

  ElevatedBtnWidget(
      {super.key,
      required this.color,
      required this.name,
      required this.textColor,
      this.onpress,
      this.borderSide});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          style: ButtonStyle(
            side: MaterialStatePropertyAll(borderSide),
            shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)))),
            backgroundColor: MaterialStatePropertyAll(color),
          ),
          onPressed: onpress,
          child: Text(
            name,
            style: TextStyle(color: textColor, fontSize: 18,fontWeight: FontWeight.w500),
          )),
    );
  }
}
