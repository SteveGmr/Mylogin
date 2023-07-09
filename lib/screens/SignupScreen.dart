import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mylogin/colors.dart';
import 'package:mylogin/screens/HomeScreen.dart';
import 'package:mylogin/screens/LoginScreen.dart';
import 'package:mylogin/widgets/MyButton.dart';
import 'package:mylogin/widgets/MyTextField.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool mypass = true;
  var keyform = GlobalKey<FormState>();
  TextEditingController namecontroler = TextEditingController();
  TextEditingController emailcontroler = TextEditingController();
  TextEditingController passwordcontroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: SvgPicture.asset(
              'images/arrow_back.svg',
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: keyform,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hi!',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Create a new account',
                    style: TextStyle(
                      fontSize: 17,
                      letterSpacing: 1.7,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  MyTextField(
                    mycontroler: namecontroler,
                    mytextfieldtext: 'Enter your name',
                    showpass: false,
                    myvalidate: (name) {
                      if (name.length < 7) {
                        return 'Enter min 7 characters';
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  MyTextField(
                    mycontroler: emailcontroler,
                    myvalidate: (email) {
                      if (email.isEmpty) {
                        return 'Email sould not be empty !';
                      } else if (!EmailValidator.validate(email)) {
                        return 'Enter a valid email';
                      } else {
                        return null;
                      }
                    },
                    mykeyboardtype: TextInputType.emailAddress,
                    showpass: false,
                    mytextfieldtext: 'Enter your email',
                  ),
                  SizedBox(height: 20),
                  MyTextField(
                    mycontroler: passwordcontroler,
                    myvalidate: (pass) {
                      if (pass.length < 8) {
                        return 'Enter min 8 characters';
                      }
                    },
                    mykeyboardtype: TextInputType.visiblePassword,
                    showpass: mypass,
                    mytextfieldtext: 'Enter your password',
                    mysufixicon:
                        mypass ? Icons.visibility : Icons.visibility_off,
                    mysufixclick: () {
                      setState(() {
                        mypass = !mypass;
                      });
                    },
                  ),
                  SizedBox(height: 40),
                  MyButton(
                    mybtntext: 'Signup',
                    mybtntextcolor: Colors.white,
                    mybtncolor: Myblue,
                    mybtnbordercolor: Colors.transparent,
                    mybtnborderwidth: 0.0,
                    mybtnclicked: () {
                      final isvalidate = keyform.currentState!.validate();

                      if (isvalidate) {
                        Get.offAll(
                          HomeScreen(
                            name: namecontroler.text,
                            email: emailcontroler.text,
                            password: passwordcontroler.text,
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Login with social media'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          launchUrlString('https://www.google.com/');
                        },
                        child: SvgPicture.asset('images/google.svg'),
                      ),
                      GestureDetector(
                        onTap: () {
                          launchUrlString('https://www.facebook.com/');
                        },
                        child: SvgPicture.asset('images/facebook.svg'),
                      ),
                      GestureDetector(
                        onTap: () {
                          launchUrlString('https://www.icloud.com/?id=123');
                        },
                        child: SvgPicture.asset('images/apple.svg'),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Allredy have an account?'),
                      SizedBox(width: 7),
                      GestureDetector(
                        onTap: () {
                          Get.off(LoginScreen());
                        },
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: Myblue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
