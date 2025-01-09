import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rieng/connection/authentication.dart';
import 'package:rieng/dialog/dialogGood.dart';
import 'package:rieng/dialog/dialogLoadWait.dart';
import 'package:rieng/resources/color.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController getEmail = TextEditingController();

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
                    "Reset ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: ColorList.appBlack,
                        fontSize: 40),
                  ),
                  Text(
                    "Password",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: ColorList.appGreen,
                        fontSize: 40),
                  ),
                ],
              ),
            ],
          ),
          const Row(
            children: [
              Text(
                "Hello it's okay to ",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: ColorList.appBlack,
                    fontSize: 15),
              ),
              Text(
                "Forget",
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
                "Everyone does time to time",
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
          emailInput(),
          const SizedBox(height: 40,),
          buttonReset(),
          rememberPassword()
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


  Widget buttonReset() {
    return InkWell(
      onTap: () {
        if(getEmail.text.isEmpty){
          Get.snackbar("Required", "All fields are required",
              icon: Icon(Icons.warning_amber_rounded));
        }else{
          resetUser();
        }
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


  Widget rememberPassword() {
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
              "Remember your password ?",
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

  Future<void> resetUser() async {
    showAlertDialog(context);

    //check if the email exist


    final message =   await AuthenticationService().reset(
        email: getEmail.text.toString().trim()
    );


    Navigator.of(context, rootNavigator: true).pop();
    var messageNext = message;
    if (message!.contains('successfully')) {
      //open her the splashscreen
      takeMessage = 'Success!';
      messageNext = "account was set up successfully";
    } else {
      takeMessage = 'Error!';
    }




    showAlertDialogGood(messageNext!,buttonOk(),takeMessage);
    //then load the user to the database
  }

  showAlertDialog(BuildContext contexts) async {
    showDialog(
      context: contexts,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DialogLoadWait();
      },

    );
  }

  var takeMessage = '';
  Widget buttonOk() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              Navigator.pop(context);

              if (takeMessage == 'Success!') {
                //open her the splashscreen
                Navigator.pop(context);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: takeMessage == 'Success!' ? ColorList.green : ColorList.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'ok',
                style: TextStyle(
                  color: ColorList.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  showAlertDialogGood(String message, Widget buttonOk,String title) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DialogGood(message: message, title: title,buttons: buttonOk,);
      },
    );
  }


}
