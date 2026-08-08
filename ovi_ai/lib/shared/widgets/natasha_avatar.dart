import 'package:flutter/material.dart';

import '../../app/theme/app_theme.dart';

/// Local vector placeholder for Natasha until the final avatar asset is added.
class NatashaAvatar extends StatelessWidget {
  const NatashaAvatar({super.key, this.size = 72, this.showGlow = true});

  final double size;
  final bool showGlow;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Natasha avatar placeholder',
      image: true,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow:
              showGlow
                  ? [
                    BoxShadow(
                      color: OviColors.primary.withValues(alpha: 0.2),
                      blurRadius: size * 0.34,
                      spreadRadius: size * 0.03,
                    ),
                  ]
                  : null,
        ),
        child: CustomPaint(painter: _NatashaAvatarPainter()),
      ),
    );
  }
}

class _NatashaAvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2;
    final rect = Offset.zero & size;

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFC6B6FF), Color(0xFF6AD9DB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(rect),
    );
    canvas.drawCircle(
      center,
      radius * 0.82,
      Paint()..color = const Color(0xFF20293B).withValues(alpha: 0.74),
    );

    final facePaint = Paint()..color = const Color(0xFFFFD9D1);
    final faceRect = Rect.fromCenter(
      center: center.translate(0, radius * 0.08),
      width: radius * 0.96,
      height: radius * 1.12,
    );
    canvas.drawOval(faceRect, facePaint);

    final hairPaint =
        Paint()
          ..color = const Color(0xFF111522)
          ..style = PaintingStyle.fill;
    final hairPath =
        Path()
          ..moveTo(center.dx - radius * 0.5, center.dy + radius * 0.02)
          ..quadraticBezierTo(
            center.dx - radius * 0.7,
            center.dy - radius * 0.84,
            center.dx + radius * 0.1,
            center.dy - radius * 0.72,
          )
          ..quadraticBezierTo(
            center.dx + radius * 0.68,
            center.dy - radius * 0.76,
            center.dx + radius * 0.6,
            center.dy + radius * 0.16,
          )
          ..quadraticBezierTo(
            center.dx + radius * 0.36,
            center.dy - radius * 0.13,
            center.dx + radius * 0.22,
            center.dy - radius * 0.36,
          )
          ..quadraticBezierTo(
            center.dx - radius * 0.18,
            center.dy - radius * 0.02,
            center.dx - radius * 0.5,
            center.dy + radius * 0.02,
          )
          ..close();
    canvas.drawPath(hairPath, hairPaint);

    final eyePaint =
        Paint()
          ..color = const Color(0xFF24243A)
          ..strokeWidth = radius * 0.08
          ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      center.translate(-radius * 0.22, radius * 0.14),
      center.translate(-radius * 0.09, radius * 0.14),
      eyePaint,
    );
    canvas.drawLine(
      center.translate(radius * 0.09, radius * 0.14),
      center.translate(radius * 0.22, radius * 0.14),
      eyePaint,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: center.translate(0, radius * 0.29),
        width: radius * 0.3,
        height: radius * 0.16,
      ),
      0,
      3.14,
      false,
      Paint()
        ..color = const Color(0xFFB56880)
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius * 0.045,
    );
    canvas.drawCircle(
      center.translate(radius * 0.62, radius * 0.56),
      radius * 0.1,
      Paint()..color = OviColors.cyan,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
