import 'package:flutter/material.dart';
import 'package:fd16/components/cat.dart';
import 'dart:math';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

//adding Mixin for ticker
class _HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController catController; //to start or stop animation
  Animation<double> catAnimation;

  AnimationController boxController;
  Animation<double> boxAnimation;

  @override
  void initState() {
    super.initState();

    //CAT part
    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this, //ticker
    );

    catAnimation = Tween(begin: -35.0, end: -85.0).animate(
      CurvedAnimation(parent: catController, curve: Curves.easeIn),
    );

    //BOX part
    boxController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(parent: boxController, curve: Curves.easeInOut),
    );
    //add event listener
    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });

    boxController.forward();
  }

  onTap() {
    //moving back n forth
    if (catController.status == AnimationStatus.completed) {
      boxController.forward();
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      boxController.stop();
      catController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat 🦊 Animation'),
        centerTitle: true,
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            //put the box on top of cat
            overflow: Overflow.visible,
            children: <Widget>[
              buildAnimation(),
              buildBox(),
              buildCoverLeft(),
              buildCoverRight(),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

//create 4 parts of stack
  buildAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0,
          left: 0,
        );
      },
      child: Cat(), //Create only one time
    );
  }

  Widget buildBox() {
    return Container(
      height: 200,
      width: 200,
      color: Colors.amber,
    );
  }

  Widget buildCoverLeft() {
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          //not changing
          height: 10,
          width: 125,
          color: Colors.amber,
        ),
        builder: (context, child) {
          return Transform.rotate(
            //changing
            child: child, //Container() above
            alignment: Alignment.topLeft,
            angle: boxAnimation.value,
          );
        },
      ),
    );
  }

  Widget buildCoverRight() {
    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.amber,
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            alignment: Alignment.topRight,
            angle: -boxAnimation.value, //opposite(-)
          );
        },
      ),
    );
  }
}
