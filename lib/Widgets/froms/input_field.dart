import 'package:flutter/material.dart';

import '../../Utils/colors.dart';

class Myinput extends StatefulWidget {
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
  final Color? cursorcolor;
  final IconData? Suffixicon;
  final IconData? Suffixiconoff;
  final Function()? suffixiconfun;
  final FocusNode? focusNode;
  const Myinput(
      {required this.labelText,
      this.onChanged,
      this.cursorcolor,
      this.Suffixiconoff,
      this.Suffixicon,
      this.suffixiconfun,
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
      this.focusNode,
      this.controller})
      : super(key: key);

  @override
  State<Myinput> createState() => _MyinputState();
}

class _MyinputState extends State<Myinput> {
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      onTap: widget.ontap,
      enabled: widget.enabled,
      style: TextStyle(color: Colors.white),
      cursorColor:
          widget.cursorcolor == null ? MyColors.MainYellow : widget.cursorcolor,
      autofillHints: widget.AutofillHints,
      keyboardType: widget.keyboardType,
      autofocus: widget.autoFocus,
      controller: widget.controller,
      onChanged: widget.onChanged,
      onSaved: (v) {},
      validator: widget.validate,
      maxLines: widget.lines,
      textInputAction: widget.textInputAction,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        prefixIcon: widget.icon,
        suffixIcon: IconButton(
          icon: Icon(
            widget.obscureText ? widget.Suffixicon : widget.Suffixiconoff,
            color:
                focusNode.hasFocus ? widget.cursorcolor : MyColors.BordersGrey,
          ),
          onPressed: widget.suffixiconfun,
        ),
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Color(0xff343434),
        labelText: widget.labelText,
        focusColor: MyColors.MainYellow,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: widget.cursorcolor == null
                  ? MyColors.MainYellow
                  : widget.cursorcolor!,
              width: 2.0),
        ),
      ),
    );
  }
}
