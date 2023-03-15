import 'package:flutter/material.dart';

class marketPage extends StatefulWidget {
  const marketPage({Key? key}) : super(key: key);

  @override
  State<marketPage> createState() => _marketPageState();
}

class _marketPageState extends State<marketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(248, 184, 225, 1.0),
                      Color.fromRGBO(69, 172, 243, 1.0)
                    ]
                )
            )
        ),
      ),
    );
  }
}
