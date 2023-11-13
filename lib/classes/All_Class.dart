import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:newproject/classes/class10/all%20class%20of%2010.dart';
import 'package:newproject/classes/class11/Allclass11.dart';

import 'class12/Allclass12.dart';

class classes extends StatelessWidget {
  const classes({super.key});

  @override
  Widget build(BuildContext context) {
    List items = [
      "صنف(10)",
      "صنف(11)",
      "صنف(12)",
    ];
    List page = [
      const AllClass10(),
      const Allclass11(),
      const Allclass12(),
    ];
    int i = 1;
    int f = 2;
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: const Text("صنوف"),
          backgroundColor: Colors.indigo[900],
          systemOverlayStyle: SystemUiOverlayStyle.light),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.all(_w / 30),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              delay: const Duration(milliseconds: 100),
              position: i,
              child: SlideAnimation(
                duration: const Duration(milliseconds: 2500),
                curve: Curves.fastLinearToSlowEaseIn,
                horizontalOffset: 30,
                verticalOffset: 300.0,
                child: FlipAnimation(
                  duration: const Duration(milliseconds: 3000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  flipAxis: FlipAxis.y,
                  child: Container(
                    margin: EdgeInsets.only(bottom: _w / 20),
                    height: _w / 4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        items[index],
                        textAlign: TextAlign.right,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => page[index]));
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
