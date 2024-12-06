import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
class Intro3 extends StatefulWidget {
  const Intro3({super.key});

  @override
  State<Intro3> createState() => _Intro3State();
}

class _Intro3State extends State<Intro3> {
  @override
  Widget build(BuildContext context) {
    return Container
    (
      
      color: Colors.grey[400],
      padding: const EdgeInsets.only(top: 20),
      child: Column
      (
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
                  "Also ALERTS Do Not Forget Them !",
                  style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 40)),
                )
              ),
            ),
          ),
          Lottie.asset('assets/alert1.json', width: 3000)
        ],
      ),
    );
  }
}