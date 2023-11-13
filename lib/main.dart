import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newproject/SplashScreen.dart';

import 'HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      title: 'Bakhter High School',
      debugShowCheckedModeBanner: false,
      home:  MyCustomSplashScreen(),
    );
  }
}

//Login UI

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool onoff = true;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: formkey,
        child: Container(
          decoration: BoxDecoration(
            color: myColor,
            image: DecorationImage(
              image: const AssetImage("photos/bakhterschool.jpg"),
              fit: BoxFit.cover,
              colorFilter:
              ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop),
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(children: [
              Positioned(top: 80, child: _buildTop()),
              Positioned(bottom: 0, child: _buildBottom()),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.school,
            size: 100,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome",
          style: TextStyle(
              color: Colors.indigo[900], fontSize: 32, fontWeight: FontWeight.w500),
        ),
        _buildGreyText("Please login with your information"),
        const SizedBox(height: 30),
        _buildGreyText("User Name"),
        _buildInputField(userNameController),
        const SizedBox(height: 20),
        _buildGreyText("Password"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 10),
        const SizedBox(height: 10),
        _buildLoginButton(this.context),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Password and UserName required";
        }
      },
      controller: controller,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            color: Colors.indigo[900],
        onPressed: () {
          setState(() {
            onoff = !onoff;
          });
        },
        icon: Icon(onoff ? Icons.visibility_off : Icons.visibility),
      )),
      obscureText: onoff,
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formkey.currentState!.validate()) if (userNameController.text ==
                "Bakhter High School" &&
            passwordController.text == "Admin") {
          Navigator.push(context ,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                duration: const Duration(milliseconds: 700),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  backgroundColor: Colors.indigo[900],
                  content: const Text("Username and Password is Incorrect")));
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo[900],
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("LOGIN"),
    );
  }
}

