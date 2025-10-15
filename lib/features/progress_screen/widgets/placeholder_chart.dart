import 'package:flutter/material.dart';
import 'package:inprep_ai/features/progress_screen/model/progress_model.dart';
import 'package:inprep_ai/features/progress_screen/widgets/line_chart.dart';

class PlaceholderChart extends StatelessWidget {
  const PlaceholderChart({super.key});

  @override
  Widget build(BuildContext context) {
    List<ChartData> sampleData = [
      ChartData('Week 1', 0),
      ChartData('Week 2', 0),
      ChartData('Week 3', 0),
      ChartData('Week 4', 0),
    ];

    return SizedBox(
      height: 152,
      width: double.infinity,
      child: CustomPaint(
        painter: LineChartPainter(
          data: sampleData.map((e) => LyOverallAverage(date: e.x, average: e.y)).toList(),
        ),
      ),
    );
  }
}

class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);
}
