import 'package:flutter/material.dart';
import 'package:music_royalty/Utils/constants.dart';

import '../../Utils/colors.dart';
import '../Texts/labels_text.dart';

class AutoCompleteWidget extends StatelessWidget {
  final String labelText;
  final String what;
  final TextInputAction? textInputAction;

  final String? Function(String?)? validator;
  final VoidCallback? onFieldSubmitted;
  final TextEditingController? textEditingController;
  final void Function(String)? onSelected;
  final bool enabled;
  final List<String> options = constants.USA_States;

  AutoCompleteWidget({
    Key? key,
    required this.labelText,
    this.onSelected,
    this.onFieldSubmitted,
    this.textInputAction = TextInputAction.next,
    this.textEditingController,
    required this.enabled,
    this.validator,
    required this.what,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
        optionsViewBuilder: (context, onSelected, options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              child: Container(
                width: MediaQuery.of(context).size.width * .44,
                color: MyColors.mainGrey,
                child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final option = options.elementAt(index);

                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: ListTile(
                        title: Text(option,
                            style: const TextStyle(color: Colors.white)),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
        fieldViewBuilder: (BuildContext context, textEditingController,
            FocusNode focusNode, onFieldSubmitted) {
          return TextFormField(
            enabled: enabled,
            validator: validator,
            style: TextStyle(color: Colors.white),
            cursorColor: MyColors.MainYellow,
            textInputAction: textInputAction,
            controller: textEditingController..text = what,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Color(0xff343434),
              labelText: labelText,
              focusColor: MyColors.MainYellow,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MyColors.MainYellow, width: 2.0),
              ),
            ),
            focusNode: focusNode,
            onFieldSubmitted: onSelected,
          );
        },
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }
          return options.where((String option) {
            return option.contains(textEditingValue.text.toUpperCase());
          });
        },
        onSelected: onSelected);
  }
}
