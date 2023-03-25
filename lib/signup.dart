import 'package:ecommerce_ui/login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'containerui.dart';
import 'globalcolours.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            getcontainer(context, 'Join', 'Electro Elite'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Text(
              'Create your Account',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic),
            ),
            Signupform()
          ],
        ),
      )),
    );
  }
}

class Signupform extends StatefulWidget {
  const Signupform({super.key});

  @override
  State<Signupform> createState() => _SignupformState();
}

class _SignupformState extends State<Signupform> {
  final _formkey = GlobalKey<FormState>();
  final _emailkey = GlobalKey<FormFieldState>();
  final _passwordkey = GlobalKey<FormFieldState>();
  final _confirmkey = GlobalKey<FormFieldState>();
  FocusNode passwordnode = FocusNode();
  FocusNode confirmnode = FocusNode();
  final TextEditingController passcontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController confirmcontroller = TextEditingController();
  bool passvisibility = true;
  FirebaseAuth _auth = FirebaseAuth.instance;
  var errormessage = null;

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
    if (_formkey.currentState!.validate()) {
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

  void setpassvisibility() {
    setState(() {
      passvisibility = !passvisibility;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordnode.dispose();
    confirmnode.dispose();
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
              key: _emailkey,
              controller: emailcontroller,
              decoration: InputDecoration(
                  errorText: errormessage,
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

                checkemailexistance();
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
              onFieldSubmitted: (value) {
                confirmnode.requestFocus();
              },
              validator: (value) {
                if (value!.isEmpty) return "this field is required";

                String pattern =
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                RegExp regExp = new RegExp(pattern);
                return regExp.hasMatch(value) ? null : "Weak Password";
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          SizedBox(
            width: 280,
            child: TextFormField(
              controller: confirmcontroller,
              focusNode: confirmnode,
              key: _confirmkey,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                hintText: "Confirm Password",
              ),
              onChanged: (value) {
                _confirmkey.currentState!.validate();
              },
              validator: (value) {
                if (value!.isEmpty) return "this field is required";

                return value == passcontroller.text
                    ? null
                    : "Password do not match";
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          SizedBox(
            width: 280,
            height: 50,
            child: ElevatedButton(
              onPressed: signup,
              child: Text(
                "Signup",
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
                "Already have an account?",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              InkWell(
                onTap: () => Get.to(Login()),
                child: Text(
                  "Login",
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
