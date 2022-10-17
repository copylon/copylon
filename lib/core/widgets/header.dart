import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16, right: 16),
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: theme.primary.withOpacity(0.25),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: theme.onSurface),
            ),
            SizedBox(
              width: 546,
              child: TextField(
                cursorColor: theme.outline,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: theme.primary.withOpacity(0.5),
                  focusColor: theme.secondary,
                  hoverColor: Colors.transparent,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: theme.outline.withOpacity(0.25), width: 2),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: theme.outline.withOpacity(0.25), width: 2),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  hintText: 'Search anything',
                  hintStyle: TextStyle(
                      color: theme.onSurface.withOpacity(0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  prefixIcon:
                      Icon(Icons.search, size: 29, color: theme.outline),
                ),
                style: TextStyle(
                    color: theme.onSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
