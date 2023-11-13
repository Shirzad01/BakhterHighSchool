import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:newproject/classes/All_Class.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Teachers/Teachers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(context) {
    List items = [
      "اساتید",
      "صنوف",
    ];
    List page = [
      const Teachers(),
      const classes()
    ];
    List icons = [
      Icons.man,
      Icons.home_filled,
    ];
   /* List itemDrawer = [
      "تماس با ما",
      "درباره ما",
    ];
    List pageDrawer = [
      const call(),
    ];

    */
    int i = 1;
    int f = 2;
    double _w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => onBeckButtonPressed(context),
      child: Scaffold(
       /* drawer: Drawer(
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: ListView.builder(
                  itemCount: itemDrawer.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                        delay: const Duration(milliseconds: 100),
                        position: f,
                        child: SlideAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            horizontalOffset: 30,
                            child: FlipAnimation(
                              duration: const Duration(milliseconds: 3000),
                              curve: Curves.fastLinearToSlowEaseIn,
                              flipAxis: FlipAxis.y,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: EdgeInsets.only(bottom: _w / 30),
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
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: SizedBox(
                                    height: 30,
                                    child: ListTile(
                                      title: Text(
                                        itemDrawer[index],
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    pageDrawer[index]));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            )));
                  }),
            )),

        */
        appBar: AppBar(
            title: const Text("صفحه اصلی"),
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
                        leading: Icon(icons[index],color: Colors.black,),
                        title: Text(
                          items[index],
                          textAlign: TextAlign.right,style: const TextStyle(fontSize: 20),
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
      ),
    );
  }

 Future<bool> onBeckButtonPressed(BuildContext context) async{
    bool?  exitApp = await showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text("آیا؟",textAlign: TextAlign.right,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            content: const Text("از برنامه خارج میشوید؟",textAlign: TextAlign.right,style: TextStyle(fontSize: 20),),
            actions: <Widget> [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop(false);
                  },
                  child: const Text("نخیر",style: TextStyle(fontSize: 20),)),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("بلی",style: TextStyle(fontSize: 20),))
            ],
          );

        });
    return exitApp ?? false;

 }
}

//  تماس با ما

class call extends StatelessWidget {
  const call({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تماس با ما"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: (){
                      launchUrl('https://www.facebook.com/profile.php?id=100090313382122' as Uri);
                    }, icon: const Icon(Icons.facebook,color: Colors.blue,size: 50,)),
                IconButton(
                    onPressed: (){
                      launchUrl('https://wa.me/+93767684451' as Uri);
                    }, icon: const Icon(Icons.telegram,color: Colors.blue,size: 50,)),
              ],
            ),
          )
          ]
      ),
    );
  }
}

// Page Transition
class ScaleTransition6 extends PageRouteBuilder {
  final Widget page;

  ScaleTransition6(this.page)
      : super(
    pageBuilder: (context, animation, anotherAnimation) => page,
    transitionDuration: const Duration(milliseconds: 1000),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, anotherAnimation, child) {
      animation = CurvedAnimation(
          curve: Curves.fastLinearToSlowEaseIn,
          parent: animation,
          reverseCurve: Curves.fastOutSlowIn);
      return ScaleTransition(
        alignment: Alignment.centerRight,
        scale: animation,
        child: child,
      );
    },
  );
}
