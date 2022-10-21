import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_encrypt/screens/encrypt_screen.dart';


class SplashScreen extends StatelessWidget {

  Future<void> initializeSettings() async {


    //Simulate other services for 3 seconds
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingView();
        } else {

          if (snapshot.hasError)
            return errorView(snapshot);
          else
            return EncryptSceen();

        }
      },
    );
  }

  Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
  }

  Scaffold waitingView() {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Text("MIT 207",
              style: GoogleFonts.shareTech(
                textStyle: const TextStyle(
                    fontSize: 50,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )),
          Text("Security Management",
              style: GoogleFonts.shareTech(
                textStyle: const TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )),
          Text("in Information Management",
              style: GoogleFonts.shareTech(
                textStyle: const TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )),
          Center(
            child: Image.asset(
              'assets/images/icon.png',
              height: 300,
              width: 300,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),backgroundColor: Colors.white ,);
  }
}