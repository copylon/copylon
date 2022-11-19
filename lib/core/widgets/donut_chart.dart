import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../helpers.dart';

class DonutChart extends StatefulWidget {
  final List<DonutChartSegmentData> segments;
  final bool hasLegend;
  final String? centerText;
  const DonutChart(
      {super.key,
      required this.segments,
      this.hasLegend = true,
      this.centerText});

  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> with TickerProviderStateMixin {
  int touchedIndex = -1;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOutCirc,
  );

  @override
  void initState() {
    super.initState();
    repeatOnce();
  }

  void repeatOnce() async {
    await _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final total = widget.segments.fold<double>(
        0, (previousValue, element) => previousValue + element.segmentValue);

    return Column(
      children: [
        _buildChart(theme, total),
        if (widget.hasLegend) _buildLegend(theme, context, total)
      ],
    );
  }

  Expanded _buildChart(ColorScheme theme, double total) {
    return Expanded(
      child: Stack(
        children: [
          PieChart(PieChartData(
            borderData: FlBorderData(show: false),
            sectionsSpace: 1,
            centerSpaceRadius: 120,
            startDegreeOffset: -90.0,
            pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (event is! FlPointerHoverEvent) {
                  return;
                }
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                if (pieTouchResponse.touchedSection!.touchedSectionIndex !=
                    touchedIndex) {
                  _controller.reset();
                  _controller.forward();
                }
                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            }),
            sections: segmentsToShow(theme),
          )),
          if (widget.centerText != null)
            ScaleTransition(
              scale: _animation,
              child: Center(
                child: RichText(
                  text: touchedIndex == -1
                      ? TextSpan(
                          text: "Total:\n${total.toStringAsFixed(0)}",
                          style: TextStyle(
                              color: theme.onSurface,
                              fontSize: 32,
                              fontWeight: FontWeight.w500))
                      : TextSpan(
                          children: [
                              TextSpan(
                                  text: widget
                                      .segments[touchedIndex].segmentValue
                                      .toStringAsFixed(0),
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(text: "\nof "),
                              TextSpan(
                                  text: total.toStringAsFixed(0),
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(text: " ${widget.centerText}")
                            ],
                          style: TextStyle(
                              color: theme.onSurface,
                              fontSize: 15,
                              fontWeight: FontWeight.w400)),
                  textAlign: TextAlign.center,
                ),
              ),
            )
        ],
      ),
    );
  }

  Expanded _buildLegend(ColorScheme theme, BuildContext context, double total) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Scrollbar(
          thumbVisibility: true,
          child: ListView.builder(
            primary: true,
            scrollDirection: Axis.vertical,
            shrinkWrap: false,
            itemCount: widget.segments.length,
            itemBuilder: (_, index) => Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 22.0, horizontal: 13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      height: 37,
                      width: 37,
                      decoration: BoxDecoration(
                          color: widget.segments[index].segmentColor,
                          shape: BoxShape.circle),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: LayoutBuilder(
                      builder: (_, constraints) {
                        final text = widget.segments[index].segmentTitle;

                        final style = TextStyle(
                          color: theme.onSurface,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w400,
                        );
                        final overflow = checkLineOverflow(
                            context, constraints, text, style);
                        return overflow
                            ? Tooltip(
                                message: text,
                                decoration: BoxDecoration(
                                    color: theme.secondary,
                                    borderRadius: BorderRadius.circular(6)),
                                textStyle: TextStyle(
                                    color: theme.onSurface, fontSize: 13),
                                child: Text(
                                  text,
                                  style: style,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            : Text(
                                text,
                                style: style,
                              );
                      },
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "${(widget.segments[index].segmentValue / total * 100).toStringAsFixed(0)}%",
                      style: TextStyle(
                          color: theme.onSurface,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> segmentsToShow(ColorScheme theme) {
    return List.generate(widget.segments.length, (index) {
      final isTouched = index == touchedIndex;
      final radius = isTouched ? 50.0 : 40.0;
      final borderSide =
          isTouched ? BorderSide(width: 2.0, color: theme.onSurface) : null;

      return PieChartSectionData(
          color: widget.segments[index].segmentColor,
          value: widget.segments[index].segmentValue,
          radius: radius,
          borderSide: borderSide,
          showTitle: false);
    });
  }
}

class DonutChartSegmentData {
  final Color segmentColor;
  final double segmentValue;
  final String segmentTitle;

  DonutChartSegmentData(
      this.segmentColor, this.segmentValue, this.segmentTitle);
}
