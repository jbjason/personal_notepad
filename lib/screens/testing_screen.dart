import 'package:flutter/material.dart';

class TestingScreen extends StatelessWidget {
//  final Uint8List image;
  const TestingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.3),
      body: Center(
        child: Container(
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
        ),
      ),
    );
  }
}
