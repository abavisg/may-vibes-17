import 'package:flutter/material.dart';
import 'package:tweenvibes/theme/app_theme.dart';

class GlobeWidget extends StatelessWidget {
  final double size;
  final bool isAnimated;
  final Animation<double>? animation;

  const GlobeWidget({
    super.key,
    this.size = 180,
    this.isAnimated = false,
    this.animation,
  }) : assert(!isAnimated || animation != null,
            'Animation must be provided when isAnimated is true');

  @override
  Widget build(BuildContext context) {
    Widget globeWidget = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppTheme.primaryColor.withAlpha(180),
            AppTheme.primaryColor,
          ],
          stops: const [0.4, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const CustomPaint(
        painter: GlobePainter(),
      ),
    );

    if (isAnimated && animation != null) {
      return RotationTransition(
        turns: animation!,
        child: globeWidget,
      );
    }

    return globeWidget;
  }
}

class GlobePainter extends CustomPainter {
  const GlobePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw latitude lines
    final Paint latitudePaint = Paint()
      ..color = Colors.white.withAlpha(75)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Draw equator
    canvas.drawCircle(center, radius * 0.8, latitudePaint);

    // Draw other latitude lines
    canvas.drawCircle(center, radius * 0.4, latitudePaint);
    canvas.drawCircle(center, radius * 0.6, latitudePaint);

    // Draw longitude lines
    final Paint longitudePaint = Paint()
      ..color = Colors.white.withAlpha(75)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Draw vertical longitude line
    canvas.drawLine(Offset(center.dx, center.dy - radius),
        Offset(center.dx, center.dy + radius), longitudePaint);

    // Draw horizontal longitude line
    canvas.drawLine(Offset(center.dx - radius, center.dy),
        Offset(center.dx + radius, center.dy), longitudePaint);

    // Draw diagonal longitude lines
    canvas.drawLine(
        Offset(center.dx - radius * 0.7, center.dy - radius * 0.7),
        Offset(center.dx + radius * 0.7, center.dy + radius * 0.7),
        longitudePaint);

    canvas.drawLine(
        Offset(center.dx - radius * 0.7, center.dy + radius * 0.7),
        Offset(center.dx + radius * 0.7, center.dy - radius * 0.7),
        longitudePaint);

    // Draw continents (simple shapes as placeholders)
    final Paint continentPaint = Paint()
      ..color = AppTheme.secondaryColor
      ..style = PaintingStyle.fill;

    // North America
    final Path northAmerica = Path()
      ..moveTo(center.dx - radius * 0.5, center.dy - radius * 0.2)
      ..lineTo(center.dx - radius * 0.2, center.dy - radius * 0.5)
      ..lineTo(center.dx - radius * 0.1, center.dy - radius * 0.1)
      ..lineTo(center.dx - radius * 0.3, center.dy)
      ..close();
    canvas.drawPath(northAmerica, continentPaint);

    // Africa
    final Path africa = Path()
      ..moveTo(center.dx + radius * 0.1, center.dy - radius * 0.1)
      ..lineTo(center.dx + radius * 0.3, center.dy - radius * 0.2)
      ..lineTo(center.dx + radius * 0.4, center.dy + radius * 0.2)
      ..lineTo(center.dx + radius * 0.2, center.dy + radius * 0.3)
      ..lineTo(center.dx + radius * 0.1, center.dy + radius * 0.1)
      ..close();
    canvas.drawPath(africa, continentPaint);

    // Australia
    final Path australia = Path()
      ..moveTo(center.dx + radius * 0.5, center.dy + radius * 0.3)
      ..lineTo(center.dx + radius * 0.6, center.dy + radius * 0.2)
      ..lineTo(center.dx + radius * 0.7, center.dy + radius * 0.3)
      ..lineTo(center.dx + radius * 0.6, center.dy + radius * 0.4)
      ..close();
    canvas.drawPath(australia, continentPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
