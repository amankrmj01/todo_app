// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../extensions/string_extension.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final String hintText;
  final TextInputType inputType;
  final TextEditingController controller;
  final Icon icon;
  final String? Function(String?)? validator;

  const CustomTextField(
      {super.key,
      required this.text,
      required this.controller,
      required this.icon,
      required this.inputType,
      required this.hintText,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: TextFormField(
      key: ValueKey(text),
      validator: validator,
      onSaved: (value) {
        controller.text = value!;
      },
      onChanged: (value) {
        if (text == 'username') {
          controller.text = value.toTitleCase();
        }
      },
      keyboardType: inputType,
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: text,
          labelStyle: GoogleFonts.roboto(),
          hintText: hintText,
          prefixIcon: icon,
          hintStyle: GoogleFonts.roboto()
              .copyWith(color: Colors.black.withOpacity(0.4)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(width: 1, color: Colors.purple)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.amber),
              borderRadius: BorderRadius.circular(20))),
    ));
  }
}

class CustomPasswordField extends StatefulWidget {
  final String text;
  final String hintText;
  final TextEditingController controller;

  const CustomPasswordField({
    super.key,
    required this.text,
    required this.controller,
    required this.hintText,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: widget.text,
          labelStyle: GoogleFonts.roboto(),
          hintText: widget.hintText,
          prefixIcon: const Icon(Icons.lock),
          hintStyle: GoogleFonts.roboto()
              .copyWith(color: Colors.black.withOpacity(0.4)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(width: 1, color: Colors.purple)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: Colors.amber),
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: widget.text == 'Password'
              ? GestureDetector(
                  onTap: _toggleObscureText,
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
