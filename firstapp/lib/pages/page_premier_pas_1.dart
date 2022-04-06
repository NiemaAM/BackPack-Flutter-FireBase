import 'dart:io';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/pages/page_premier_pas_2.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:firstapp/widgets/champ_mdp.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remove_emoji/remove_emoji.dart';

// ignore: camel_case_types
class premier_pas_1 extends StatefulWidget {
  premier_pas_1({this.app});
  final FirebaseApp app;

  @override
  _premier_pas_1State createState() => _premier_pas_1State();
}

// ignore: camel_case_types
class _premier_pas_1State extends State<premier_pas_1> {
  final referenceDatabase = FirebaseDatabase.instance;
  String Nom = "mdp";
  String id = "id";
  var remove = RemoveEmoji();
  String idParent = "${Random().nextInt(100)}";
  DatabaseReference _MotDePasse =
      FirebaseDatabase.instance.reference().child("MotDePasse");
  DatabaseReference _id =
      FirebaseDatabase.instance.reference().child("idParent");
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference();
    CollectionReference parent =
        FirebaseFirestore.instance.collection('Parent');
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/page_parents.png"),
                  fit: BoxFit.cover)),
          child: Container(
              margin: const EdgeInsets.all(30),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: width,
                    height: height / 2,
                    child: AppText(text: "Espace de contrôle parental"),
                  ),
                  Container(
                      width: width,
                      height: width / 10,
                      child: AppText(
                        text: "Creér un mot de passe",
                        size: 30,
                      )),
                  Container(
                    width: width / 1.5,
                    height: width / 6,
                    child: TextField(
                      controller: myController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      showCursor: true,
                      style: TextStyle(fontSize: 30),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  /* 
                  StreamBuilder(
                      stream: parent.snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: Text("..."));
                        }
                        return ListView(
                          children: snapshot.data.docs.map((parent) {
                            return Center(
                              child: ListTile(
                                title: Text(parent['idParent']),
                              ),
                            );
                          }).toList(),
                        );
                      }), */
                  SizedBox(
                    height: width / 8,
                  ),
                  Container(
                      width: width / 3,
                      height: width / 7,
                      child: ElevatedButton(
                        onPressed: () {
                          if (remove.removemoji(myController.text) !=
                              myController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: AppText(
                                text:
                                    'Le mot de passe ne peut pas contenir des emojis',
                                size: 15,
                                color: Colors.white,
                              ),
                            ));
                          } else if (myController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: AppText(
                                text:
                                    'Veillez saisir un mot de passe parentale',
                                size: 15,
                                color: Colors.white,
                              ),
                            ));
                          } else if (remove
                                  .removemoji(myController.text)
                                  .length <
                              5) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: AppText(
                                text:
                                    'Le mot de passe doit contenir minimum 5 caractéres',
                                size: 15,
                                color: Colors.white,
                              ),
                            ));
                          } else {
                            ref.update({
                              "Parent": {
                                "MotDePasse":
                                    remove.removemoji(myController.text),
                                "id": idParent,
                              }
                            });
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => premier_pas_2()));
                          }
                        },
                        child: AppText(
                          text: "Suivant",
                          size: 40,
                          color: Colors.white,
                        ),
                      )),
                ],
              ))),
    );
  }
}
