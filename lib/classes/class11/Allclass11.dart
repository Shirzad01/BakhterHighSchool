import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:newproject/classes/class11/class1.dart';


class Allclass11 extends StatelessWidget {
  const Allclass11({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List itemsclasses = [
      "صنف(11/1)",
      "صنف(11/2)",
      "صنف(11/3)",
      "صنف(11/4)",
      "صنف(11/5)",
      "صنف(11/6)",
      "صنف(11/7)",
      "صنف(11/8)",
      "صنف(11/9)",
      "صنف(11/10)",
      "صنف(11/11)",
      "صنف(11/12)",
      "صنف(11/13)",
      "صنف(11/14)",
      "صنف(11/15)",

    ];
    List page = [
    const class_11_1(),
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
          itemCount: itemsclasses.length,
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
                      title: Text(itemsclasses[index],textAlign: TextAlign.right,),
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
