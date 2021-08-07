import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
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
