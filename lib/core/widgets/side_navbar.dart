import 'package:flutter/material.dart';

class SideNavBar extends StatelessWidget {
  const SideNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const navBarItems = ['Home', 'Reservations', 'Guests'];
    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Drawer(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: const Alignment(0, -1.3),
                end: const Alignment(0, 6),
                colors: <Color>[
                  const Color(0xff271039).withOpacity(0.7),
                  const Color(0xff404040).withOpacity(0.3),
                ],
                tileMode: TileMode.mirror,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: ListView.separated(
                  itemBuilder: (context, index) => TextButton(
                      onPressed: () {
                        // navigate to page
                      },
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          navBarItems[index],
                          style: TextStyle(
                              color: theme.onSurface,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                  separatorBuilder: (context, index) => Divider(
                        color: theme.surface,
                        thickness: 1,
                        indent: 13,
                        endIndent: 13,
                      ),
                  itemCount: 3),
            )),
      ),
    );
  }
}
