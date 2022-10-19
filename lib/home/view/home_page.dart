import 'package:flutter/material.dart';
import 'package:openhms/core/widgets/header.dart';
import 'package:openhms/core/widgets/side_navbar.dart';
import 'package:openhms/core/widgets/title_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.background,
      body: Column(
        children: [
          const TitleBar(),
          Expanded(
            child: SafeArea(
              child: LayoutBuilder(builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    constraints.maxWidth > 2400
                        ? const SideNavBar()
                        : const Flexible(
                            fit: FlexFit.loose,
                            flex: 2,
                            child: SideNavBar(),
                          ),
                    Expanded(
                      flex: 11,
                      child: Column(
                        children: [
                          const Header(
                            title: 'Home',
                            firstName: 'John',
                            lastName: 'Doe',
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 15),
                              child: Container(
                                color: const Color(0xFF181818),
                                child: const Center(
                                  child: Text('Home'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
