import 'package:flutter/material.dart';

class ReuseableDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? lists;
  final Function(T?)? onChanged;
  final String? labelText;
  final String? hintText;
  final T? value;
  final String? Function(T?)? validator;
  final bool isExpanded;
  final bool isDense;
  final TextStyle? textStyle;
  const ReuseableDropdown({
    super.key,
    this.lists,
    this.onChanged,
    this.hintText,
    this.labelText,
    this.value,
    this.validator,
    this.isDense = false,
    this.isExpanded = false,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T?>(
      value: value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      isExpanded: isExpanded,
      isDense: isDense,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: textStyle,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 12),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey)),
      ),
      items: lists,
      onChanged: onChanged,
    );
  }
}
