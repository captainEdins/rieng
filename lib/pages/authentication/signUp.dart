import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rieng/resources/color.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


  TextEditingController getEmail = TextEditingController();
  TextEditingController getName = TextEditingController();
  TextEditingController getPhone = TextEditingController();
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
    return  Scaffold(
      backgroundColor: ColorList.white,
      body: ListView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top > 0 ? 40 : 10,left: 10,right: 10),
        children:  [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: const Icon(
                    CupertinoIcons.arrow_left_circle_fill,
                    color: ColorList.appBlack,
                    size: 40,
                  ),
                ),
              ),
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
                    "Up",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: ColorList.appGreen,
                        fontSize: 45),
                  ),
                ],
              ),
            ],
          ),
          const Row(
            children: [
              Text(
                "Hello ",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: ColorList.appBlack,
                    fontSize: 15),
              ),
              Text(
                "You",
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
                "We are grateful to see you Here",
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
          const SizedBox(height: 30,),
          const SizedBox(height: 10,),
          nameInput(),
          const SizedBox(height: 10,),
          numberInput(),
          const SizedBox(height: 10,),
          emailInput(),
          const SizedBox(height: 10,),
          passwordInput(),
          const SizedBox(height: 30,),
          buttonRegister(),
          notFirstTime()
        ],
      ),
    );
  }

  Widget nameInput() {
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
            controller: getName,
            decoration:  InputDecoration(
              filled: true,
              fillColor: ColorList.appBlack.withOpacity(.1),
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.person,
                size: 24,
                color: ColorList.appBlack,
              ),
              hintText: 'Name',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
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
                borderSide: BorderSide(width: 1, color: ColorList.appBlack.withOpacity(.1)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget numberInput() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            keyboardType: TextInputType.number,
            cursorColor: ColorList.appBlack,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: ColorList.appBlack,
              fontSize: 15,
            ),
            controller: getPhone,
            decoration:  InputDecoration(
              filled: true,
              fillColor: ColorList.appBlack.withOpacity(.1),
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.phone_iphone_rounded,
                size: 24,
                color: ColorList.appBlack,
              ),
              hintText: 'Phone Number',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
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
                borderSide: BorderSide(width: 1, color: ColorList.appBlack.withOpacity(.1)),
              ),
            ),
          ),
        ),
      ],
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
            decoration:  InputDecoration(
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
                borderSide: BorderSide(
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
                borderSide: BorderSide(width: 1, color: ColorList.appBlack.withOpacity(.1)),
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
              enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                    width: 1, color: ColorList.appBlack.withOpacity(.1)), //<-- SEE HERE
              ),
              labelStyle: const TextStyle(
                color: ColorList.grey,
                fontSize: 15,
              ),
              focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(width: 1, color: ColorList.appBlack.withOpacity(.1)),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buttonRegister() {
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


  Widget notFirstTime() {
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
              "Already have an account ?",
              style: TextStyle(
                fontSize: 13,
                color: ColorList.appBlack,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'Sign In',
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


}