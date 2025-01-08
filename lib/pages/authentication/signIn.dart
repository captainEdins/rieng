import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:rieng/pages/authentication/forgotPassword.dart';
import 'package:rieng/pages/authentication/signUp.dart';
import 'dart:math' as math;

import 'package:rieng/resources/color.dart';
import 'package:rieng/resources/string.dart';
import 'package:rieng/util/openPage.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController getEmail = TextEditingController();
  TextEditingController getPassword = TextEditingController();
  bool value = false;
  bool _obscured = true;
  final textFieldFocusNode = FocusNode();

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return;
      } // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
      false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorList.white,
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                  height: (MediaQuery.of(context).size.height / 4) + 40,
                  color: ColorList.appGreen,
                ),
              ),
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                  height: (MediaQuery.of(context).size.height / 4) + 30,
                  color: ColorList.appBlack,
                  child: logoComponents(),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(
                  left: 10,
                  right: 10),
              children: [
                const Row(
                  children: [
                    Text(
                      "Sign ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: ColorList.appBlack,
                          fontSize: 45),
                    ),
                    Text(
                      "In",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: ColorList.appGreen,
                          fontSize: 45),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      "Welcome Back ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: ColorList.appBlack,
                          fontSize: 15),
                    ),
                    Text(
                      ",",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: ColorList.appGreen,
                          fontSize: 15),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      "You have been Missed",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: ColorList.appBlack,
                          fontSize: 15),
                    ),
                    Text(
                      ".",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: ColorList.appGreen,
                          fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                emailInput(),
                const SizedBox(
                  height: 10,
                ),
                passwordInput(),
                const SizedBox(
                  height: 20,
                ),
                forgetPassword(),
                const SizedBox(
                  height: 30,
                ),
                buttonLogin(),
                firstTime()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget emailInput() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            cursorColor: ColorList.appBlack,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: ColorList.appBlack,
              fontSize: 15,
            ),
            controller: getEmail,
            decoration: InputDecoration(
              filled: true,
              fillColor: ColorList.appBlack.withOpacity(.1),
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.mail_rounded,
                size: 24,
                color: ColorList.appBlack,
              ),
              hintText: 'Email',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:  BorderSide(
                    width: 1, color: ColorList.appBlack.withOpacity(.1)), //<-- SEE HERE
              ),
              labelStyle: const TextStyle(
                color: ColorList.appBlack,
                fontSize: 15,
              ),
              hintStyle: const TextStyle(
                  color: ColorList.appBlack,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:  BorderSide(width: 1, color: ColorList.appBlack.withOpacity(.1)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget passwordInput() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            keyboardType: TextInputType.text,
            cursorColor: ColorList.appBlack,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: ColorList.appBlack,
              fontSize: 15,
            ),
            controller: getPassword,
            obscureText: _obscured,
            focusNode: textFieldFocusNode,
            decoration: InputDecoration(
              filled: true,
              fillColor: ColorList.appBlack.withOpacity(.1),
              border: InputBorder.none,
              hintText: 'Password',
              hintStyle: const TextStyle(
                  color: ColorList.appBlack,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
              prefixIcon: const Icon(
                Icons.lock_rounded,
                size: 24,
                color: ColorList.appBlack,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: GestureDetector(
                  onTap: _toggleObscured,
                  child: Icon(
                    _obscured
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    size: 24,
                    color: ColorList.appBlack,
                  ),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:  BorderSide(
                    width: 1, color: ColorList.appBlack.withOpacity(.1)), //<-- SEE HERE
              ),
              labelStyle: const TextStyle(
                color: ColorList.appBlack,
                fontSize: 15,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:  BorderSide(width: 1, color: ColorList.appBlack.withOpacity(.1)),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget forgetPassword() {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: (){
          pushNotReplacement(classReplace: ForgotPassword());
          },
          child: Text(
            "Forgot Password?",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: ColorList.appBlack,
                fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget buttonLogin() {
    return InkWell(
      onTap: () {


      },
      child: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: ColorList.appBlack,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(
            color: ColorList.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget firstTime() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30,
      ),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        //color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Don't have an account ?",
              style: TextStyle(
                fontSize: 13,
                color: ColorList.appBlack,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextButton(
              onPressed: () {
                pushNotReplacement(classReplace: SignUp());
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: ColorList.appGreen,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget logoComponents() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "images/logo.png",
          color: ColorList.appGreen,
          height: 100,
          width: 100,
        ),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          height: 96,
          child: Stack(
            children: [
              Text(
                Strings.appName,
                style: TextStyle(
                  color: ColorList.white,
                  fontSize: 70,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Positioned(
                bottom: 9,
                left: 4,
                child: Text(
                  Strings.slogan,
                  style: TextStyle(
                    color: ColorList.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

}