import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:money_manage_app/screens/home/screen_home.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _navigateHome();
    _controller = AnimationController(vsync: this);
  }

  

  _navigateHome() async{
    await Future.delayed( Duration(milliseconds: 3200));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
     return const ScreenHome();
    },));

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('BudgetBuddy',style: GoogleFonts.mPlusCodeLatin(
              fontSize: 25
            ),),
          ),
          SizedBox(height: 15,),
          LottieBuilder.network('https://assets1.lottiefiles.com/packages/lf20_yfsxyqxp.json',
          controller: _controller,
          onLoaded: (compose) {
            _controller
               ..duration = compose.duration
               ..forward();
          },
          fit: BoxFit.cover,
          ),
          
        ],
      ),
    );
  }
}