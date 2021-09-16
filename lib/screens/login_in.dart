import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_ecomerce/consts/global.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _emailAddress = "";
  String _password = "";
  bool _obscureText = true;
  bool _isLoading = false;
  GlobalMethods _globalMethods = GlobalMethods();
  final FirebaseAuth _auth =FirebaseAuth.instance ;
  signUp() async {
    var formdata = _formKey.currentState;
    if (formdata!.validate()) {
      formdata.save();

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: _emailAddress, password: _password);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          AwesomeDialog(
              context: context,
              title: "error",
              body: Text("password is too weak"))
            ..show();
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          AwesomeDialog(
              context: context,
              title: "error",
              body: Text("The account already exists for that email"))
            ..show();
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    } else {}
  }
  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      try {
        await _auth
            .sendPasswordResetEmail(email: _emailAddress.trim().toLowerCase())
            .then((value) => Fluttertoast.showToast(
            msg: "An email has been sent",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0));

        Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        _globalMethods.authErrorHandle(error.toString(), context);
        // print('error occured ${error.toString()}');
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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.95,
              child: RotatedBox(
                quarterTurns: 2,
                child: WaveWidget(
                  config: CustomConfig(
                    gradients: [
                      [Colors.red, Color(0xEEF44336)],
                      [Colors.orange, Color(0x66FF9800)],
                      [Colors.yellow, Color(0x55FFEB3B)]
                    ],
                    durations: [19440, 10800],
                    heightPercentages: [0.20, 0.23, 0.25, 0.30],
                    blur: MaskFilter.blur(BlurStyle.solid, 10),
                    gradientBegin: Alignment.bottomLeft,
                    gradientEnd: Alignment.topRight,
                  ),
                  waveAmplitude: 0,
                  backgroundImage: DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1600107363560-a2a891080c31?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=672&q=80',
                    ),
                    fit: BoxFit.fill,
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.softLight),
                  ),
                  size: Size(
                    double.infinity,
                    double.infinity,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: TextFormField(
                      key: ValueKey("email"),
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
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: TextFormField(
                      key: ValueKey("Password"),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'Pleas enter a valid Password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                      onEditingComplete: _submitForm,
                      obscureText: _obscureText,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          labelText: "Password",
                          fillColor: Theme.of(context).backgroundColor,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                    ),
                  ),
                  
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2 ,horizontal: 20),
                      child: TextButton(
                          onPressed: (){
                           Navigator.pushNamed(context, "ForgetPassword");
                          },
                          child: Text("Forget Password" , style: TextStyle(color: Colors.blue.shade900 , decoration: TextDecoration.underline),)
                      ),
                    ) ,
                  ),
                  SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: BorderSide(
                                          color: Theme.of(context)
                                              .backgroundColor)))),
                          onPressed: () async {
                            var response = await signUp();
                            print("==================================");
                            if (response != null) {
                              Navigator.of(context)
                                  .pushReplacementNamed("BottomBarScreens");
                            } else {
                              print("Sign up faild");
                            }
                            print(response.user!.email);
                            print("=====================================");
                            _submitForm();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              Icon(
                                Icons.person,
                                size: 10,
                              )
                            ],
                          )
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 70.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Divider(
                              color: Colors.white,
                              thickness: 2,
                            ),
                          ),
                        ),
                        Text(
                          "Or continue with",
                          style: TextStyle(color: Colors.black),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                              color: Colors.white,
                              thickness: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        side: BorderSide(color: Colors.white)))),
                            onPressed: () {},
                            child: Text("Google +")),
                        ElevatedButton(
                            style: ButtonStyle(
                                shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        side: BorderSide(color: Colors.red)))),
                            onPressed: () {},
                            child: Text("Facebook")),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
