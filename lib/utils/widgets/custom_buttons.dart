import 'package:flutter/material.dart';

class CustomButtons {
  static ElevatedButton filledButton(
          {required String text,
          required VoidCallback onPressed,
          required isEnabled,
          EdgeInsets? padding,
          double? height = 45,
          Widget? child}) =>
      ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: isEnabled
            ? ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(35, 85, 252, 1)))
            : ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(175, 196, 255, 1))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (child != null) child,
            Container(
              height: height,
              padding: padding,
              alignment: Alignment.center,
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      );

  static OutlinedButton outlinedButton(
          {required String text,
          required double radius,
          required VoidCallback onPressed,
          required bool isEnabled,
          double height = 45.0,
          Widget? icon,
          EdgeInsets? padding}) =>
      OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
          side: BorderSide(
            width: 2.0,
            color:
                isEnabled ? const Color.fromRGBO(35, 85, 252, 1) : Colors.grey,
            style: BorderStyle.solid,
          ),
        ),
        child: Container(
          height: height,
          padding: padding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: icon,
                ),
              Text(
                text,
                style: TextStyle(
                    color: isEnabled
                        ? const Color.fromRGBO(35, 85, 252, 1)
                        : Colors.grey,
                    fontSize: 14),
              ),
            ],
          ),
        ),
      );
}
