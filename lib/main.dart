import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Animation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PlummaHomePage(),
    );
  }
}

class PlummaHomePage extends StatefulWidget {
  @override
  _PlummaHomePageState createState() => _PlummaHomePageState();
}

class _PlummaHomePageState extends State<PlummaHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override 
  void initState() { 
    super.initState(); 
  
    // Create an animation controller 
    _controller = AnimationController( 
      vsync: this, // vsync is set to this for performance reasons 
      duration: Duration(seconds: 6), // Set the duration of the animation 
    ); 
  
    // Create a Tween for the rotation angle 
    _animation = Tween<double>( 
      begin: 0, // Start rotation angle 
      end: 2 * 3.141, // End rotation angle (2 * pi for a full circle) 
    ).animate(_controller); 
  
    // Repeat the animation indefinitely 
    _controller.repeat(); 
  } 

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://is1-ssl.mzstatic.com/image/thumb/Music123/v4/ec/2e/0c/ec2e0c1f-382e-a6e0-b098-c95c81479afa/cover.jpg/600x600bf-60.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 12.0),
              child: Container(
                color: Colors.black.withOpacity(0.1),
              )
            ),
            Row(
              children: [
                Stack(
                  textDirection: TextDirection.ltr,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top:40, bottom: 10, left: 350, right: 20),
                      child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child)
                          {
                            return Transform.rotate(
                              angle: _animation.value,
                              child: Image.asset("assets/vinill.png", width: 600, height: 600)
                            );
                          }
                      )
                    ),
                    Container(
                      padding: EdgeInsets.only(top:40, bottom: 10, left: 40, right: 20),
                      child: Image.network('https://is1-ssl.mzstatic.com/image/thumb/Music123/v4/ec/2e/0c/ec2e0c1f-382e-a6e0-b098-c95c81479afa/cover.jpg/600x600bf-60.jpg'),
                    ),

                    
                  ],
                ),
                Container(
                      padding: EdgeInsets.only(top:600, bottom: 10, left: 370, right: 20),
                      child: Text("VELIAL SQUAD", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                    )
              ],

            )
        ],
          
        ),
      )
    );
  }
}

