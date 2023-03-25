import 'package:ecommerce_ui/globalcolours.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_ui/login.dart';
import 'package:get/get.dart';

class Forgetpass extends StatelessWidget {
  const Forgetpass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        backgroundColor: GlobalColors.mainColor,
      ),
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
  final _formkey = GlobalKey<FormState>();
  final _emailkey = GlobalKey<FormFieldState>();
  final TextEditingController emailcontroller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  var errormessage = null;

  void proceed() {
    if (_formkey.currentState!.validate()) {
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
            Get.to(Login());
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
        key: _formkey,
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
              key: _emailkey,
              decoration: InputDecoration(
                errorText: errormessage,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                hintText: "Email",
                hintStyle: TextStyle(fontSize: 22),
                errorStyle: TextStyle(fontSize: 18),
              ),
              onChanged: (value) {
                _emailkey.currentState!.validate();
              },
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
          SizedBox(
            width: 280,
            height: 50,
            child: ElevatedButton(
              onPressed: proceed,
              child: Text(
                "Send link",
                style: TextStyle(fontSize: 17),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalColors.mainColor),
            ),
          ),
        ]));
  }
}
