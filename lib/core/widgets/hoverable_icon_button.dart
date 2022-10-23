import 'package:flutter/material.dart';

class HoverableIconButton extends StatefulWidget {
  const HoverableIconButton(
      {super.key,
      required this.color,
      required this.hoverColor,
      required this.icon,
      this.onPressed});
  final Icon icon;
  final Color color, hoverColor;
  final void Function()? onPressed;

  @override
  State<HoverableIconButton> createState() => _HoverableIconButtonState();
}

class _HoverableIconButtonState extends State<HoverableIconButton> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovered = false;
        });
      },
      child: IconButton(
        onPressed: widget.onPressed ?? () {},
        icon: widget.icon,
        color: !isHovered ? widget.color : widget.hoverColor,
      ),
    );
  }
}
