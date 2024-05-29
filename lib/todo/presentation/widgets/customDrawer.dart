import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../auth_gate.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String email = 'null';
  String username = 'null';
  late final FirebaseFirestore firestore;
  late final FirebaseAuth firebaseAuth;
  late final String userUID;
  late final DocumentReference docRef;

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    firebaseAuth = FirebaseAuth.instance;
    userUID = firebaseAuth.currentUser!.uid;
    docRef = firestore.collection('AllUsers').doc(userUID);

    docRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          email = documentSnapshot.get('email');
          username = documentSnapshot.get('username');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Theme.of(context).colorScheme.onPrimary,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: Colors.amber, fontSize: 24),
                          ),
                          Text(
                            email,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.amber),
                          ),
                        ],
                      )
                    ],
                  ),
                  Divider(
                    indent: 10,
                    endIndent: 10,
                    height: 20,
                    thickness: 2,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () async {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const AuthGate()));
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout_rounded),
                      Text('LogOut'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
