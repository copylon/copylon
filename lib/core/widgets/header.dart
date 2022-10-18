import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header(
      {Key? key,
      required this.title,
      required this.firstName,
      required this.lastName})
      : super(key: key);

  final String title;
  final String firstName, lastName;

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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: theme.onSurface),
              ),
            ),
            Flexible(
              child: SizedBox(
                width: 1000,
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
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  const _NotificationsBadge(
                    hasNewNotifications: true,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    '$firstName $lastName',
                    style: TextStyle(
                        color: theme.onSurface.withOpacity(0.75),
                        fontSize: 20.0),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.logout,
                      color: theme.onSurface,
                      size: 25,
                    ),
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationsBadge extends StatelessWidget {
  const _NotificationsBadge({required this.hasNewNotifications});
  final bool hasNewNotifications;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        OutlinedButton(
          onPressed: () {},
          style: ButtonStyle(
            shape: MaterialStateProperty.all(CircleBorder(
              side:
                  BorderSide(color: theme.onSurface, style: BorderStyle.solid),
            )),
            side: MaterialStateProperty.all(
                BorderSide(color: theme.onSurface, width: 2)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(
              Icons.notifications,
              color: theme.onSurface,
              size: 35,
            ),
          ),
        ),
        if (hasNewNotifications)
          Positioned(
            top: 2,
            left: 49,
            child: IgnorePointer(
              ignoring: true,
              child: Container(
                  height: 15,
                  width: 15,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFB39DDB),
                  )),
            ),
          )
      ],
    );
  }
}
