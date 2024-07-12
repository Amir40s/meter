import 'package:flutter/material.dart';

class BorderPainterWidget extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashSpacing;

  BorderPainterWidget({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashSpacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(12),
      ));

    final dashPath = _createDashedPath(path, dashLength, dashSpacing);
    canvas.drawPath(dashPath, paint);
  }

  Path _createDashedPath(Path path, double dashLength, double dashSpacing) {
    final dashPath = Path();
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0.0;
      bool drawDash = true;
      while (distance < metric.length) {
        final length = drawDash ? dashLength : dashSpacing;
        final tangent = metric.getTangentForOffset(distance);
        final nextTangent = metric.getTangentForOffset(distance + length);
        if (tangent != null && nextTangent != null) {
          if (drawDash) {
            dashPath.addPath(
              Path()
                ..moveTo(tangent.position.dx, tangent.position.dy)
                ..lineTo(nextTangent.position.dx, nextTangent.position.dy),
              Offset.zero,
            );
          }
          distance += length;
          drawDash = !drawDash;
        } else {
          break;
        }
      }
    }
    return dashPath;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

