import 'package:flutter/material.dart';

class ColorSample extends StatelessWidget {
  final Color color;
  final String colorName;
  final bool selected;

  const ColorSample({
    @required this.color,
    @required this.colorName,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    double size = 9;
    if (selected) {
      size = 14;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            border: selected
                ? Border.all(
                    width: 1.5,
                    color: Colors.white,
                  )
                : null,
          ),
        ),
        SizedBox(height: 6),
        Text(
          colorName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 8,
          ),
        ),
      ],
    );
  }
}
