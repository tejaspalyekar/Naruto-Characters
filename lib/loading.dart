import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        period: Duration(milliseconds: 500),
        baseColor: Color.fromARGB(183, 77, 77, 77),
        highlightColor: Color.fromARGB(221, 148, 148, 148),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
            height: 300,
            width: 300,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(183, 61, 61, 61),
                Color.fromARGB(183, 95, 95, 95),
                Color.fromARGB(221, 128, 128, 128)
              ]),
              borderRadius: BorderRadius.all(Radius.circular(200)),
            ),
          ),
          Container(
            height: 50,
            width: 200,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(200)),
                gradient: LinearGradient(colors: [
                  Color.fromARGB(183, 61, 61, 61),
                  Color.fromARGB(183, 95, 95, 95),
                  Color.fromARGB(221, 128, 128, 128)
                ])),
          )
        ]));
  }
}
