import 'package:flutter/material.dart';

class CategoryHome extends StatefulWidget {
  const CategoryHome({super.key});

  @override
  State<CategoryHome> createState() => _CategoryHomeState();
}

class _CategoryHomeState extends State<CategoryHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Makanan",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        SizedBox(
          height: 7,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 15,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(5)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7 * 0.9,
                  height: 15,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "90%",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.red[400],
                      borderRadius: BorderRadius.circular(5)),
                )
              ],
            ),
            Text(
              "90%",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Makanan",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        SizedBox(
          height: 7,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 15,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(5)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7 * 0.9,
                  height: 15,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "90%",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.red[400],
                      borderRadius: BorderRadius.circular(5)),
                )
              ],
            ),
            Text(
              "90%",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
            )
          ],
        )
      ],
    );
  }
}
