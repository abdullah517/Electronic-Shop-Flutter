import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_ui/containerui.dart';
import 'package:ecommerce_ui/globalcolours.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Userinfo extends StatelessWidget {
  const Userinfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            getcontainer(context, 'Profile', 'Information'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Text(
              'Complete your Profile',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic),
            ),
            Infoform()
          ],
        ),
      )),
    );
  }
}

class Infoform extends StatefulWidget {
  const Infoform({super.key});

  @override
  State<Infoform> createState() => _InfoformState();
}

class _InfoformState extends State<Infoform> {
  final _formkey = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final numbercontroller = TextEditingController();
  final _namekey = GlobalKey<FormFieldState>();
  final _addresskey = GlobalKey<FormFieldState>();
  final _numberkey = GlobalKey<FormFieldState>();
  FocusNode numbernode = FocusNode();
  FocusNode addressnode = FocusNode();

  final firestore = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid);

  void saveinfo() {
    if (_formkey.currentState!.validate()) {
      firestore.doc("user information").set({
        'Username': namecontroller.text,
        'Phone number': numbercontroller.text,
        'Address': addresscontroller.text
      }).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Information Saved")));

        Navigator.pop(context);
      });
    }
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
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              key: _namekey,
              style: TextStyle(fontSize: 22),
              controller: namecontroller,
              decoration: InputDecoration(
                hintText: "Enter full name",
                hintStyle: TextStyle(fontSize: 22),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              onChanged: (value) {
                _namekey.currentState!.validate();
              },
              onFieldSubmitted: (value) {
                numbernode.requestFocus();
              },
              validator: (value) {
                if (value!.isEmpty) return "this field is required";
                return null;
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              key: _numberkey,
              style: TextStyle(fontSize: 22),
              controller: numbercontroller,
              decoration: InputDecoration(
                hintText: "Phone no",
                hintStyle: TextStyle(fontSize: 22),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              onChanged: (value) {
                _numberkey.currentState!.validate();
              },
              onFieldSubmitted: (value) {
                addressnode.requestFocus();
              },
              validator: (value) {
                if (value!.isEmpty)
                  return "this field is required";
                else if (value.length != 11)
                  return "Please enter valid mobile number";
                return null;
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              key: _addresskey,
              style: TextStyle(fontSize: 22),
              controller: addresscontroller,
              decoration: InputDecoration(
                hintText: "Enter your address",
                hintStyle: TextStyle(fontSize: 22),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              onChanged: (value) {
                _addresskey.currentState!.validate();
              },
              validator: (value) {
                if (value!.isEmpty) return "this field is required";
                return null;
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          SizedBox(
            width: 280,
            height: 50,
            child: ElevatedButton(
              onPressed: () => saveinfo(),
              child: Text(
                "Save",
                style: TextStyle(fontSize: 22),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalColors.mainColor),
            ),
          ),
        ],
      ),
    );
  }
}
