import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/customTextField.dart';
import '../widgets/errorWidgets.dart';
import 'todolistscreen.dart';

class SignUp extends StatefulWidget {
  final void Function()? onTap;
  const SignUp({super.key, this.onTap});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final bool _isLogin = true;

  startAuthentication() async {
    if (_formKey.currentState != null) {
      final isValid = _formKey.currentState!.validate();
      FocusScope.of(context).unfocus();

      if (isValid) {
        _formKey.currentState!.save();
        submitForm(
            _emailController.text.toString(),
            _usernameController.text.toString(),
            _passwordController.text.toString());
      }
    }
  }

  submitForm(String email, String username, String password) async {
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;
    UserCredential userCredential;
    try {
      if (_isLogin) {
        userCredential = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await firestore
            .collection('AllUsers')
            .doc(userCredential.user!.uid)
            .collection('UserInfo')
            .doc('UserDetails')
            .set({
          'uid': userCredential.user!.uid,
          'email': email,
          'username': username,
        });
      }
    } on FirebaseAuthException {
      if (mounted) {
        CustomError.errorDialog('Error', context);
      }
    } finally {
      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (builder) => const TodoListScreen()));
      }
    }
  }

  passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 8) {
      return 'Password must be more than 8 characters';
    }
    return null;
  }

  emailValidator(String value) {
    if (value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!value.contains('@')) {
      return 'Invalid email';
    }
    return null;
  }

  usernameValidator(String value) {
    if (value.isEmpty) {
      return 'Username cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    text: 'Email',
                    controller: _emailController,
                    icon: const Icon(Icons.alternate_email_rounded),
                    inputType: TextInputType.emailAddress,
                    hintText: 'someone@exmaple.com',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                      text: 'User Name',
                      controller: _usernameController,
                      icon: const Icon(Icons.person),
                      inputType: TextInputType.text,
                      hintText: 'Full Name'),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomPasswordField(
                      text: 'Password',
                      controller: _passwordController,
                      hintText: 'more than 8 characters'),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.purple),
                    ),
                    onPressed: startAuthentication,
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.amber, fontSize: 20),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('    Already have an account?'),
                      TextButton(
                          onPressed: () {
                            widget.onTap!(); // Call the onTap function
                          },
                          child: const Text('Sign In'))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
