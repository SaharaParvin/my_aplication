
import 'dart:async';
import 'dart:ui';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rlearn5/welcome_screen.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State< SplashScreen > with SingleTickerProviderStateMixin {


  AnimationController controller;
  void initState(){
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      //upperBound: 100,
      vsync:this,
    );
    controller.forward();
    controller.addListener(() {
      setState(() {

      });
      print(controller.value);
    });
    navigateToHome();

  }

  void navigateToHome() async{



    await Future.delayed(Duration(milliseconds: 4000),(){});

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => WelcomeScreen() )

   );

  }


  @override


  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(

      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: null,


    ));


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: Stack(
          children:<Widget> [
            Image.asset('images/background.png',fit:BoxFit.fill ,height: double.infinity,width: double.infinity,),

            Container(
              child: Opacity(
                child: Image.asset('images/logoimg2.png',alignment:Alignment.center,height: 300,width: 150,),
                opacity:controller.value,
              ),
              height:double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            )


          ],

        ),
      ),


    );

  }



}







