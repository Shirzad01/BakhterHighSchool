import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:newproject/classes/class11/class1.dart';

class Allclass12 extends StatelessWidget {
  const Allclass12({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List itemsclasses = [
      "صنف(12/1)",
      "صنف(12/2)",
      "صنف(12/3)",
      "صنف(12/4)",
      "صنف(12/5)",
      "صنف(12/6)",
      "صنف(12/7)",
      "صنف(12/8)",
      "صنف(12/9)",
      "صنف(12/10)",
      "صنف(12/11)",
      "صنف(12/12)",
      "صنف(12/13)",
      "صنف(12/14)",
      "صنف(12/15)",
    ];
    List page = [];
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
          itemCount: itemsclasses.length,
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
                        itemsclasses[index],
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
