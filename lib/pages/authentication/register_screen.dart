import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/routes.dart';
import '../../core/utils/validators.dart';
import '../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 310,
                decoration: BoxDecoration(
                  color: Color(0xFF6D77FB),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70),
                  ),
                ),
              ),
              SizedBox(height: 100), // Adjust height as needed
            ],
          ),
          Positioned(
            top: 210, // Adjust the position as needed
            left: 10,
            right: 10,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color(0xFF6D77FB),
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      SizedBox(height: 30),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(
                                  color: Color(0xFF6D77FB),
                                  width: 3,
                                  style: BorderStyle.solid)),
                          hintText: "Email",
                          labelText: "Email",
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(
                                  color: Color(0xFF6D77FB),
                                  width: 3,
                                  style: BorderStyle.solid)),
                          hintText: "Password",
                          labelText: "Password",
                        ),
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        height: 45,
                        width: 310,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Color(0xFF6D77FB)),
                            textStyle: WidgetStateProperty.all(
                                TextStyle(color: Colors.white)),
                          ),
                          onPressed: () {
                            Register(authService);
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 575,
              left: 85,
              right: 20,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                  child: Text(
                    "Already have an account? Login Now",
                    style: TextStyle(color: Color(0xFF6D77FB), fontSize: 14),
                  )))
        ],
      ),
    );
  }

  Future<void> Register(AuthService service) async {
    await service.signUp(emailController.text.toString().trim(),
        passwordController.text.toString().trim());
    await service.login(emailController.text.toString().trim(),
        passwordController.text.toString().trim());

    if (Validators.validateEmail(emailController.text.toString().trim()) &&
        Validators.validatePassword(
            passwordController.text.toString().trim())) {}
  }
}
