import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:newproject/classes/class10/class1.dart';

import 'class10/2.dart';

class AllClass10 extends StatelessWidget {
  const AllClass10({super.key});

  @override
  Widget build(BuildContext context) {
    List items = [
      "صنف(10/1)",
      "صنف(10/2)",
      "صنف(10/3)",
      "صنف(10/4)",
      "صنف(10/5)",
      "صنف(10/6)",
      "صنف(10/7)",
      "صنف(10/8)",
      "صنف(10/9)",
      "صنف(10/10)",
      "صنف(10/11)",
    ];
    List page = [
      class_10_1(),
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
          physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: items.length,
          itemBuilder: (context , index) {
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
                      title: Text(items[index],textAlign: TextAlign.right,),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>page[index]));
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


