import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.purple),
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
          Color.fromRGBO(248, 184, 225, 1.0),
          Color.fromRGBO(69, 172, 243, 1.0)
        ]))),
        actions: [
          Container(
            width: double.infinity,
            height: 20,
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
