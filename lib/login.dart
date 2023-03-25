import 'package:ecommerce_ui/forgetpassword.dart';
import 'package:ecommerce_ui/globalcolours.dart';
import 'package:ecommerce_ui/home.dart';
import 'package:ecommerce_ui/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'containerui.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            getcontainer(context, 'Welcome', 'Back'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Text(
              'Login to your account',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic),
            ),
            Loginform()
          ],
        ),
      )),
    );
  }
}

class Loginform extends StatefulWidget {
  const Loginform({super.key});

  @override
  State<Loginform> createState() => _LoginformState();
}

class _LoginformState extends State<Loginform> {
  void setpassvisibility() {
    setState(() {
      passvisibility = !passvisibility;
    });
  }

  final _formkey = GlobalKey<FormState>();
  final _emailkey = GlobalKey<FormFieldState>();
  final _passwordkey = GlobalKey<FormFieldState>();
  FocusNode passwordnode = FocusNode();
  bool passvisibility = true;
  FirebaseAuth _auth = FirebaseAuth.instance;
  var errormessage1 = null, errormessage2 = null;
  final TextEditingController passcontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();

  Future<void> login() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      try {
        await _auth
            .signInWithEmailAndPassword(
                email: emailcontroller.text, password: passcontroller.text)
            .then((value) => Get.to(Homepage()));
      } on FirebaseAuthException catch (error) {
        if (error.code == 'wrong-password') {
          setState(() {
            errormessage2 = "Incorrect Password!";
          });
        } else {
          setState(() {
            errormessage2 = null;
          });
        }
        if (error.code == 'user-not-found') {
          setState(() {
            errormessage1 = "User email not found";
          });
        } else {
          setState(() {
            errormessage1 = null;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordnode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          SizedBox(
            width: 280,
            child: TextFormField(
              controller: emailcontroller,
              key: _emailkey,
              decoration: InputDecoration(
                  errorText: errormessage1,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: "Enter email",
                  labelText: 'Email'),
              onChanged: (value) {
                _emailkey.currentState!.validate();
              },
              onFieldSubmitted: (value) {
                passwordnode.requestFocus();
              },
              validator: (value) {
                if (value!.isEmpty)
                  return "this field is required";
                else if (EmailValidator.validate(value) == false)
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
            child: TextFormField(
              controller: passcontroller,
              key: _passwordkey,
              focusNode: passwordnode,
              obscureText: passvisibility,
              decoration: InputDecoration(
                  errorText: errormessage2,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: "Enter Password",
                  labelText: 'Password',
                  suffixIcon: IconButton(
                      onPressed: setpassvisibility,
                      icon: passvisibility
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility))),
              onChanged: (value) {
                _passwordkey.currentState!.validate();
              },
              validator: (value) {
                if (value!.isEmpty) return "this field is required";

                return null;
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          InkWell(
            onTap: () => Get.to(Forgetpass()),
            child: Text(
              'Forgot password?',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          SizedBox(
            width: 280,
            height: 50,
            child: ElevatedButton(
              onPressed: login,
              child: Text(
                "Login",
                style: TextStyle(fontSize: 17),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalColors.mainColor),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              InkWell(
                onTap: () => Get.to(Signup()),
                child: Text(
                  "Signup",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: GlobalColors.mainColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
