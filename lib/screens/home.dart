import 'package:backdrop/app_bar.dart';
import 'package:backdrop/button.dart';
import 'package:backdrop/scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_ecomerce/model_two/cart_item.dart';
import 'package:project_ecomerce/model_two/favvorite_item.dart';
import 'package:project_ecomerce/models/import.dart';
import 'package:project_ecomerce/models/products.dart';
import 'package:project_ecomerce/widget/screens_categories.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:card_swiper/card_swiper.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ProductsModel model = ProductsModel();


  int? id;
  @override
  void initState() {
    super.initState();
    //helper = DatabaseHelper() ;
    model;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartItemPage>(builder: (context, cartItemPage, child) {
      return Scaffold(
        body: BackdropScaffold(
            frontLayerBackgroundColor:
            Theme.of(context).scaffoldBackgroundColor,
            headerHeight: MediaQuery.of(context).size.height * 0.25,
            appBar: BackdropAppBar(
              title: Text(" Home"),
              leading: BackdropToggleButton(
                icon: AnimatedIcons.home_menu,
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient:
                    LinearGradient(colors: [Colors.purple, Colors.white])),
              ),
              actions: <Widget>[
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 13,
                    backgroundImage: NetworkImage(
                        "https://retail.amit-learning.com/images/products/mFXrS9i3y07IT9ic7jgcfq90GtMhf91WdlydLsnt.jpg"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Consumer<Favorite>(builder: (context , favor , child){
                            return Container(
                              child: Row(
                                children: [
                                  IconButton(onPressed: (){
                                    favor.listItems() ;
                                    Navigator.of(context).pushNamed("Feeds");
                                  }, icon: Icon(Icons.favorite_border)),
                                  Text("${favor.listItems()!.length}"),
                                ],
                              ),
                            );
                          }),


                          IconButton(
                              onPressed: () {
                                cartItemPage.listItem()!.length;
                                Navigator.of(context).pushNamed("cart");
                              },
                              icon: Icon(Icons.shopping_cart_outlined)),
                        ],
                      ),
                      Text("${cartItemPage.listItem()!.length}"),

                      // Text("${cartItemPage.counter}")
                    ],
                  ),
                ),
              ],
            ),
            backLayer: Center(
              child: Container(
                color: Colors.purple.shade200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(29))),
                        onPressed: () {
                          Navigator.of(context).pushNamed("cart");
                        },
                        child: Text("Cart"),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(29))),
                        onPressed: () {
                          Navigator.of(context).pushNamed("Feeds");
                        },
                        child: Text("Favorite"),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(29))),
                        onPressed: () {
                          Navigator.of(context).pushNamed("baby");
                        },
                        child: Text("Fashion"),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(29))),
                        onPressed: () {
                          Navigator.of(context).pushNamed("electronics");
                        },
                        child: Text("Electronics"),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(29))),
                        onPressed: () {
                          Navigator.of(context).pushNamed("Baby");
                        },
                        child: Text("Baby"),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(29))),
                        onPressed: () {
                          Navigator.of(context).pushNamed("healthBeauty");
                        },
                        child: Text("Health & Beauty"),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(29))),
                        onPressed: () {
                          Navigator.of(context).pushNamed("phones");
                        },
                        child: Text("Phones"),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(29))),
                        onPressed: () {
                          Navigator.of(context).pushNamed("supermarket");
                        },
                        child: Text("Supermarket"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            frontLayer: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Categories",
                      style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 180,
                    child: ScreensCategories(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      children: [
                        Text(
                          "Popular Brands",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("FeedProducts");
                          },
                          child: Text(
                            "View all Products...",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                //  color: Colors.red,
                                fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width * 1.0,
                    child: FutureBuilder<List<ProductsModel>>(
                        future: model.getProducts(),
                        builder: (context, snap) {
                          if (snap.connectionState != ConnectionState.done) {
                            return Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                ],
                              ),
                            );
                          } else if (snap.hasData) {
                            List<ProductsModel>? listModel = snap.data;
                            return Container(
                              padding: EdgeInsets.all(10),
                              height: 210,
                              width: MediaQuery.of(context).size.width * 0.90,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio: 190 / 305,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: listModel!.length,
                                itemBuilder: (context, index) {
                                  return Consumer<Favorite>(builder: (context, favorite , child){
                                    return Container(
                                        child: Stack(
                                          children: [

                                            ListTile(
                                              subtitle: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Image.network(
                                                    listModel[index].avatar.toString(),
                                                    fit: BoxFit.fill),
                                              ),

                                            ),
                                            Badge(
                                              toAnimate: true,
                                              shape: BadgeShape.square,
                                              badgeColor: Colors.pink,
                                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(8)),
                                              badgeContent: Text('New', style: TextStyle(color: Colors.white)),
                                            ),
                                          ],
                                        )
                                    ) ;
                                  }) ;
                                },
                              ),
                            );
                          } else {
                            return Center(
                              child: Text("No Data Found"),
                            );
                          }
                        }),
                  ),
                ],
              ),
            )),
      );
    });
  }
}


