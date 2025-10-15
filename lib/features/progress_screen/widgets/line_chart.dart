import 'package:flutter/material.dart';
import 'package:inprep_ai/features/progress_screen/model/progress_model.dart';

class LineChartPainter extends CustomPainter {
  final List<LyOverallAverage> data;

  LineChartPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final maxY = 100.0; // ✅ Fixed max Y to 100 for consistent percentage chart
    final padding = 30.0;
    final availableWidth = size.width - padding * 2;
    final labelHeight = 16.0;
    final chartHeight = size.height - labelHeight;

    // Line paint
    final paint = Paint()
      ..color = const Color(0xFF6a329f)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    // Area paint
    final areaPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xff9DA6FE),
          const Color(0xffDADEFF).withAlpha(40),
        ],
      ).createShader(
        Rect.fromLTRB(padding, 50, size.width - padding, chartHeight),
      );

    final points = List<Offset>.generate(data.length, (i) {
      final x = padding + availableWidth * (i / (data.length - 1));
      final y = chartHeight - (chartHeight * (data[i].average / maxY));
      return Offset(x, y);
    });

    final path = Path();
    final areaPath = Path();

    if (points.isNotEmpty) {
      path.moveTo(points.first.dx, points.first.dy);
      areaPath.moveTo(points.first.dx, chartHeight);
      areaPath.lineTo(points.first.dx, points.first.dy);

      for (int i = 1; i < points.length; i++) {
        final p0 = points[i - 1];
        final p1 = points[i];
        final cp1 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p0.dy);
        final cp2 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p1.dy);

        path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p1.dx, p1.dy);
        areaPath.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p1.dx, p1.dy);
      }

      areaPath.lineTo(points.last.dx, chartHeight);
      areaPath.close();
    }

    canvas.drawPath(areaPath, areaPaint);
    canvas.drawPath(path, paint);

    final gridPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.3)
      ..strokeWidth = 0.5;

    // ✅ Horizontal grid lines at fixed percentages
    const yPercents = [0.25, 0.5, 0.75, 1.0];
    for (final yPercent in yPercents) {
      final yPos = chartHeight - (chartHeight * yPercent);
      canvas.drawLine(Offset(padding, yPos), Offset(size.width - padding, yPos), gridPaint);
    }

    // ✅ Y-axis labels: 25%, 50%, 75%, 100%
    const textStyle = TextStyle(color: Colors.black54, fontSize: 10);
    for (final yPercent in yPercents) {
      final yPos = chartHeight - (chartHeight * yPercent);
      final label = '${(yPercent * 100).toInt()}%';
      final tp = TextPainter(text: TextSpan(text: label, style: textStyle), textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(2, yPos - tp.height / 2));
    }

    // X-axis week labels
    for (int i = 0; i < data.length; i++) {
      final x = padding + availableWidth * (i / (data.length - 1));
      final tp = TextPainter(
        text: TextSpan(text: data[i].date, style: textStyle),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(x - tp.width / 2, size.height - tp.height));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

