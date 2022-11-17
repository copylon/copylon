import 'package:flutter/material.dart';
import 'package:openhms/core/helpers.dart';
import 'package:openhms/core/widgets/donut_chart.dart';
import 'package:openhms/core/widgets/header.dart';
import 'package:openhms/core/widgets/hoverable_icon_button.dart';
import 'package:openhms/core/widgets/side_navbar.dart';
import 'package:openhms/core/widgets/title_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

// Placeholder data
  static const List<List<String>> listEntries = [
    ['10:00', 'Will Barrow', 'Single'],
    ['10:10', 'Simonas Toni', 'Double'],
    ['10:20', 'Tuula Mererid', 'Triple'],
    ['10:30', 'Roosevelt Logan', 'Quad'],
    ['10:40', 'George Fernandez', 'Queen'],
    ['10:45', 'Beatrice Henderson', 'Twin'],
    ['10:50', 'Emma Williamson', 'Suite'],
    ['11:25', 'Eddie Mccarthy', 'Apartment'],
  ];

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
                      child: CustomScrollView(
                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Column(
                              children: [
                                const Header(
                                  title: 'Home',
                                  firstName: 'John',
                                  lastName: 'Doe',
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            buildReservationsForTodayTable(
                                              context,
                                              'Arrivals for today',
                                              listEntries,
                                            ),
                                            const SizedBox(width: 10),
                                            buildReservationsForTodayTable(
                                              context,
                                              'Departures for today',
                                              listEntries,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: Container(
                                        width: 370,
                                        height: 882,
                                        padding: const EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                            color: theme.surface,
                                            borderRadius:
                                                BorderRadius.circular(24)),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Room Status',
                                              style: TextStyle(
                                                  color: theme.onSurface,
                                                  fontSize: 24.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Expanded(
                                              child: DonutChart(
                                                segments: generateSegmentData(),
                                                centerText: "rooms",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
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

  Container buildReservationsForTodayTable(
      BuildContext context, String title, List<List<String>> entries) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      width: 370,
      height: 500,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: theme.surface, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                color: theme.onSurface,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: entries.length,
                  itemBuilder: ((_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 15,
                              child: LayoutBuilder(
                                builder: (_, constraints) {
                                  final text =
                                      '${entries[index][0]} - ${entries[index][1]} - ${entries[index][2]}';
                                  final style = TextStyle(
                                      color: theme.onSurface, fontSize: 16);
                                  final overflow = checkLineOverflow(
                                      context, constraints, text, style);
                                  return overflow
                                      ? Tooltip(
                                          message: text,
                                          decoration: BoxDecoration(
                                              color: theme.secondary,
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          textStyle: TextStyle(
                                              color: theme.onSurface,
                                              fontSize: 13),
                                          child: Text(
                                            text,
                                            style: style,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      : Text(
                                          text,
                                          style: style,
                                          overflow: TextOverflow.ellipsis,
                                        );
                                },
                              )),
                          Expanded(
                            flex: 2,
                            child: HoverableIconButton(
                              color: theme.onSurface,
                              hoverColor: const Color(0xFF4FAD18),
                              icon: const Icon(Icons.check),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: HoverableIconButton(
                                color: theme.onSurface,
                                hoverColor: const Color(0xFFA8162A),
                                icon: const Icon(Icons.close),
                              )),
                        ],
                      ),
                    );
                  })),
            ),
          )
        ],
      ),
    );
  }

  // Placeholder Data
  List<DonutChartSegmentData> generateSegmentData() {
    const List<String> segmentTitles = [
      "Available",
      "In use",
      "Unprepared",
      "Out of order",
      "Out of order with tooltip",
    ];
    const List<double> segments = [29.0, 47.0, 13.0, 11.0, 10.0];
    const List<Color> colors = [
      Color(0xFF1a73e9),
      Color(0xFF269546),
      Color(0xFFffc00e),
      Color(0xFFe2372d),
      Color.fromARGB(255, 231, 7, 108),
    ];
    return List<DonutChartSegmentData>.generate(
        segmentTitles.length,
        growable: false,
        (index) => DonutChartSegmentData(
            colors[index], segments[index], segmentTitles[index]));
  }
}
