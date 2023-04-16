import 'package:flutter/material.dart';

import 'pallet_view.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade700,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PalletView()));
            },
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Colors.red.shade400,
              ),
            ),
            child: const Text("Start AR"),
          ),
        ));
  }
}
