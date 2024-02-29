import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/custom_text_field.dart';
import 'package:todo_app/core/myTheme.dart';
import 'package:todo_app/features/authentication/login/presentation/views/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'RegisterScreen';
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
 var formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    void register() {
      bool validate= formKey.currentState!.validate();
      if(validate){
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      }
    }
    return Stack(
      children: [
        Container(
          color: MyTheme.backgroundColorLight,
          child: Image.asset(
            'assets/images/background.png',
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'Register',
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 26),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: formKey,
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                    CustomTextField(
                      label: 'Username',
                      controller: userName,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Your Username';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      label: 'Email',
                      controller: email,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Your Email';
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          return 'Please enter Vaild Email';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      obscureText: true,
                      label: 'Password',
                      controller: password,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Your Password';
                        }
                        if (text.trim().length < 6) {
                          return 'Password must contains at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      obscureText: true,
                      label: 'Confirm Password',
                      controller: confirmPassword,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Your Username';
                        }
                        if (text != password.text) {
                          return "Confirm Password doesn't match Password";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: MyTheme.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            register();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Create an Account',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: MyTheme.whiteColor),
                                ),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: MyTheme.whiteColor,
                                ),
                              ],
                            ),
                          )),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                      },
                      child: Text(
                        'Already have an account?',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: MyTheme.primaryColor),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ],
    );
  }


}
