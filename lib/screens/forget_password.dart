


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_ecomerce/consts/global.dart';

class ForgetPassword extends StatefulWidget {
  static const routeName = '/ForgetPassword';

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String _emailAddress = '';
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      try {
        await _auth.sendPasswordResetEmail(email: _emailAddress.trim().toLowerCase());

     //   Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        _globalMethods.authErrorHandle(error.toString(), context);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Forget password',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Form(
              child: TextFormField(
                key: _formKey,
                validator: (value) {
                  if (value!.isEmpty || !value.contains("@")) {
                    return 'Pleas enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _emailAddress = value!;
                },
                onEditingComplete: _submitForm,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: "Email address",
                    fillColor: Theme.of(context).backgroundColor,
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(20)))),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: _isLoading
                ? Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
                : ElevatedButton(
                style: ButtonStyle(
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: Theme.of(context).cardColor),
                      ),
                    )),
                onPressed: _submitForm,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Reset password',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.vpn_key,
                      size: 18,
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
