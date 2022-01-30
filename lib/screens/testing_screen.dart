import 'package:flutter/material.dart';

class TestingScreen extends StatefulWidget {
//  final Uint8List image;
  const TestingScreen({Key? key}) : super(key: key);
  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  Color boxColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], // Colors.grey[900]
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NeumorphismButtonBlack(),
            SizedBox(height: 20),
            NeumorphismButtonWhite(),
            SizedBox(height: 20),
            BeautifulButton1(),
            // splash Button
            InkWell(
              onTap: () {
                setState(() => boxColor = Colors.pink);
              },
              onDoubleTap: () {
                setState(() => boxColor = Colors.yellow);
              },
              onLongPress: () {
                setState(() => boxColor = Colors.red);
              },
              child: Ink(
                height: 200,
                width: 200,
                child: const Center(child: Text('Press')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NeumorphismButtonBlack extends StatelessWidget {
  const NeumorphismButtonBlack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Hello'),
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          const BoxShadow(
            color: Colors.black,
            offset: Offset(4, 4),
            blurRadius: 15,
            spreadRadius: 5,
          ),
          BoxShadow(
            color: Colors.grey.shade800,
            offset: const Offset(-4, -4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}

class NeumorphismButtonWhite extends StatelessWidget {
  const NeumorphismButtonWhite({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Hello'),
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(4, 4),
            blurRadius: 15,
            spreadRadius: 5,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-4, -4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}

class BeautifulButton1 extends StatelessWidget {
  const BeautifulButton1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(5.0, 20.0),
            // for red (0xffE91E63)
            color: Colors.greenAccent,
            blurRadius: 30.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            height: 50,
            width: 105,
            decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter,
                  // for red (0xffE91E63) (0xffF48FB1)
                  colors: [Color(0xff4CAF50), Color(0xffA5D6A7)]),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(120),
                bottomLeft: Radius.circular(120),
                bottomRight: Radius.circular(300),
              ),
            ),
            child: Center(
              child: Text(
                'Home',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          const Positioned(
            top: 5,
            right: 5,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              // for red (0xffE91E63)
              child: Icon(Icons.home, color: Color(0xff4CAF50)),
            ),
          ),
        ],
      ),
    );
  }
}
