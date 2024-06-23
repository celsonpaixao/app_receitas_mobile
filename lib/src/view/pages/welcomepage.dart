import 'dart:async';
import 'package:app_receitas_mobile/src/view/components/spacing.dart';
import 'package:app_receitas_mobile/src/view/pages/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:app_receitas_mobile/src/view/components/globalbutton.dart';
import 'package:app_receitas_mobile/src/view/components/layoutpage.dart';
import 'package:app_receitas_mobile/src/view/components/welcomecard.dart';
import 'package:app_receitas_mobile/src/view/styles/colores.dart';

import '../../controller/userController.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late PageController pageController;
  late Timer _timer;
  List<Widget> scrollPages = [];

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: 0);
    scrollPages = [
      const WelcomeCard(
        image: "assets/images/Eating healthy food-cuate.png",
        text: "Descubra Novos Sabores",
      ),
      const WelcomeCard(
        image: "assets/images/healthy food vs fast food-cuate.png",
        text: "Encontre Receitas mais Saudáveis",
      ),
      const WelcomeCard(
        image: "assets/images/Deconstructed food-amico.png",
        text: "Cozinhe com Facilidade",
      ),
    ];
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (pageController.page != null) {
        int nextPage = pageController.page!.toInt() + 1;
        if (nextPage >= scrollPages.length) {
          nextPage = 0;
        }
        pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var aspectRatio = size.width / size.height;

    return Scaffold(
      backgroundColor: primaryGreen,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: LayoutPage(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Spacing(value: .009),
                SizedBox(
                  height: size.height * .7,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: scrollPages.length,
                    itemBuilder: (context, index) {
                      return scrollPages[index];
                    },
                  ),
                ),
                SmoothPageIndicator(
                  controller: pageController,
                  count: scrollPages.length,
                  effect: ScaleEffect(
                      dotWidth: size.width * 0.01,
                      dotHeight: size.width * 0.02 / aspectRatio,
                      activeDotColor: primaryWhite,
                      dotColor: Colors.white38),
                ),
                const Spacing(value: .03),
                GlobalButton(
                  textButton: "Seguinte",
                  onClick: () {
                    int nextPage = pageController.page!.toInt() + 1;
                    if (nextPage < scrollPages.length) {
                      pageController.animateToPage(
                        nextPage,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      // Implementar a lógica para quando chegar na última página
                    }
                  },
                  background: primaryWhite,
                  textColor: primaryAmber,
                ),
                const Spacing(value: .01),
                GlobalButton(
                  textButton: "Pular",
                  onClick: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  LoginPage(
                           userController: Provider.of<UserController>(context),
                          ),
                        ));
                  },
                  background: primaryAmber,
                  textColor: primaryWhite,
                ),
                const Spacing(value: .01),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
