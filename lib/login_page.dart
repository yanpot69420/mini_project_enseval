import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_project/controller/login.dart';
import 'package:mini_project/main.dart';
import 'package:mini_project/model/user.dart';
import 'package:mini_project/widget_builder/text_widget.dart';
import 'package:mini_project/widget_builder/what_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 215, 249, 216),
      body: Container(
        // color: Colors.white,
        margin: const EdgeInsets.all(40.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    color: Colors.white),
                child: Center(
                  child: Image.asset('images/logo_enseval.jpg', width: 400),
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(40.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      image: DecorationImage(
                          image: AssetImage('images/green_abstract.png'),
                          fit: BoxFit.cover)),
                  child: Form(
                    key: _formKey,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Heading(text: 'SIGN IN'),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: 400,
                            child: TextField(
                              text: 'Username',
                              prefixIcon: Icons.person,
                              controller: usernameController,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 400,
                            child: PasswordField(
                              controller: passwordController,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // SubmitButton(
                          //   username: usernameController.text,
                          //   password: passwordController.text,
                          // )
                          Container(
                            width: 200,
                            height: 35,
                            child: TextButton(
                                onPressed: () async {
                                  String username = usernameController.text;
                                  String password = passwordController.text;

                                  print('username = $username');
                                  print('password = $password');
                                  var temp = await LoginController().fetchUser(
                                      User(
                                          username: username,
                                          password: password));

                                  if (temp) {
                                    Get.toNamed('/main');
                                  } else {
                                    Get.snackbar('Error',
                                        "Incorrect username or password!",
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.BOTTOM,
                                        margin: const EdgeInsets.only(
                                            bottom: 5, left: 5, right: 5));
                                  }

                                  // Get.toNamed('/main');
                                },
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.green,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class TextField extends StatelessWidget {
  final String text;
  final IconData prefixIcon;
  final TextEditingController controller;
  const TextField(
      {super.key,
      required this.text,
      required this.prefixIcon,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0)),
        prefixIcon: Icon(prefixIcon, size: 25),
        hintText: text,
        labelText: text,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  const PasswordField({super.key, required this.controller});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: isObscure,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10.0)),
          prefixIcon: const Icon(Icons.lock, size: 25),
          suffixIcon: IconButton(
            onPressed: toggleVisibility,
            icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
          ),
          hintText: 'Password',
          labelText: 'Password',
          filled: true,
          fillColor: Colors.white),
      keyboardType: TextInputType.visiblePassword,
    );
  }

  void toggleVisibility() {
    setState(() {
      isObscure = !isObscure;
    });
  }
}

class SubmitButton extends StatefulWidget {
  final String username;
  final String password;
  const SubmitButton(
      {super.key, required this.username, required this.password});

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 35,
      child: TextButton(
          onPressed: () {
            print('username = ${widget.username}');
            print('password = ${widget.password}');
            // Get.toNamed('/main');
          },
          child: Text(
            'LOGIN',
            style: TextStyle(color: Colors.white),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,
          )),
    );
  }
}
