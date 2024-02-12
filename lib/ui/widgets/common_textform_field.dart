import 'package:flutter/material.dart';
import 'package:mvvm_task_demo/core/constants/color_constants.dart';

// ignore: must_be_immutable
class TextFormFieldWidget extends StatelessWidget {
  TextEditingController? controller;
  String name;
  final String? Function(String?)? validator;
  Icon prefixIcon;
  Icon suffixIcon;

  TextFormFieldWidget(
      {super.key,
      this.controller,
      required this.name,
      this.validator,
      required this.suffixIcon,
      required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Material(
        elevation: 7,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: TextFormField(
          controller: controller,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
              prefixIconColor: ColorConstants.grey868686,
              suffixIconColor: ColorConstants.grey868686,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              hintStyle: TextStyle(
                  color: ColorConstants.grey868686,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              filled: true,
              hintText: name,
              fillColor: ColorConstants.white,
              focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                    color: ColorConstants.white,
                    style: BorderStyle.solid,
                    width: 1),
              )),
        ),
      ),
    );
  }
}
