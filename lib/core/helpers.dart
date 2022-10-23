import 'package:flutter/cupertino.dart';

bool checkLineOverflow(BuildContext context, BoxConstraints constraints,
    String text, TextStyle style) {
  final span = TextSpan(text: text, style: style);
  final painter = TextPainter(
    text: span,
    maxLines: 1,
    textScaleFactor: MediaQuery.of(context).textScaleFactor,
    textDirection: TextDirection.ltr,
  );
  painter.layout();
  return painter.size.width > constraints.maxWidth;
}
