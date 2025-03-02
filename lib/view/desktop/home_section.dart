import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  late double width;
  late double height;
  bool isName = false;
  bool isRole = false;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height * 0.9,
      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Column for text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedTextKit(
                    totalRepeatCount: 1,
                    onFinished: () {
                      setState(() {
                        isName = true;
                      });
                    },
                    animatedTexts: [
                      TyperAnimatedText(
                        speed: const Duration(milliseconds: 200),
                        "Hi! I'm",
                        textStyle: GoogleFonts.roboto(
                          fontSize: (width * 0.02 > 16) ? width * 0.02 : 20,
                          color: Colors.white38,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  // Animated name text
                  if (isName)
                    AnimatedTextKit(
                      totalRepeatCount: 1,
                      onFinished: () {
                        setState(() {
                          isRole = true;
                        });
                      },
                      animatedTexts: [
                        TyperAnimatedText(
                          speed: const Duration(milliseconds: 200),
                          "Abhishek Bhosale",
                          textStyle: GoogleFonts.roboto(
                            fontSize: (width * 0.03 > 20) ? width * 0.03 : 20,
                            color: Colors.white60,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                  SizedBox(
                    height: height * 0.01,
                  ),
                  // Animated role text
                  if (isRole)
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          speed: const Duration(milliseconds: 200),
                          "Java Developer",
                          textStyle: GoogleFonts.roboto(
                            fontSize: (width * 0.03 > 16) ? width * 0.03 : 20,
                            color: const Color.fromRGBO(229, 101, 0, 1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TypewriterAnimatedText(
                          speed: const Duration(milliseconds: 200),
                          "Flutter Developer",
                          textStyle: GoogleFonts.roboto(
                            fontSize: (width * 0.03 > 16) ? width * 0.03 : 20,
                            color: const Color.fromRGBO(229, 101, 0, 1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Linkdean
                      GestureDetector(
                        onTap: () => redirectToLink(
                            "https://www.linkedin.com/in/abhishek-bhosale-ab9067281/"),
                        child: buildSocialMedia(FontAwesomeIcons.linkedinIn),
                      ),

                      ///Github
                      GestureDetector(
                        onTap: () =>
                            redirectToLink("https://gitlab.com/Abhiab001"),
                        child: buildSocialMedia(FontAwesomeIcons.github),
                      ),

                      ///Twitter
                      GestureDetector(
                        onTap: () => redirectToLink(
                            "https://leetcode.com/u/abhishekab001/"),
                        child: buildSocialMedia(FontAwesomeIcons.code),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: downloadCv,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02,
                          vertical: height * 0.01,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 208, 15, 15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Download CV",
                          style: GoogleFonts.roboto(
                            fontSize: (width * 0.02 > 16) ? width * 0.015 : 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              // Image for the developer
              Image.asset(
                "assets/dev.png",
                width: width * 0.4, // Adjust image size responsively
              ),
            ],
          ),
        ],
      ),
    );
  }

  void downloadCv() async {
    try {
      String url = await FirebaseStorage.instance
          .ref()
          .child("fluttercv.pdf")
          .getDownloadURL();
      Uri uri = Uri.parse(url);
      if (!await launchUrl(uri)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Url are not found!",
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something Went Wrong!",
          ),
        ),
      );
      log("Error: $e"); // Print error for debugging
    }
  }

  void redirectToLink(String url) async {
    Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri);
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Unable to open the link",
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.01,
            ),
          ),
        ),
      );
    }
  }

  Widget buildSocialMedia(IconData icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {},
      onExit: (event) {},
      child: Container(
        width: (width * 0.3 > 20) ? width * 0.03 : 20,
        height: (width * 0.3 > 20) ? width * 0.03 : 20,
        margin: EdgeInsets.only(right: width * 0.02),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(114, 113, 113, 1),
            width: 2,
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: (width * 0.3 > 20) ? width * 0.01 : 20,
          color: const Color.fromRGBO(114, 113, 113, 1),
        ),
      ),
    );
  }
}
