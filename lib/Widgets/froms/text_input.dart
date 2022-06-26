import 'package:flutter/material.dart';
import 'package:music_royalty/Utils/colors.dart';

import '../Texts/hint_text.dart';
import '../Texts/labels_text.dart';

class TextInput extends StatelessWidget {
  final String labelText;
  final String hint;

  final bool enabled;
  final Icon? icon;
  final int lines;
  final String? what;
  final Function(String)? onChanged;
  final String? Function(String?)? validate;
  final Function(String)? onSubmitted;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autoFocus;
  final bool obscureText;
  const TextInput(
      {required this.labelText,
      this.onChanged,
      this.onSubmitted,
      this.errorText,
      this.keyboardType,
      this.textInputAction,
      this.autoFocus = false,
      this.obscureText = false,
      this.lines = 1,
      Key? key,
      this.enabled = true,
      this.icon,
      this.hint = '',
      this.validate,
      this.what})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            LabelsText(
              text: labelText,
              color: MyColors.MainYellow,
            ),
          ],
        ),
        SizedBox(height: 8),
        TextFormField(
          initialValue: what,
          keyboardType: TextInputType.multiline,
          autofocus: autoFocus,
          onChanged: onChanged,
          onSaved: (v) {},
          validator: validate,
          maxLines: lines,
          textInputAction: textInputAction,
          obscureText: obscureText,
          decoration: InputDecoration(
            fillColor: Colors.grey,
            prefixIcon: icon,
            errorText: errorText,
            enabled: enabled,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        Row(
          children: [
            hintText(
              text: hint,
              color: Colors.white,
            ),
          ],
        )
      ],
    );
  }
}
