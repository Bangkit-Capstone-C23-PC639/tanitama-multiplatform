import 'package:flutter/material.dart';
import 'package:tanitama/core/commons/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.label,
    this.obsecureText = false,
    this.controller,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.hint,
    this.enabledBorder,
    this.hintStyle,
    this.prefixIcon,
    this.fillColor = grayColor,
    this.maxLines = 1,
    this.onChanged,
  });

  final String? label;
  final bool obsecureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final String? hint;
  final InputBorder? enabledBorder;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Color fillColor;
  final int? maxLines;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Text(
                label!,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              )
            : const SizedBox(),
        label != null
            ? const SizedBox(
                height: smallPadding,
              )
            : const SizedBox(),
        TextFormField(
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          controller: controller,
          cursorColor: textColor,
          maxLines: maxLines,
          obscureText: obsecureText,
          onChanged: onChanged,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Pastikan data terisi dengan benar';
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor,
            prefixIcon: prefixIcon,
            hintText: hint,
            hintStyle: hintStyle,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: basePadding,
              vertical: smallPadding,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(6), // Set the desired border radius
              borderSide: const BorderSide(
                  color: Colors
                      .transparent), // Remove the border color when focused
            ),
          ),
        ),
      ],
    );
  }
}
