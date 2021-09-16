import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_ecomerce/helper/database_helper.dart';
import 'package:project_ecomerce/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  var top = 0.0;


//var db =DatabaseHelper() ;

  TextEditingController _textFieldController = TextEditingController() ;

  ScrollController? _scrollController;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _uid;
  String? _name;
  String? _email;
  String? _jonindat;
  String? _phone;

  late File _pickedImage;






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

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {

    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      setState(() {});
    });
    getData();
    super.initState();
  }


  void getData()async{
    User? user = _auth.currentUser ;
    _uid = user!.uid ;
   print("user username displayName ${user.displayName}") ;
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("user").doc(_uid).get();
  setState(() {
    _name = userDoc.get("name");
    _email =user.email ;
    _phone = userDoc.get("phone").toString();
  });

   // _jonindat = userDoc.get("phone");
  //  print("name $_name") ;
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        body: Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 4,
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.white],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp,
                      ),
                    ),
                    child: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        centerTitle: true,
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AnimatedOpacity(
                              opacity: top <= 200 ? 1.0 : 0,
                              duration: Duration(milliseconds: 300),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Container(
                                    height: kToolbarHeight / 1.8,
                                    width: kToolbarHeight / 1.8,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 1.0,
                                          ),
                                        ],
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            "https://retail.amit-learning.com/images/products/mFXrS9i3y07IT9ic7jgcfq90GtMhf91WdlydLsnt.jpg",
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    _name == null ? "Guest" : _name.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        background: Image(
                          image: NetworkImage(
                              "https://retail.amit-learning.com/images/products/mFXrS9i3y07IT9ic7jgcfq90GtMhf91WdlydLsnt.jpg"),
                          fit: BoxFit.fill,
                        )),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: userTitle("User information"),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),

               userListTile("User name", _name ??"", 0, context) ,
               userListTile("Email", _email ??"", 1, context) ,
               userListTile("phone", _phone ?? "" , 2, context) ,
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: userTitle("User settings"),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                SwitchListTile(
                  value: themeChange.darkTheme,
                  onChanged: (value) {
                    setState(() {
                      themeChange.darkTheme = value;
                    });
                  },
                  activeColor: Colors.indigo,
                  title: Text("Dark theme"),
                ),

                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: ListTile(
                      onTap: (){
                        _auth.signOut();
                        showDialog(
                            context: context,
                            builder:
                            (BuildContext context){
                              return AlertDialog(


                                content :Text("Do you want Sign out ?"),
                                actions: [

                                  TextButton(
                                    onPressed: ()async{
                                      Navigator.pop(context) ;
                                    },
                                    child: Text("Cancel") ,
                                  ) ,
                                  TextButton(
                                      onPressed: ()async{
                                     await   _auth.signOut().then((value) =>  Navigator.of(context).pushReplacementNamed("SignUpPage") );    ///Navigator.pop(context)) ;
                                      },
                                      child: Text("Ok" , style: TextStyle(color: Colors.red),) ,
                                  ) ,
                                ],
                              );
                            }
                        );
                      },
                      title: Text("Logout"),
                      leading: IconButton(
                        onPressed: (){

                        },
                        icon: Icon(Icons.exit_to_app),
                      ) ,
                    ),
                  ),
                ) ,
               // userListTile("Log out ", "", 2, context),
              ],
            )),
          ],
        ),
        _buildFab(),
      ],
    ));
  }

  Widget _buildFab() {
    final double defaultTopMargin = 200 - 4;
    final double scaleStart = 160;
    final double scaleEnd = scaleStart / 2;
    double top = defaultTopMargin;
    double scale = 1;
    if (_scrollController!.hasClients) {
      double offset = _scrollController!.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        scale = 1;
      } else if (offset < defaultTopMargin - scaleEnd) {
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        scale = 0.0;
      }
    }
    return Positioned(
      top: top,
      right: 15,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          heroTag: "path",
          child: Icon(Icons.camera_alt_outlined),
          onPressed: () {},
        ),
      ),
    );
  }

  List<IconData> _userTitleIcons = [
    Icons.person,
    Icons.email,
    Icons.phone,
   Icons.watch_later,
   // Icons.exit_to_app_rounded,
  ];

  Widget userListTile(
      String title, String subTitle, int index, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){

        },
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          title: Text(title),
          subtitle: Text(subTitle),
          leading: Icon(_userTitleIcons[index]),
          trailing: IconButton(
              onPressed: (){
                _showFormDialog() ;
              }, icon: Icon(Icons.update)),
        ),
      ),
    );
  }

  Widget userTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
  void _showFormDialog(){
    var alert = new AlertDialog(
      content: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _textFieldController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Update data" ,
                  icon: Icon(Icons.add_alert)
                ),
          ))
        ],
      ),
      actions: [
        FlatButton(
          child: Text("Save") ,
            onPressed: (){
              _handeleSubmit (_textFieldController.text) ;
            },
        ) ,

        FlatButton(
          child: Text("Cancel") ,
          onPressed: (){
            Navigator.of(context).pop(context);
          },
        )
      ],
    );
    showDialog( context: context ,
    builder: (context){
      return alert ;
    }
    );
  }

  void _handeleSubmit(String text) {


  }







}
