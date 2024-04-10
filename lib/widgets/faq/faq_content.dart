import 'package:flutter/material.dart';

class FaqContent extends StatefulWidget {
  final String question;
  final String answer;

  const FaqContent({super.key, required this.question, required this.answer});

  @override
  State<FaqContent> createState() => _FaqContentState();
}

class _FaqContentState extends State<FaqContent> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 15),
          title: Text(
            widget.question,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(10), // Melengkungkan sudut bawah kiri
                  bottomRight:
                      Radius.circular(10), // Melengkungkan sudut bawah kanan
                ),
              ),
              child: Text(widget.answer),
            ),
          ],
          onExpansionChanged: (expanded) {
            setState(() {
              _expanded = expanded;
            });
          },
          trailing: _expanded
              ? const Icon(Icons.arrow_drop_up)
              : const Icon(Icons.arrow_drop_down),
        ),
      ),
    );
  }
}
