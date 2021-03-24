import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeward_interview_sample_code/business_logic/providers/login_provider.dart';
import 'package:homeward_interview_sample_code/services/utils/constants.dart';
import 'package:homeward_interview_sample_code/services/utils/mh_validator.dart';
import 'package:homeward_interview_sample_code/ui/blog_list.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.themePrimary,
      body: Container(
        child: Consumer<LoginProvider>(
            builder: (ctx, LoginProvider loginProvider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                          child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.octopusDeploy,
                          color: Colors.white,
                          size: 80,
                        ),
                      ))
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35),
                      ))
                    ],
                  )),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: 16, end: 16, bottom: 8),
                    child: TextFormField(
                        textDirection: TextDirection.ltr,
                        controller: loginProvider.emailController,
                        validator: MHValidator.validateEmail(context),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: GoogleFonts.cairo(
                            color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(8),
                              child: FaIcon(
                                FontAwesomeIcons.envelope,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            labelText: "Email",
                            labelStyle: TextStyle(color: Colors.white),
                            errorText: loginProvider.emailErrorMsg,
                            errorStyle: TextStyle(color: Colors.grey.shade300),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            contentPadding: const EdgeInsets.all(8))),
                  ))
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding:
                        EdgeInsetsDirectional.only(start: 16, end: 16, top: 8),
                    child: TextFormField(
                        textDirection: TextDirection.ltr,
                        controller: loginProvider.passwordController,
                        validator: MHValidator.validatePassword(context),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: GoogleFonts.cairo(
                            color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                        obscureText: true,
                        decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(8),
                              child: FaIcon(
                                FontAwesomeIcons.key,
                                color: Colors.white,
                                size: 27,
                              ),
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.white),
                            errorText: loginProvider.passwordErrorMsg,
                            errorStyle: TextStyle(color: Colors.grey.shade300),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            contentPadding: const EdgeInsets.all(8))),
                  ))
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding:
                        EdgeInsetsDirectional.only(start: 16, end: 16, top: 8),
                    child: MaterialButton(
                      onPressed: () async {
                        // * Login Process
                        if (loginProvider.emailController.text.trim().isEmpty ||
                            loginProvider.emailController.text.trim().length <
                                6 ||
                            !loginProvider.emailController.text.contains("@") ||
                            !loginProvider.emailController.text.contains(".")) {
                          loginProvider
                              .setEmailErrorMsg("Please Enter Valid Email");
                          return;
                        }

                        if (loginProvider.passwordController.text
                                .trim()
                                .isEmpty ||
                            loginProvider.passwordController.text
                                    .trim()
                                    .length <
                                6) {
                          loginProvider.setPasswordErrorMsg(
                              "Please Enter Valid Password");
                          return;
                        }

                        final bool? isLoggedIn =
                            await loginProvider.loginToApi();
                        if (isLoggedIn != null && isLoggedIn) {
                          showSuccessDialog(
                              "Success",
                              "Logged In Successfully",
                              context,
                              () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlogList())));
                        } else {
                          showErrorDialog(
                              "Failed",
                              "Login Failed , Please Check Your Credentials or Try Again Later",
                              context);
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      color: Colors.white,
                      splashColor: Constants.themeAccent,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cairo(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ))
                ],
              )
            ],
          );
        }),
      ),
    );
  }

  // * -------------------------- Alert Dialogs ------------------------------ //

  // ? Function to Show Error Dialog
  void showErrorDialog(String title, String description, BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: description,
      btnCancelText: "Cancel",
      btnCancelOnPress: () {},
    ).show();
  }

  // ? Function to Show Success Dialog
  void showSuccessDialog(String title, String description, BuildContext context,
      Function() callback) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: description,
      onDissmissCallback: callback,
      btnOkText: "Ok",
      btnOkOnPress: callback,
    ).show();
  }
}
