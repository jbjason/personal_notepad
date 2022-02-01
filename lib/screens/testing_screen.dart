import 'package:flutter/material.dart';
import 'package:personal_notepad/widgets/buttonBlack.dart';
import 'package:personal_notepad/widgets/buttonWhite.dart';

class TestingScreen extends StatefulWidget {
//  final Uint8List image;
  const TestingScreen({Key? key}) : super(key: key);
  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  Color boxColor = Colors.indigo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NeumorphismButtonBlack(
              text: Text('Hello'),
              padding: 50.0,
              boxShape: BoxShape.rectangle,
            ),
            SizedBox(height: 40),
            NeumorphismButtonWhite(text: Text('Hello')),
            SizedBox(height: 40),
            BeautifulButton1(),
            SizedBox(height: 20),
            // splash Button
            InkWell(
              onTap: () {
                setState(() => boxColor = Colors.blue);
              },
              onDoubleTap: () {
                setState(() => boxColor = Colors.brown);
              },
              onLongPress: () {
                setState(() => boxColor = Colors.red);
              },
              child: Ink(
                color: boxColor,
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
