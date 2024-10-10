import 'package:flutter/material.dart';
import 'package:habit_track/core/theme/color.dart';
import 'package:habit_track/core/theme/style.dart';

class CustomTextWithHint extends StatelessWidget {
  final String hintNameInside;
  final String hintName;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTextWithHint({
    Key? key,
    this.hintNameInside = '',
    required this.hintName,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintName,
          style: TextAppStyle.subTittel,
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          color: Colors.white,
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return null;
              }
              return validator?.call(value);
            },
            decoration: InputDecoration(
              hintText: hintNameInside.isNotEmpty ? hintNameInside : null,
              hintStyle: TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              border: borderTextField(),
              enabledBorder: borderTextField(),
              focusedBorder: borderTextField(),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
      ],
    );
  }

  OutlineInputBorder borderTextField() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: AppColor.borderColor,
        width: 1.0,
      ),
    );
  }
}
