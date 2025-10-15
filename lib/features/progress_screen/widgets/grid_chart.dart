import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:inprep_ai/features/progress_screen/model/progress_model.dart';

class CardWidget extends StatelessWidget {
  final int index;
  final Progress progress;

  const CardWidget({
    required this.index,
    required this.progress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String title = '';
    double percentage = 0;
    String change = '';
    Color changeColor = const Color(0xff1E6540); // Default color

    // Set values dynamically based on index
    if (index == 0) {
      title = 'Content Accuracy';
      percentage = progress.totalAverage.contentScore;
      change = getChange(progress.differenceBetweenTotalAndWithoutLast.contentScore);
      changeColor = getColor(progress.differenceBetweenTotalAndWithoutLast.contentScore);
    } else if (index == 1) {
      title = 'Behavioural Cue';
      percentage = progress.totalAverage.behaviouralCue;
      change = getChange(progress.differenceBetweenTotalAndWithoutLast.behaviouralCue);
      changeColor = getColor(progress.differenceBetweenTotalAndWithoutLast.behaviouralCue);
    } else if (index == 2) {
      title = 'Articulation Clarity';
      percentage = progress.totalAverage.articulation;
      change = getChange(progress.differenceBetweenTotalAndWithoutLast.articulation);
      changeColor = getColor(progress.differenceBetweenTotalAndWithoutLast.articulation);
    } else if (index == 3) {
      title = 'Inprep Score';
      percentage = progress.totalAverage.inprepScore;
      change = getChange(progress.differenceBetweenTotalAndWithoutLast.inprepScore);
      changeColor = getColor(progress.differenceBetweenTotalAndWithoutLast.inprepScore);
    } else if (index == 4) {
      title = 'Problem Solving';
      percentage = progress.totalAverage.problemSolving.toDouble(); // Convert int to double
      change = getChange(progress.differenceBetweenTotalAndWithoutLast.problemSolving.toDouble());
      changeColor = getColor(progress.differenceBetweenTotalAndWithoutLast.problemSolving.toDouble());
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: index == 4
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff212121),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${percentage.toStringAsFixed(1)}%',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff3A4c67),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(isVisible: false),
                        primaryYAxis: NumericAxis(isVisible: false),
                        plotAreaBorderWidth: 0,
                        series: <CartesianSeries<ChartData, String>>[
                          LineSeries<ChartData, String>(
                            dataSource: getData(),
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            color: Color(0xFF6a329f),
                            width: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        change,
                        style: TextStyle(
                          fontSize: 13,
                          color: changeColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.037,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff212121),
                    ),
                  ),
                  Text(
                    '${percentage.toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.030,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff3A4c67),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.097,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(isVisible: false),
                      primaryYAxis: NumericAxis(isVisible: false),
                      plotAreaBorderWidth: 0,
                      series: <CartesianSeries<ChartData, String>>[
                        LineSeries<ChartData, String>(
                          dataSource: getData(),
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          color: Color(0xFF6a329f),
                          width: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    change,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.030,
                      color: changeColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  // Sample static chart data
  List<ChartData> getData() {
    return [
      ChartData('Week 1', 60),
      ChartData('Week 2', 70),
      ChartData('Week 3', 75),
      ChartData('Week 4', 80),
    ];
  }

  // Helper to format change
  String getChange(double changeValue) {
    if (changeValue > 0) {
      return '+${changeValue.toStringAsFixed(1)}%';
    } else if (changeValue < 0) {
      return '${changeValue.toStringAsFixed(1)}%';
    } else {
      return 'Stable';
    }
  }

  // Helper to get change color
  Color getColor(double changeValue) {
    if (changeValue > 0) {
      return const Color(0xff34C759); // Green
    } else if (changeValue < 0) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }
}

class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);
}
