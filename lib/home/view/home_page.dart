import 'package:flutter/material.dart';
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Flexible(
                    fit: FlexFit.loose,
                    flex: 2,
                    child: SideNavBar(),
                  ),
                  Expanded(
                      flex: 11,
                      child: Center(
                        child: Text('Home'),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
