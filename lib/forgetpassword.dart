import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:semesterproject/gradientappbar.dart';
import 'package:semesterproject/gradientbutton.dart';
import 'package:semesterproject/login.dart';
import 'package:semesterproject/textfielddec.dart';

class forgetpass extends StatelessWidget {
  const forgetpass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Getappbar("Forgot Password"),
      body: Center(
        child: Myform(),
      ),
    );
  }
}

class Myform extends StatefulWidget {
  const Myform({super.key});

  @override
  State<Myform> createState() => _MyformState();
}

class _MyformState extends State<Myform> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  var errormessage = null;

  void proceed() {
    if (formkey.currentState!.validate()) {
      _auth.fetchSignInMethodsForEmail(emailcontroller.text).then((value) {
        if (value.isNotEmpty) {
          setState(() {
            errormessage = null;
          });
          _auth
              .sendPasswordResetEmail(email: emailcontroller.text)
              .then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Email sent successfully")));
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => login(),
                ));
          }).onError((error, stackTrace) => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text(error.toString()),
                      )));
        } else {
          setState(() {
            errormessage = "Email not found";
          });
        }
      }).onError((error, stackTrace) => null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formkey,
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Text(
            "Forgot Password?",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Text(
            "Please enter your email and we will send\n  you a link to reset your password",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              style: TextStyle(fontSize: 18),
              controller: emailcontroller,
              decoration: InputDecoration(
                errorText: errormessage,
                focusedBorder: getfocusedborder(),
                enabledBorder: getenabledborder(),
                errorBorder: geterrorborder(),
                focusedErrorBorder: geterrorfocusedborder(),
                hintText: "Email",
                hintStyle: TextStyle(fontSize: 22),
                errorStyle: TextStyle(fontSize: 18),
              ),
              validator: (value) {
                if (value!.isEmpty) return "this field is required";
                if (EmailValidator.validate(emailcontroller.text) == false)
                  return "Please enter a valid email";
                return null;
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          gradientbtn(btntext: "Send Code", func: proceed),
        ]));
  }
}
