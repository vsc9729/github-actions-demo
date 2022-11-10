import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_project/services/auth_service.dart';
import 'package:navigation_project/utils/responsive/scale_config.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool? doesNotMatch;
  @override
  void didChangeDependencies() {
    ScaleConfig().init(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  onChanged: ((value) {
                    if (value != passwordController.text) {
                      setState(() {
                        doesNotMatch = true;
                      });
                    } else {
                      setState(() {
                        doesNotMatch = false;
                      });
                    }
                  }),
                  obscureText: true,
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Confirm Password',
                      errorText: doesNotMatch == null
                          ? null
                          : doesNotMatch == true
                              ? "Password does not match"
                              : null),
                ),
              ),
              SizedBox(
                height: ScaleConfig().scaleHeight(10),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Create Account'),
                    onPressed: () async {
                      if (confirmPasswordController.text ==
                          passwordController.text) {
                        await AuthService(FirebaseAuth.instance)
                            .singUpWithEmail(
                          email: emailController.text,
                          password: confirmPasswordController.text,
                          context: context,
                        );
                        if (AuthService(FirebaseAuth.instance).isLoggedIn()) {
                          context.goNamed("home");
                        }
                      } else {}
                    },
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      context.goNamed("login");
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
