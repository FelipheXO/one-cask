import 'package:app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  final double? width;
  final double? vertical;
  final double? fontSize;
  final Color? color;
  final Color? fontColor;
  final bool? isLoading;
  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.width,
      this.color,
      this.fontColor,
      this.vertical,
      this.isLoading,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.primary,
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(vertical: vertical ?? 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: isLoading == true
            ? const SpinKitThreeBounce(
                size: 15,
                color: Colors.white,
              )
            : Text(
                text,
                style: TextStyle(
                    fontSize: fontSize ?? 16,
                    fontWeight: FontWeight.bold,
                    color: fontColor),
              ),
      ),
    );
  }
}
