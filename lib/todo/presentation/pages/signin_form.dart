import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/customTextField.dart';
import '../widgets/errorWidgets.dart';
import 'todolistscreen.dart';

class SignIn extends StatefulWidget {
  final void Function()? onTap;
  const SignIn({super.key, this.onTap});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final bool _isLogin = true;

  startAuthentication() async {
    if (_formKey.currentState != null) {
      final isValid = _formKey.currentState!.validate();
      FocusScope.of(context).unfocus();

      if (isValid) {
        _formKey.currentState!.save();
        submitForm(_emailController.text.toString(),
            _passwordController.text.toString());
      }
    }
  }

  submitForm(String email, String password) async {
    final auth = FirebaseAuth.instance;
    // ignore: unused_local_variable
    UserCredential userCredential;
    try {
      if (_isLogin) {
        userCredential = await auth.signInWithEmailAndPassword(
            email: email, password: password);
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

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                      hintText: 'someone@exmaple.com'),
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
                      'SignIn',
                      style: TextStyle(color: Colors.amber, fontSize: 20),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('    Don\'t have an account?'),
                      TextButton(
                          onPressed: () {
                            widget.onTap!(); // Call the onTap function
                          },
                          child: const Text('Sign Up'))
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
