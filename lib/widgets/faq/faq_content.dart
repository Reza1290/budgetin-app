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
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
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
            onExpansionChanged: (expanded) {
              setState(() {
                _expanded = expanded;
              });
            },
            trailing: _expanded
                ? const Icon(Icons.arrow_drop_up)
                : const Icon(Icons.arrow_drop_down),
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Text(widget.answer),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
