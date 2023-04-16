import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pallet_viewer_ar/views/home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey,
        ).copyWith(secondary: Colors.redAccent),
        textTheme: GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: GoogleFonts.nunito(color: Colors.black, fontSize: 20),
        ),
      ),
      home: const MyHomePage(title: 'Pallet Viewer AR Demo'),
    );
  }
}
