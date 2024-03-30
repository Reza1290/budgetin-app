import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final String title;
  final List<Widget> content;

  const Layout({Key? key, required this.title, required this.content}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: 
          SizedBox(
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: content,
            ),
          ),
        
      ),
    );
  }
}
