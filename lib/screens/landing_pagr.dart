import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ecomerce/consts/col_ors.dart';
import 'package:project_ecomerce/consts/global.dart';


import 'login_in.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  List<String> images = [
    'https://media.istockphoto.com/photos/man-at-the-shopping-picture-id868718238?k=6&m=868718238&s=612x612&w=0&h=ZUPCx8Us3fGhnSOlecWIZ68y3H4rCiTnANtnjHk0bvo=',
    'https://thumbor.forbes.com/thumbor/fit-in/1200x0/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F1138257321%2F0x0.jpg%3Ffit%3Dscale',
    'https://e-shopy.org/wp-content/uploads/2020/08/shop.jpeg',
    'https://e-shopy.org/wp-content/uploads/2020/08/shop.jpeg',
  ];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    images.shuffle();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    _animation =
    CurvedAnimation(parent: _animationController, curve: Curves.linear)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((animationStatus) {
        if (animationStatus == AnimationStatus.completed) {
          _animationController.reset();
          _animationController.forward();
        }
      });
    _animationController.forward();
  }

  @override
  void dispose() {
   // _animationController.dispose();
    super.dispose();
  }



  void _loginAnonymosly() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.signInAnonymously();
    } catch (error) {
      _globalMethods.authErrorHandle(error.toString(), context);
      print('error occured ${error.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          CachedNetworkImage(
            imageUrl: images[1],
            // placeholder: (context, url) => Image.network(
            //   'https://image.flaticon.com/icons/png/128/564/564619.png',
            //   fit: BoxFit.contain,
            // ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: FractionalOffset(_animation.value, 0),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Welcome to the biggest online store',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side: BorderSide(color: ColorsConsts.backgroundColor),
                              ),
                            )),
                        onPressed: () {
                          Navigator.pushNamed(context, "loginScreen");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 17),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.person,
                              size: 18,
                            )
                          ],
                        )),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.pink.shade400),
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side:
                                BorderSide(color: ColorsConsts.backgroundColor),
                              ),
                            )),
                        onPressed: () {
                          Navigator.pushNamed(context, "signUpScreen");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sign up',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 17),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.person_add_alt_1_sharp,
                              size: 18,
                            )
                          ],
                        )),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),
                  ),
                  Text(
                    'Or continue with',
                    style: TextStyle(color: Colors.black),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlineButton(
                    onPressed: (){},
                    shape: StadiumBorder(),
                    highlightedBorderColor: Colors.red.shade200,
                    borderSide: BorderSide(width: 2, color: Colors.red),
                    child: Text('Google +'),
                  ),
                  _isLoading
                      ? CircularProgressIndicator()
                      : OutlineButton(
                    onPressed: () {
                      _loginAnonymosly();
                      // Navigator.pushNamed(context, BottomBarScreen.routeName);
                    },
                    shape: StadiumBorder(),
                    highlightedBorderColor: Colors.deepPurple.shade200,
                    borderSide:
                    BorderSide(width: 2, color: Colors.deepPurple),
                    child: Text('Sign in as a guest'),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ]));
  }
}

/*
    with TickerProviderStateMixin {
  late AnimationController
      animationController; //=AnimationController(vsync: this , duration: Duration(seconds: 20)) ;
  late Animation<double> animation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              animationController.reset();
              animationController.forward();
            }
          });
    animationController.forward();

    super.initState();
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              "https://retail.amit-learning.com/images/products/mFXrS9i3y07IT9ic7jgcfq90GtMhf91WdlydLsnt.jpg",
          placeholder: (context, url) => Image.network(
              "https://retail.amit-learning.com/images/products/mFXrS9i3y07IT9ic7jgcfq90GtMhf91WdlydLsnt.jpg",
              fit: BoxFit.contain),
          errorWidget: (context, url, error) => Icon(Icons.error_outline),
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: FractionalOffset(animation.value ,0),
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Welcome to the biggest online store",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: BorderSide(
                                          color: Theme.of(context)
                                              .backgroundColor)))),
                      onPressed: () {
                        Navigator.of(context).pushNamed("loginScreen") ;
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
                      )),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.pink),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: BorderSide(
                                          color: Theme.of(context)
                                              .backgroundColor)))),
                      onPressed: () {

                          Navigator.of(context).pushNamed("signUpScreen") ;

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          Icon(
                            Icons.person_add_alt_1_sharp,
                            size: 10,
                          )
                        ],
                      )),
                ),
                SizedBox(
                  width: 12.0,
                ),
              ],
            ),
            SizedBox(
              width: 70.0,
            ),
            Row(
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
            SizedBox(
              width: 50.0,
            ),
            Row(
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
                    child: Text("Sign in as gust")),
              ],
            ),
            SizedBox(
              width: 30.0,
            ),
          ],
        )
      ],
    ));
  }
}


 */