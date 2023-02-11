import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Userinfo extends StatelessWidget {
  const Userinfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.purpleAccent]),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.indigo),
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Infoform()),
        ),
      ),
    );
  }
}

class Infoform extends StatefulWidget {
  const Infoform({super.key});

  @override
  State<Infoform> createState() => _InfoformState();
}

class _InfoformState extends State<Infoform> {
  final formkey = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final numbercontroller = TextEditingController();

  final firestore = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid);

  void saveinfo() {
    if (formkey.currentState!.validate()) {
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
      key: formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Complete your Profile",
            style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 32,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              style: TextStyle(fontSize: 22),
              controller: namecontroller,
              decoration: InputDecoration(
                  hintText: "Enter full name",
                  hintStyle: TextStyle(fontSize: 22)),
              validator: (value) {
                if (value!.isEmpty) return "this field is required";
                return null;
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              style: TextStyle(fontSize: 22),
              controller: numbercontroller,
              decoration: InputDecoration(
                  hintText: "Phone no", hintStyle: TextStyle(fontSize: 22)),
              validator: (value) {
                if (value!.isEmpty) return "this field is required";
                return null;
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              style: TextStyle(fontSize: 22),
              controller: addresscontroller,
              decoration: InputDecoration(
                  hintText: "Enter your address",
                  hintStyle: TextStyle(fontSize: 22)),
              validator: (value) {
                if (value!.isEmpty) return "this field is required";
                return null;
              },
            ),
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
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            ),
          ),
        ],
      ),
    );
  }
}
