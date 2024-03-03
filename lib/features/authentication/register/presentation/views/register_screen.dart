import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/custom_text_field.dart';
import 'package:todo_app/core/dialog_utils.dart';
import 'package:todo_app/core/firebaseUtils.dart';
import 'package:todo_app/core/myTheme.dart';
import 'package:todo_app/features/Home/data/user_model.dart';
import 'package:todo_app/features/authentication/login/presentation/views/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'RegisterScreen';
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void register() async {
      bool validate = formKey.currentState!.validate();
      if (validate) {
        DialogUtils.showLoading(context: context, isDismissible: false);
        try {
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.text,
            password: password.text,
          );
          MyUser user = MyUser(
              email: email.text,
              userName: userName.text,
              id: credential.user?.uid ?? '');
          FirebaseUtils.addUserToFirestore(user);
          DialogUtils.hideLoading(context);
          await DialogUtils.showMessage(
              context: context,
              message: 'Register Successfully',
              actionName: 'Ok',
              posActionFun: () {
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName);
              });
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            DialogUtils.hideLoading(context);
            DialogUtils.showMessage(
                context: context,
                message: 'The password provided is too weak.',
                actionName: 'Ok',
                posActionFun: () {
                  Navigator.of(context).pop();
                });
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            DialogUtils.hideLoading(context);
            DialogUtils.showMessage(
                context: context,
                message: 'The account already exists for that email.',
                actionName: 'Ok',
                posActionFun: () {
                  Navigator.of(context).pop();
                });
            print('The account already exists for that email.');
          }
        } catch (e) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: e.toString(),
              actionName: 'Ok',
              posActionFun: () {
                Navigator.of(context).pop();
              });
          print(e);
        }
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
              AppLocalizations.of(context)!.register,
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
                        Align(alignment: Alignment.topLeft,child: Padding(
                          padding:  EdgeInsets.all(10.0),
                          child: Text('Create Account',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: MyTheme.blackColor),),
                        )),
                        CustomTextField(
                          label: AppLocalizations.of(context)!.username,
                          controller: userName,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please Enter Your Username';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          label: AppLocalizations.of(context)!.email,
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
                          label: AppLocalizations.of(context)!.password,
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
                          label: AppLocalizations.of(context)!.confirm_password,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .create_an_account,
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
                            Navigator.of(context)
                                .pushReplacementNamed(LoginScreen.routeName);
                          },
                          child: Text(
                            AppLocalizations.of(context)!
                                .already_have_an_account,
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
