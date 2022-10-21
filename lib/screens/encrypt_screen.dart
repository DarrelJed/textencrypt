import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';




class EncryptSceen extends StatefulWidget {
  const EncryptSceen({Key? key}) : super(key: key);

  @override
  _EncryptSceenState createState() => _EncryptSceenState();
}

class _EncryptSceenState extends State<EncryptSceen> {
  final TextEditingController _plaintextController = TextEditingController();
  final TextEditingController _ciphertextController = TextEditingController();
  final TextEditingController _offsetController = TextEditingController();

  List<String> letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
//string array
  final _formKey = GlobalKey<FormState>();
  bool _switchValue=true;
  String output = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  void dispose() {
    _plaintextController.dispose();
    _offsetController.dispose();
    super.dispose();
  }
  void loginToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> _generateQR() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Center(
            child: Text(_switchValue ? "Cipher text": "Plain text",
                style: GoogleFonts.shareTech(
                  textStyle: const TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Container(
                  width: 200.0,
                  height: 200.0,
                  child: Center(
                    child: GestureDetector(
                       onTap: () async {
                  await Clipboard.setData(ClipboardData(text: output));
                 loginToast("Text copied!");
                  },
                      child: QrImage(

                        data: output,
                        version: QrVersions.auto,
                        size: 200,


                      ),
                    ),
                  ),

                ),
                Center(
                  child: Text("Tap QR to copy",
                      style: GoogleFonts.raleway(
                        textStyle: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Center(
                  child: Text(output,
                      style: GoogleFonts.shareTech(
                        textStyle: const TextStyle(
                            fontSize: 50,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                child: const Text("Close & Reset"),
                onPressed: () {
                  _offsetController.text="";
                  _plaintextController.text="";
                  _ciphertextController.text="";
                  output="";
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // QrImage(
                //   data: 'e3Rlc3Q6ICd0ZXN0J30=',
                //   version: QrVersions.auto,
                //   size: 150,
                //   gapless: false,
                //   embeddedImage: AssetImage('assets/images/logo.png'),
                //   embeddedImageStyle: QrEmbeddedImageStyle(
                //     size: Size(50, 50),
                //   ),
                // ),
                Center(
                  child: Image.asset(
                    'assets/images/icon.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Text("Text Encrypt/Decrypt",
                    style: GoogleFonts.shareTech(
                      textStyle: const TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                Text("by Darrel Jed Costales",
                    style: GoogleFonts.greatVibes(
                      textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                    )),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_switchValue?"Encrypt":"Decrypt",
                        style: GoogleFonts.shareTech(
                          textStyle: const TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )),

                    CupertinoSwitch(
                      value: _switchValue,

                      onChanged: (value) {
                        setState(() {
                          _switchValue = value;
                        });
                      },
                    ),
                  ],
                ),
                Visibility(
                  visible: _switchValue,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: kIsWeb ? 400 : double.infinity,
                        child: TextFormField(

                            textAlign: TextAlign.center,
                            controller: _plaintextController,
                            decoration: InputDecoration(

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),

                                ),
                                labelText: 'Plain Text'),
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter plain text' : null),
                      )),
                ),
                Visibility(
                  visible: !_switchValue,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: kIsWeb ? 400 : double.infinity,
                        child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: _ciphertextController,
                            decoration: InputDecoration(

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),

                                ),
                                labelText: 'Cipher Text'),
                            validator: (value) =>
                            value!.isEmpty ? 'Please enter cipher text' : null),
                      )),
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: kIsWeb ? 400 : double.infinity,
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _offsetController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'Offset'),
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter offset' : null),
                    )),
                const SizedBox(height: 20),
                Visibility(
                  visible: _switchValue,
                  child: SizedBox(
                    width: kIsWeb ? 400 : double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient:  LinearGradient(
                                  colors: <Color>[
                                    Colors.black54,
                                    Colors.black,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(20.0),
                                primary: Colors.white,
                                textStyle: const TextStyle(fontSize: 20),
                                minimumSize: Size(double.infinity, 40)),
                            onPressed: () async  {
                              _plaintextController.text = _plaintextController.text.trim().replaceAll(" ", "").toLowerCase();
                              output = "";
                               int offset = int.parse(_offsetController.text);
                              for(int i=0; i<_plaintextController.text.length; i++) {
                                // print(_plaintextController.text[i]);

                                for (int a = 0;a<letters.length;a++){
                                  if (_plaintextController.text[i]==letters[a]){
                                    int marker = a+offset;
                                    if ((marker>25)){
                                        marker=marker-26;
                                    }

                                  output = output +  letters[marker];
                                  }
                                }

                              }
                              _generateQR();
                            },
                            child: Text("Encrypt",
                                style: GoogleFonts.sourceSansPro(
                                  textStyle: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !_switchValue,
                  child: SizedBox(
                    width: kIsWeb ? 400 : double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient:  LinearGradient(
                                  colors: <Color>[
                                    Colors.black54,
                                    Colors.black,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(20.0),
                                primary: Colors.white,
                                textStyle: const TextStyle(fontSize: 20),
                                minimumSize: Size(double.infinity, 40)),
                            onPressed: () async  {
                              _ciphertextController.text = _ciphertextController.text.trim().replaceAll(" ", "").toLowerCase();
                              output = "";
                              int offset = int.parse(_offsetController.text);
                              for(int i=0; i<_ciphertextController.text.length; i++) {
                                // print(_plaintextController.text[i]);

                                for (int a = 0;a<letters.length;a++){
                                  if (_ciphertextController.text[i]==letters[a]){
                                    int marker = a-offset;
                                    if ((marker<0)){
                                      marker=marker+26;
                                    }

                                    output = output +  letters[marker];
                                  }
                                }

                              }
                              _generateQR();
                            },
                            child: Text("Decrypt",
                                style: GoogleFonts.sourceSansPro(
                                  textStyle: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    ));
  }
}
