import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qusai_final_project/intro_screens/intro_page_1.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'login_page.dart';
import 'intro_screens/intro_page_2.dart';
import 'intro_screens/intro_page_3.dart';
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> 
{
  //Page controller
  final PageController _pageViewController = PageController();
  // Last page ? 
  bool onLastPage = false;
  bool onFirstPage = false;
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: Stack
      (
        children:
        [
          // slideable
          PageView
          (
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
                onFirstPage = (index == 0);
              });
            },
            controller: _pageViewController,
            children: 
            const 
            [
              Intro1(),
              Intro2(),
              Intro3(),
            ],
          ),
          Container
          (
            alignment: const Alignment(0, 0.9),
            child:
            SmoothPageIndicator
            (
              controller: _pageViewController,
              count: 3,
              effect: const SwapEffect
              (
                activeDotColor: Color.fromARGB(255, 234, 234, 234),
                dotColor: Color.fromRGBO(40, 40, 40, 1),
                dotHeight: 20,
                dotWidth: 20
              ),
            ),
          ),
          Container
          (
            alignment: const Alignment(0, 0.9),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row
            (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: 
              [
                if (!onFirstPage)
                GestureDetector
                (
                  onTap: () {
                    _pageViewController.previousPage(duration:  const Duration(milliseconds: 500), curve: Curves.easeIn);
                  },
                  child: Text("Previos", style: GoogleFonts.ubuntu(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100))),
                ),
                onLastPage ? GestureDetector
                (
                  onTap: () {
                    Navigator.push
                    (
                      context, MaterialPageRoute(builder: ((context) 
                      {
                        return const LogInPage();
                      }))
                    );
                  },
                  child: Text("Done", style: GoogleFonts.ubuntu(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100))),
                ):
                GestureDetector
                (
                  onTap: () {
                    _pageViewController.nextPage(duration:  const Duration(milliseconds: 500), curve: Curves.easeIn);
                  },
                  child: Text("Next",style: GoogleFonts.ubuntu(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100))),
                )
              ],
            ),
          ),
          if(!onLastPage)
          Container
          (
            alignment: const Alignment(0.9, -0.9),
            child:
            GestureDetector
            (
              onTap: () {
                Navigator.push
                (
                  context, MaterialPageRoute(builder: ((context) 
                  {
                    return const LogInPage();
                  }))
                );
              },
              child: Text("Skip", style: GoogleFonts.ubuntu(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100)) )
            ),
          )
        ] 
      ),
    );
  }
}