// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TaskServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  late Timestamp timestamp;
  late DateTime date;
  late String formattedDate;

  void addTask(String title, String description, String formattedDate,
      bool completed, BuildContext context) async {
    if (title.isNotEmpty && description.isNotEmpty) {
      try {
        var userUID = auth.currentUser!.uid;
        await firestore
            .collection('AllUsers')
            .doc(userUID)
            .collection('Tasks')
            .doc(formattedDate)
            .set({
          'title': title,
          'description': description,
          'completed': completed,
          'timestamp': formattedDate,
        });
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  void updateTask(String title, String description, String formattedDate,
      bool completed, BuildContext context) async {
    if (title.isNotEmpty && description.isNotEmpty) {
      try {
        var userUID = auth.currentUser!.uid;
        await firestore
            .collection('AllUsers')
            .doc(userUID)
            .collection('Tasks')
            .doc(formattedDate)
            .update({
          'title': title,
          'description': description,
          'completed': completed,
          'timestamp': formattedDate,
        });
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  void markTask(
      String formattedDate, bool completed, BuildContext context) async {
    try {
      var userUID = auth.currentUser!.uid;
      await firestore
          .collection('AllUsers')
          .doc(userUID)
          .collection('Tasks')
          .doc(formattedDate)
          .update({'completed': completed});
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void deleteTask(String formattedDate, BuildContext context) async {
    try {
      var userUID = auth.currentUser!.uid;
      await firestore
          .collection('AllUsers')
          .doc(userUID)
          .collection('Tasks')
          .doc(formattedDate)
          .delete();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTasks() {
    final uid = auth.currentUser!.uid;
    return firestore
        .collection('AllUsers')
        .doc(uid)
        .collection('Tasks')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
