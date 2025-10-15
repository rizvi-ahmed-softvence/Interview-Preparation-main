import 'package:flutter/material.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';

// ignore: must_be_immutable
class AuthCustomTextField extends StatelessWidget {
  TextEditingController controller;
  String text;
  Widget? suffixIcon;
  VoidCallback? onTap;
  bool? obscureText;
  String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  AuthCustomTextField({
    super.key,
    required this.controller,
    required this.text,
    this.suffixIcon,
    this.onTap,
    this.obscureText = false,
    this.validator,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      onChanged: onChanged,
      obscureText: obscureText!,
      style: getTextStyle(
        color: obscureText! ? Color(0xFF0047AB) : Color(0xFF1F1F1F),
        fontWeight: obscureText! ? FontWeight.bold : FontWeight.w400,
      ),
      validator: validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintText: text,
        suffixIcon: suffixIcon,
        hintStyle: getTextStyle(
          color: Color(0xFF898989),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(width: 1, color: Color(0xFF333333)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(width: 1, color: Color(0xFF333333)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(width: 1, color: Color(0xFF333333)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(width: 1, color: Color(0xFF333333)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(width: 1, color: Color(0xFF333333)),
        ),
        errorStyle: getTextStyle(color: Color(0xFFE53935), fontSize: 12),
        errorMaxLines: 1,
        isDense: true,
      ),
      cursorHeight: 25,
    );
  }
}
