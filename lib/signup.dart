import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:semesterproject/textfielddec.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

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
              child: SignUpForm()),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController passcontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController confirmcontroller = TextEditingController();
  bool passvisibility = true;
  FirebaseAuth _auth = FirebaseAuth.instance;
  var errormessage = null;

  void setpassvisibility() {
    setState(() {
      passvisibility = !passvisibility;
    });
  }

  void clearfields() {
    passcontroller.clear();
    emailcontroller.clear();
    confirmcontroller.clear();
  }

  Future<void> checkemailexistance() async {
    var method = await _auth.fetchSignInMethodsForEmail(emailcontroller.text);
    if (method.contains('password')) {
      setState(() {
        errormessage = 'email already exists';
      });
    } else {
      setState(() {
        errormessage = null;
      });
    }
  }

  void signup() {
    if (formkey.currentState!.validate()) {
      _auth
          .createUserWithEmailAndPassword(
              email: emailcontroller.text.toString(),
              password: passcontroller.text.toString())
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Account created successfully")));
        clearfields();
      }).onError((error, stackTrace) => null);
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
            "Create an Account",
            style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 32,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              controller: emailcontroller,
              style: TextStyle(fontSize: 22),
              decoration: InputDecoration(
                  errorText: errormessage,
                  focusedBorder: getfocusedborder(),
                  enabledBorder: getenabledborder(),
                  errorBorder: geterrorborder(),
                  focusedErrorBorder: geterrorfocusedborder(),
                  hintText: "Email",
                  hintStyle: TextStyle(fontSize: 22),
                  errorStyle: TextStyle(fontSize: 18)),
              validator: (value) {
                if (value!.isEmpty) return "this field is required";
                if (EmailValidator.validate(value) == false)
                  return "Please enter a valid email";
                checkemailexistance();
                return null;
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              controller: passcontroller,
              obscureText: passvisibility,
              style: TextStyle(fontSize: 22),
              decoration: InputDecoration(
                  focusedBorder: getfocusedborder(),
                  enabledBorder: getenabledborder(),
                  errorBorder: geterrorborder(),
                  focusedErrorBorder: geterrorfocusedborder(),
                  hintText: "Create Password",
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
                String pattern =
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                RegExp regExp = new RegExp(pattern);
                return regExp.hasMatch(value!) ? null : "Weak Password";
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              controller: confirmcontroller,
              style: TextStyle(fontSize: 22),
              decoration: InputDecoration(
                focusedBorder: getfocusedborder(),
                enabledBorder: getenabledborder(),
                errorBorder: geterrorborder(),
                focusedErrorBorder: geterrorfocusedborder(),
                hintText: "Confirm Password",
                hintStyle: TextStyle(fontSize: 22),
                errorStyle: TextStyle(fontSize: 18),
              ),
              validator: (value) =>
                  value == passcontroller.text ? null : "Password do not match",
            ),
          ),
          SizedBox(
            width: 280,
            height: 50,
            child: ElevatedButton(
              onPressed: () => signup(),
              child: Text(
                "SignUp",
                style: TextStyle(fontSize: 22),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(fontSize: 22, color: Colors.amberAccent),
              ),
              InkWell(
                child: Text("Login",
                    style: TextStyle(color: Colors.yellow, fontSize: 20)),
                onTap: () => Navigator.pop(context),
              )
            ],
          ),
        ],
      ),
    );
  }
}
