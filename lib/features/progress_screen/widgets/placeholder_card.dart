import 'package:flutter/material.dart';
import 'package:inprep_ai/features/progress_screen/widgets/grid_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PlaceholderCard extends StatelessWidget {
  final int index;

  const PlaceholderCard({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    String title = '';
    double percentage = 0.0; // All values as 0
    String change = '0%'; // Static change placeholder
    Color changeColor = Colors.black; // Static color for change (black for 0)

    // Set values dynamically based on index
    if (index == 0) {
      title = 'Content Accuracy';
    } else if (index == 1) {
      title = 'Behavioural Cue';
    } else if (index == 2) {
      title = 'Articulation Clarity';
    } else if (index == 3) {
      title = 'Inprep Score';
    } else if (index == 4) {
      title = 'Problem Solving';
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
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
              '${percentage.toStringAsFixed(1)}%', // 0 value
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
                    dataSource: [
                      ChartData('Week 1', 0),
                      ChartData('Week 2', 0),
                      ChartData('Week 3', 0),
                      ChartData('Week 4', 0),
                    ], // All 0 values
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    color: Colors.grey, // Grey color for 0 values
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
}
