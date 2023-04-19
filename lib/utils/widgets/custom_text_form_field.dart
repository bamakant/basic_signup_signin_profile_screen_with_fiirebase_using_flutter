import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final bool isPassword;
  final Function(String?)? onSaved;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String?)? validator;
  final double? borderRadius;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? textInputType;
  final bool? showCursor;
  final bool readOnly;
  final Color? prefixIconColor;
  final Color? backgroundColor;
  final FocusNode? focusNode;
  final String? labelText;
  final String? errorText;
  final double? fontSize;
  final TextEditingController? controller;
  final double? horizontalPadding;
  final TextStyle? hintStyle;
  final Function(String?)? onChange;
  final Function()? onTap;
  final bool showBorder;

  const CustomTextFormField({
    Key? key,
    this.hintText,
    this.errorText,
    this.isPassword = false,
    this.onSaved,
    this.prefixIcon,
    this.controller,
    this.validator,
    this.borderRadius = 4,
    this.textInputType = TextInputType.text,
    this.showCursor,
    this.readOnly = false,
    this.backgroundColor = Colors.white,
    this.prefixIconColor,
    this.suffixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.fontSize = 16,
    this.focusNode,
    this.labelText,
    this.horizontalPadding = 10,
    this.hintStyle,
    this.onChange,
    this.onTap,
    this.showBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding!),
      child: TextFormField(
        autofocus: false,
        maxLines: maxLines,
        maxLength: maxLength,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: textInputType,
        showCursor: showCursor,
        readOnly: readOnly,
        obscureText: isPassword,
        onSaved: onSaved,
        onChanged: onChange,
        focusNode: focusNode,
        onTap: onTap,
        style: TextStyle(fontSize: fontSize),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: const EdgeInsets.all(8),
          suffixIcon: Padding(
              padding: const EdgeInsets.all(4), child: suffixIcon),
          prefixIcon: prefixIcon,
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 24,
            maxWidth: 30,
            minHeight: 24,
            minWidth: 30,
          ),
          suffixIconConstraints: const BoxConstraints(
            maxHeight: 24,
            maxWidth: 30,
            minHeight: 24,
            minWidth: 30,
          ),
          hintText: hintText,
          hintStyle: showBorder
              ? const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                )
              : TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade400,
                ),
          labelText: labelText,
          prefixIconColor: prefixIconColor,
          filled: true,
          fillColor: backgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius!),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius!),
            ),
            borderSide: BorderSide(
              color: showBorder ? Colors.grey : Colors.transparent,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius!),
            ),
            borderSide: BorderSide(
              color: showBorder ? Colors.blue : Colors.transparent,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius!),
            ),
            borderSide: BorderSide(
              color: showBorder ? Colors.grey : Colors.transparent,
              width: 1,
            ),
          ),
          errorText:
              errorText != null && errorText!.isNotEmpty ? errorText : null,
          errorStyle: const TextStyle(fontSize: 14, color: Colors.red),
          labelStyle: const TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
