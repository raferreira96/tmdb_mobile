import 'package:flutter/material.dart';
import 'package:tmdb/app/core/ui/extensions/theme_extension.dart';

class CustomDefaultButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final double borderRadius;
  final Color? color;
  final Color? labelColor;
  final double labelSize;
  final double padding;
  final double width;
  final double heigth;

  const CustomDefaultButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.borderRadius = 10,
      this.color,
      this.labelColor,
      this.labelSize = 20,
      this.padding = 10,
      this.width=double.infinity,
      this.heigth=66});

  @override
  State<CustomDefaultButton> createState() => _CustomDefaultButtonState();
}

class _CustomDefaultButtonState extends State<CustomDefaultButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(widget.padding),
      width: widget.width,
      height: widget.heigth,
      child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius)),
              backgroundColor: widget.color ?? context.primaryColor),
          child: Text(widget.label,
              style: TextStyle(
                  fontSize: widget.labelSize, color: widget.labelColor ?? Colors.white))),
    );
  }
}
