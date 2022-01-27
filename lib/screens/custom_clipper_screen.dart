import 'package:flutter/material.dart';

class CustomClipperScreen extends StatefulWidget {
  const CustomClipperScreen({Key? key}) : super(key: key);
  @override
  State<CustomClipperScreen> createState() => _CustomClipperScreenState();
}

class _CustomClipperScreenState extends State<CustomClipperScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 0.0,
      upperBound: 1.0,
      lowerBound: -1.0,
      duration: Duration(seconds: 5),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, widget) => ClipPath(
            clipper: MyClipper(value: _controller.value),
            child: Image.asset('assets/brush.jpg', fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  final value;
  MyClipper({required this.value});

  @override
  getClip(Size size) {
    final path = Path();

    // WAVE demo
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    final start =
        Offset(size.width / 2.5 * value * 20, size.height / 2 * value * 20);
    final end = Offset(size.width / 6 * value * 10, size.height * value * 10);
    path.quadraticBezierTo(start.dx, start.dy, end.dx, end.dy);
    path.lineTo(0, size.height);
    path.close();

    // //poligon with 4 points
    // final points = [
    //   Offset(size.width * .25, 0),
    //   Offset(size.width, 0),
    //   Offset(size.width * .75, size.height),
    //   Offset(0, size.height),
    // ];
    // path.addPolygon(points, true);

    // // Poligon with 8 points
    // final points = [
    //   Offset(size.width * .30, 0),
    //   Offset(size.width * .70, 0),
    //   Offset(size.width, size.height * .30),
    //   Offset(size.width, size.height * .70),
    //   Offset(size.width * .70, size.height),
    //   Offset(size.width * .30, size.height),
    //   Offset(0, size.height * .70),
    //   Offset(0, size.height * .30),
    // ];
    // path.addPolygon(points, true);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
