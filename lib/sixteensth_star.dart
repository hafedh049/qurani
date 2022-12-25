import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class SixteenSideStar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 70,
      child: CustomPaint(
        size: const Size(800,
            800), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
        painter: SixteenSideStarPainter(),
      ),
    );
  }
}

class SixteenSideStarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 184, 113, 251)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Path path0 = Path();
    path0.moveTo(size.width * 0.4998000, 0);
    path0.lineTo(size.width * 0.6237500, size.height * 0.1000000);
    path0.lineTo(size.width * 0.7487500, size.height * 0.1000000);
    path0.lineTo(size.width * 0.7487500, size.height * 0.3000000);
    path0.lineTo(size.width * 0.8125000, size.height * 0.5000000);
    path0.lineTo(size.width * 0.7500000, size.height * 0.7020000);
    path0.lineTo(size.width * 0.7500000, size.height * 0.9020000);
    path0.lineTo(size.width * 0.6250000, size.height * 0.9000000);
    path0.lineTo(size.width * 0.5008250, size.height);
    path0.lineTo(size.width * 0.3750000, size.height * 0.9020000);
    path0.lineTo(size.width * 0.2500000, size.height * 0.9000000);
    path0.lineTo(size.width * 0.2500000, size.height * 0.7000000);
    path0.lineTo(size.width * 0.1862500, size.height * 0.5000000);
    path0.lineTo(size.width * 0.2500000, size.height * 0.3000000);
    path0.lineTo(size.width * 0.2500000, size.height * 0.0980000);
    path0.lineTo(size.width * 0.3750000, size.height * 0.1000000);
    path0.lineTo(size.width * 0.4998000, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
