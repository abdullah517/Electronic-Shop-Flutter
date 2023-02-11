import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:semesterproject/forgetpassword.dart';
import 'package:semesterproject/home.dart';
import 'package:semesterproject/signup.dart';
import 'package:semesterproject/textfielddec.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purpleAccent,
              Colors.lightBlue,
              Colors.indigoAccent
            ]),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
              child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.8,
            child: CustomForm(),
          ))),
    );
  }
}

class CustomForm extends StatefulWidget {
  const CustomForm({super.key});

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController passcontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  bool passvisibility = true;
  FirebaseAuth _auth = FirebaseAuth.instance;
  var errormessage1 = null, errormessage2 = null;

  void setpassvisibility() {
    setState(() {
      passvisibility = !passvisibility;
    });
  }

  Future<void> login() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      try {
        await _auth
            .signInWithEmailAndPassword(
                email: emailcontroller.text, password: passcontroller.text)
            .then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Homepage(),
                )));
      } on FirebaseAuthException catch (error) {
        if (error.code == 'wrong-password') {
          setState(() {
            errormessage1 = "Incorrect Password!";
          });
        } else {
          setState(() {
            errormessage1 = null;
          });
        }
        if (error.code == 'user-not-found') {
          setState(() {
            errormessage2 = "User email not found";
          });
        } else {
          setState(() {
            errormessage2 = null;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Login to your Account",
            style: TextStyle(
                fontSize: 31,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              controller: emailcontroller,
              style: TextStyle(fontSize: 22),
              decoration: InputDecoration(
                errorText: errormessage2,
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
                if (EmailValidator.validate(value) == false)
                  return "Please enter a valid email";
                return null;
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              style: TextStyle(fontSize: 22),
              controller: passcontroller,
              obscureText: passvisibility,
              decoration: InputDecoration(
                  errorText: errormessage1,
                  focusedBorder: getfocusedborder(),
                  enabledBorder: getenabledborder(),
                  errorBorder: geterrorborder(),
                  focusedErrorBorder: geterrorfocusedborder(),
                  hintText: "Password",
                  hintStyle: TextStyle(fontSize: 22),
                  errorStyle: TextStyle(fontSize: 18),
                  suffixIcon: IconButton(
                    onPressed: setpassvisibility,
                    icon: passvisibility
                        ? Icon(
                            Icons.visibility_off,
                            color: Colors.black,
                          )
                        : Icon(Icons.visibility),
                    color: Colors.black,
                  )),
              validator: (value) {
                if (value!.isEmpty) return "this field is required";
                return null;
              },
            ),
          ),
          InkWell(
            child: Text("Forgot password?",
                style: TextStyle(color: Colors.amberAccent, fontSize: 22)),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => forgetpass(),
                )),
          ),
          SizedBox(
            width: 280,
            height: 50,
            child: ElevatedButton(
              onPressed: () => login(),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 22),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: TextStyle(fontSize: 22, color: Colors.amberAccent),
                textAlign: TextAlign.center,
              ),
              InkWell(
                child: Text("Signup",
                    style: TextStyle(color: Colors.amber, fontSize: 20)),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Signup(),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
