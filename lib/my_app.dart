import 'package:app_calculadora_imc_view/pages/calcula_imc_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.aBeeZeeTextTheme()
      ),
      home: CalculaImcPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
