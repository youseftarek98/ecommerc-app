



import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

/*
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


 */



  final _formKey = GlobalKey<FormState>();
  final FocusNode _passwordFocusNode = FocusNode();

  final FocusNode _emailFocusNode = FocusNode();

  final FocusNode _phoneFocusNode = FocusNode();
 bool? isLoading ;
  String _emailAddress = "";
  String _password = "";
  String _userName = "";
  bool _obscureText = true;
  int? _phoneNumber;
  String? _jonindat;

  late File _pickedImage;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  signUp() async {
    var formdata = _formKey.currentState;
    if (formdata!.validate()) {
      formdata.save();

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailAddress, password: _password);
        if(userCredential!= null){
           FirebaseFirestore.instance.collection("user").doc(_auth.currentUser!.uid).set({
             "name" : _userName ,
             "email" : _emailAddress ,
             "phone" : _phoneNumber ,
           }) ;
           print(_userName) ;
           print(_emailAddress) ;
           print(_phoneNumber) ;
        }
        else {
          print("==============") ;
        }
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


  getData()async{
    CollectionReference user = FirebaseFirestore.instance.collection("user") ;

    user.add({
      "username" :"youssef" ,
      "age": 20 ,
      "email": "youssef@gmail.com"
    });


  }

  var _date =DateTime.now().toString() ;
  //var datepars =DateTime.parse(_date) ;
 // var formDate = "${datepars.hour}" ;

  void _submitForm() async {
    final inValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (inValid) {
      setState(() {
        isLoading = true ;
      });
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus() ;
      try {
        
        await _auth.createUserWithEmailAndPassword(
            email: _emailAddress.toLowerCase().trim(),
            password: _password.trim());
        final User? user = _auth.currentUser;
        final _uid =user!.uid ;
        FirebaseFirestore.instance.collection('user').doc(_uid).set(
         {
           "id" : _uid ,
           "name" :_userName ,
           "email" : _emailAddress ,
           "phoneNumber" : _phoneNumber ,
           "imageUrl" : "" ,
           "joinet" : _date ,
         "created" : Timestamp.now(),
         }
        );
  Navigator.canPop(context) ? Navigator.pop(context) :null ;
      } catch (error) {
        print("error occured ${error}");
      }
      finally{
        setState(() {
          isLoading = false ;
        });
      }
    }
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _pickImageGallry() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _remove() {
    setState(() {
      _pickedImage = null as File;
    });
    Navigator.pop(context);
  }


  @override
  void initState(){
    getData();
    super.initState() ;
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
            Stack(children: [
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 30, horizontal: 30),
                            child: CircleAvatar(
                              radius: 77,
                              backgroundColor: Colors.purpleAccent,
                              child: CircleAvatar(
                                backgroundColor: Colors.orange,
                                radius: 75,
                                //  backgroundImage: _pickedImage == null ?null : FileImage(_pickedImage),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 129,
                              left: 120,
                              child: RaisedButton(
                                elevation: 10,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            " Choose option",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.purple,
                                            ),
                                          ),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: [
                                                InkWell(
                                                  onTap: _pickImageCamera,
                                                  splashColor: Colors.purple,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Icon(
                                                            Icons.camera,
                                                            color: Colors
                                                                .purpleAccent),
                                                      ),
                                                      Text(
                                                        "Camera",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          //color: Colors.purple ,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: _pickImageGallry,
                                                  splashColor: Colors.purple,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Icon(Icons.image,
                                                            color: Colors
                                                                .purpleAccent),
                                                      ),
                                                      Text(
                                                        "Gallery",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          //color: Colors.purple ,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: _remove,
                                                  splashColor: Colors.purple,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Icon(
                                                            Icons.remove_circle,
                                                            color: Colors.red),
                                                      ),
                                                      Text(
                                                        "Remove",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                color: Colors.purpleAccent,
                                child: Icon(Icons.add_a_photo),
                                padding: EdgeInsets.all(14),
                                shape: CircleBorder(),
                              ))
                        ],
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: TextFormField(
                          key: ValueKey("name"),
                     //     focusNode: _userName.,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name cannot be null ';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _userName = value!;
                          },
                          onEditingComplete: _submitForm,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              prefixIcon: Icon(Icons.person),
                              labelText: "User name",
                              fillColor: Theme.of(context).backgroundColor,
                              border: UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: TextFormField(
                          key: ValueKey("email"),
                          focusNode: _emailFocusNode,
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
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              filled: true,
                              prefixIcon: Icon(Icons.email),
                              labelText: "Email address",
                              fillColor: Theme.of(context).backgroundColor,
                              border: UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        ),
                      ),
                      SizedBox(
                        height: 8,
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
                          focusNode: _passwordFocusNode,
                          obscureText: _obscureText,
                          keyboardType: TextInputType.emailAddress,
                          onEditingComplete: _submitForm,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              filled: true,
                              prefixIcon: Icon(Icons.lock),
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
                              border: UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: TextFormField(
                          key: ValueKey("Phone number"),
                          focusNode: _phoneFocusNode,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Pleas enter a valid phone number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _phoneNumber = int.parse(value!);
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: _submitForm,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              filled: true,
                              prefixIcon: Icon(Icons.phone),
                              labelText: "Phone number",
                              fillColor: Theme.of(context).backgroundColor,
                              border: UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        ),
                      ),
                      SizedBox(height: 9),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
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
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          side: BorderSide(
                                              color: Theme.of(context)
                                                  .backgroundColor)))),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Sign up",
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
                              )),
                          SizedBox(
                            width: 9,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 22),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                        width: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            side: BorderSide(
                                                color: Colors.white)))),
                                onPressed: () async{
                                // var user =  await signInWithGoogle();
                               //  print(user) ;
                                },
                                child: Text("Google +")),
                            ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            side: BorderSide(
                                                color: Colors.red)))),
                                onPressed: () {

                                },
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
              ),
            ])
          ],
        ),
      ),
    );
  }
}
