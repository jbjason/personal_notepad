import 'package:flutter/material.dart';

class CustomClipperScreen extends StatelessWidget {
  const CustomClipperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipPath(
          clipper: MyClipper(),
          child: Image.asset('assets/brush.jpg', fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final path = Path();

    // // WAVE demo
    // path.lineTo(size.width, 0);
    // path.lineTo(size.width, size.height);
    // final start = Offset(size.width / 2.5, size.height / 2);
    // final end = Offset(size.width / 6, size.height);
    // path.quadraticBezierTo(start.dx, start.dy, end.dx, end.dy);
    // path.lineTo(0, size.height);
    // path.close();

    // //poligon with 4 points
    // final points = [
    //   Offset(size.width * .25, 0),
    //   Offset(size.width, 0),
    //   Offset(size.width * .75, size.height),
    //   Offset(0, size.height),
    // ];
    // path.addPolygon(points, true);
    
    // Poligon with 8 points
    final points = [
      Offset(size.width * .30, 0),
      Offset(size.width*.70, 0),
      Offset(size.width ,size.height* .30),
      Offset(size.width, size.height*.70),
      Offset(size.width*.70, size.height),
      Offset(size.width*.30, size.height),
      Offset(0, size.height*.70),
      Offset(0, size.height*.30),
    ];
    path.addPolygon(points, true);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
