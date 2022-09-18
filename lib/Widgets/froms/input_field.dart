import 'package:flutter/material.dart';

import '../../Utils/colors.dart';

class Myinput extends StatelessWidget {
  final String labelText;
  final String hint;
  final Function()? ontap;
  final bool enabled;
  final Icon? icon;
  final int lines;
  final String? what;
  final Iterable<String>? AutofillHints;
  final Function(String)? onChanged;
  final String? Function(String?)? validate;
  final Function(String)? onSubmitted;
  final TextEditingController? controller;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autoFocus;
  final bool obscureText;
  const Myinput(
      {required this.labelText,
      this.onChanged,
      this.AutofillHints,
      this.onSubmitted,
      this.errorText,
      this.keyboardType = TextInputType.multiline,
      this.textInputAction = TextInputAction.next,
      this.autoFocus = false,
      this.obscureText = false,
      this.lines = 1,
      this.ontap,
      Key? key,
      this.enabled = true,
      this.icon,
      this.hint = '',
      this.validate,
      this.what,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: ontap,
      enabled: enabled,
      style: TextStyle(color: Colors.white),
      cursorColor: MyColors.MainYellow,
      initialValue: what,
      autofillHints: AutofillHints,
      keyboardType: keyboardType,
      autofocus: autoFocus,
      controller: controller,
      onChanged: onChanged,
      onSaved: (v) {},
      validator: validate,
      maxLines: lines,
      textInputAction: textInputAction,
      obscureText: obscureText,
      decoration: InputDecoration(
        icon: icon,
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Color(0xff343434),
        labelText: labelText,
        focusColor: MyColors.MainYellow,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.MainYellow, width: 2.0),
        ),
      ),
    );
  }
}
