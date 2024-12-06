import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
class Intro2 extends StatefulWidget {
  const Intro2({super.key});

  @override
  State<Intro2> createState() => _Intro2State();
}

class _Intro2State extends State<Intro2> {
  @override
  Widget build(BuildContext context) {
    return Container
    (
      
      color: Colors.grey[500],
      padding: const EdgeInsets.only(top: 20),
      child: Column
      (
        mainAxisAlignment:  MainAxisAlignment.start,
        children: 
        [
          Animate(
            effects: 
            [
              
              FadeEffect( delay: 250.ms, duration: 1000.ms),
              const SlideEffect( curve: Curves.easeIn),
            ],
            child: Container(
              margin: const EdgeInsets.symmetric(vertical:40, horizontal: 20),
              child: Animate
              (
                onPlay: ((controller) => controller.repeat(reverse: true)),
                effects: 
                [
                  const ThenEffect(),
                  ShimmerEffect(duration: 1000.ms, delay: 750.ms)
                ],
                child: Text
                (
                  "We Made reporting Easier!",
                  style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 40)),
                )
              ),
            ),
          ),
          Lottie.asset('assets/report1.json', fit: BoxFit.contain, )
          
        ],
      ),
    );
  }
}