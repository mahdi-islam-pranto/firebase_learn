import 'package:firelearn/ui/auth/signup_screen.dart';
import 'package:firelearn/ui/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "LOGIN",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Email and Password form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email field
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Email";
                          }
                          if (value.contains("@") == false) {
                            return "Invalid Email";
                          }

                          return null;
                        },
                        controller: emailController,
                        decoration: const InputDecoration(
                            hintText: "Email", prefixIcon: Icon(Icons.email)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // Password field
                      TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Password";
                          }
                          return null;
                        },
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: "Password", prefixIcon: Icon(Icons.lock)),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  )),
            ),

            // Login button
            Center(
              child: RoundButton(
                title: 'Login',
                onTap: () {
                  if (_formKey.currentState!.validate()) {}
                },
              ),
            ),

            // SignUP Text

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Signup(),
                          ));
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
