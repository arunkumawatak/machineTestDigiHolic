import 'package:flutter/cupertino.dart';

Text commonText(String text, double size, FontWeight fontWeight, Color color) {
  return Text(
    text,
    maxLines: 2,
    style: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontFamily: "EuclidCircularA",
        fontSize: size,
        fontWeight: fontWeight,
        color: color),
  );
}
