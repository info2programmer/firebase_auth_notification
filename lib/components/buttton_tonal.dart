import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonTonal extends StatelessWidget {
  const ButtonTonal(
      {super.key,
      required this.onPressed,
      required this.title,
      this.fontSize = 18.0,
      this.background});

  final GestureTapCallback onPressed;
  final String title;
  final double? fontSize;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: () async => await onPressed,
      child: Text(
        title,
        style: GoogleFonts.lato(fontSize: fontSize),
      ),
    );
  }
}
