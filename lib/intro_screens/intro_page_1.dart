
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
class Intro1 extends StatefulWidget {
  const Intro1({super.key});

  @override
  State<Intro1> createState() => _Intro1State();
}

class _Intro1State extends State<Intro1> {
  @override
  Widget build(BuildContext context) {
    return Container
    (
      color: Colors.grey[600],
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column
      (
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: 
        [
          Animate(
            effects: 
            [
              
              FadeEffect( delay: 250.ms, duration: 1000.ms),
              const SlideEffect( curve: Curves.easeIn),
            ],
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
                  "Welcome to R&A mobile",
                  style: GoogleFonts.quicksand(textStyle: const TextStyle(fontSize: 60)),
                )
              ),
            ),
          
        
          // Container
          // (
          //   height: 400,
          //   width: 400,
          //   decoration: const BoxDecoration
          //   (
          //     image:  DecorationImage
          //     (
          //       image: AssetImage('assets/R.png'),
          //       fit: BoxFit.cover,
          //     )
          //   ),
          //),
        ],
      ),
    );
  }
}