

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_ecomerce/helper/database_helper.dart';
import 'package:project_ecomerce/model_two/cart_item.dart';
import 'package:project_ecomerce/model_two/favvorite_item.dart';
import 'package:project_ecomerce/models/products.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class FeedProducts extends StatefulWidget {
  const FeedProducts({Key? key}) : super(key: key);

  @override
  _FeedProductsState createState() => _FeedProductsState();
}

class _FeedProductsState extends State<FeedProducts> {
  ProductsModel model = ProductsModel();
 // late DatabaseHelper helper  ;
  DatabaseHelper helper = DatabaseHelper();
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void initState() {
    super.initState();


  }

  CartItemPage _cartItemPage = CartItemPage() ;

  getSelectedPref ()async{
    SharedPreferences pref = await SharedPreferences.getInstance() ;
    setState(() {
      _cartItemPage =pref.getString("cart") as CartItemPage ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer <CartItemPage>(
        builder: (context, cartItemPage, child) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.grey //Theme.of(context).buttonColor
                ),
                child: FutureBuilder<List<ProductsModel>>(
                    future: model.getProducts(),
                    builder: (context, snap) {
                      if (snap.connectionState != ConnectionState.done) {
                        return Center(
                          child: Container(
                            // height: double.infinity,

                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (snap.hasData) {
                        List<ProductsModel>? listModel = snap.data;
                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: StaggeredGridView.countBuilder(
                            staggeredTileBuilder: (index) =>  StaggeredTile.fit(2),
                            crossAxisCount: 4,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 10,
                            itemCount: listModel!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              2),
                                          child: Container(
                                            width: double.infinity,
                                            constraints: BoxConstraints(
                                                minHeight: 150,
                                                maxHeight: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.3),
                                            child: Image.network(
                                                listModel[index].avatar
                                                    .toString(),
                                                fit: BoxFit.fitWidth),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      padding: EdgeInsets.only(left: 5),
                                      margin: EdgeInsets.only(left: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          SizedBox(height: 4,),
                                          Text(
                                            " ${listModel[index].title
                                                .toString().substring(0)}  ",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                              // fontWeight: FontWeight.w600,
                                                fontSize: 15),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Text(
                                              " ${listModel[index]
                                                  .price_final_text.toString()
                                                  .substring(0)}  ",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                //fontWeight: FontWeight.w900,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                "Quantity : ${listModel[index]
                                                    .in_stock.toString()
                                                    .substring(0)}  ",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    color: Colors.transparent,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return SingleChildScrollView(
                                                            child: AlertDialog(
                                                              backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
                                                              actions: [

                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                  children: [


                                                                          Padding(
                                                                            padding: const EdgeInsets.only(right: 0.0),
                                                                            child: IconButton(onPressed: (){
                                                                              Navigator.of(context).pop("FeedProducts");
                                                                            }, icon: Icon(Icons.arrow_back)),
                                                                          ) ,
                                                                          Consumer<Favorite>(builder: (context , favor , child){
                                                                            return Container(
                                                                              child: IconButton(onPressed: (){
                                                                                favor.added(listModel[index]) ;
                                                                                favor.listItems() ;
                                                                                favor.checkIfProductInCarts(listModel[index]);
                                                                              }, icon: Icon(Icons.favorite_border)),
                                                                            );
                                                                          }),


                                                                    SizedBox(
                                                                      width: 7,
                                                                    ),


                                                                    ElevatedButton(
                                                                      onPressed: () {
                                                                        cartItemPage.checkIfProductInCart(listModel[index]);
                                                                        cartItemPage.listItem() ;
                                                                        cartItemPage.add(listModel[index]);
                                                                      },
                                                                      child: Text(
                                                                        "Add to Cart",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.w600,
                                                                            //  color: Colors.red,
                                                                            fontSize: 15),
                                                                      ),
                                                                    )

                                                                  ],
                                                                )
                                                              ],
                                                              title: Text(
                                                                "Name : ${listModel[index]
                                                                    .name
                                                                    .toString()
                                                                    .substring(
                                                                    0)} ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              ),
                                                              content: Column(
                                                                children: [
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                        5,
                                                                        vertical:
                                                                        2),
                                                                    child: Image
                                                                        .network(
                                                                        listModel[
                                                                        index]
                                                                            .avatar
                                                                            .toString(),
                                                                        fit: BoxFit
                                                                            .cover),
                                                                  ),
                                                                  ListTile(
                                                                    leading: Text(
                                                                        "Description :  ",
                                                                        style: TextStyle(

                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold)),
                                                                    subtitle: Text(
                                                                      " ${listModel[index]
                                                                          .description
                                                                          .toString()
                                                                          .substring(
                                                                          0)} ",
                                                                      style: TextStyle(

                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                    ),
                                                                  ),
                                                                  ListTile(
                                                                    leading: Text(
                                                                        "Price :  ",
                                                                        style: TextStyle(

                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold)),
                                                                    trailing: Text(
                                                                      " ${listModel[index]
                                                                          .price
                                                                          .toString()
                                                                          .substring(
                                                                          0)}  ${listModel[index]
                                                                          .currency
                                                                          .toString()} ",
                                                                      style: TextStyle(

                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                    ),
                                                                  ),
                                                                  ListTile(
                                                                    leading: Text(
                                                                        "discount :  ",
                                                                        style: TextStyle(

                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold)),
                                                                    trailing: Text(
                                                                      " ${listModel[index]
                                                                          .discount
                                                                          .toString()
                                                                          .substring(
                                                                          0)}  %",
                                                                      style: TextStyle(

                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                    ),
                                                                  ),
                                                                  ListTile(
                                                                    leading: Text(
                                                                        "Price Final :  ",
                                                                        style: TextStyle(

                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold)),
                                                                    trailing: Text(
                                                                      " ${listModel[index]
                                                                          .price_final_text
                                                                          .toString()
                                                                          .substring(
                                                                          0)} ",
                                                                      style: TextStyle(

                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                    ),
                                                                  ),
                                                                  ListTile(
                                                                    leading: Text(
                                                                      "the rest of the amount : ",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                    ),
                                                                    trailing: Text(
                                                                        " ${listModel[index]
                                                                            .in_stock
                                                                            .toString()
                                                                            .substring(
                                                                            0)}",
                                                                        style: TextStyle(

                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold)),
                                                                  ),
                                                                  ListTile(
                                                                    leading: Text(
                                                                        "category Id :  ",
                                                                        style: TextStyle(

                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold)),
                                                                    trailing: Text(
                                                                      " ${listModel[index]
                                                                          .categoryId
                                                                          .toString()
                                                                          .substring(
                                                                          0)} ",
                                                                      style: TextStyle(

                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  borderRadius: BorderRadius
                                                      .circular(18),
                                                  child: Icon(Icons.more_horiz,
                                                    color: Colors.purple,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ) ,
                                  ],
                                ),

                              );
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
            ),
          );
        });
  }

}

/*GridView.builder(
                            itemCount: listModel!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              2),
                                          child: Container(
                                            width: double.infinity,
                                            constraints: BoxConstraints(
                                                minHeight: 100,
                                                maxHeight: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.3),
                                            child: Image.network(
                                                listModel[index].avatar
                                                    .toString(),
                                                fit: BoxFit.fitWidth),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      padding: EdgeInsets.only(left: 5),
                                      margin: EdgeInsets.only(left: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          SizedBox(height: 4,),
                                          Text(
                                            " ${listModel[index].title
                                                .toString().substring(0)}  ",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                              // fontWeight: FontWeight.w600,
                                                fontSize: 15),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Text(
                                              " ${listModel[index]
                                                  .price_final_text.toString()
                                                  .substring(0)}  ",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                //fontWeight: FontWeight.w900,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                "Quantity : ${listModel[index]
                                                    .in_stock.toString()
                                                    .substring(0)}  ",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    color: Colors.transparent,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return SingleChildScrollView(
                                                            child: AlertDialog(
                                                              backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
                                                              actions: [

                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                  children: [


                                                                          Padding(
                                                                            padding: const EdgeInsets.only(right: 0.0),
                                                                            child: IconButton(onPressed: (){
                                                                              Navigator.of(context).pop("FeedProducts");
                                                                            }, icon: Icon(Icons.arrow_back)),
                                                                          ) ,
                                                                          IconButton(onPressed: (){
                                                                           // cartItemPage.listItem() ;
                                                                            //cartItemPage.add(listModel[index]);
                                                                            Navigator.of(context).pop("Feeds");
                                                                          }, icon: Icon(Icons.favorite_border)),


                                                                    SizedBox(
                                                                      width: 7,
                                                                    ),


                                                                    ElevatedButton(
                                                                      onPressed: () {
                                                                        cartItemPage.checkIfProductInCart(listModel[index]);
                                                                        cartItemPage.listItem() ;
                                                                        cartItemPage.add(listModel[index]);
                                                                      },
                                                                      child: Text(
                                                                        "Add to Cart",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.w600,
                                                                            //  color: Colors.red,
                                                                            fontSize: 15),
                                                                      ),
                                                                    )
                                                                    /*
                                                                    FloatingActionButton(
                                                                      onPressed: (){
                                                                        /// SharedPreferences pref = await SharedPreferences.getInstance() ;
                                                                        /// pref.setString("cart", listModel[index]
                                                                        ///    .name.toString()) ;
                                                                        ///  cartItemPage.add(listModel[index]);

                                                                        //cartItemPage.add(listModel[index]);
                                                                      cartItemPage.checkIfProductInCart(listModel[index]);
                                                                        //  cartItemPage.add(listModel[index]) ;
                                                                        cartItemPage.listItem() ;
                                                                        cartItemPage.add(listModel[index]);
                                                                        // cartItemPage.getCountByItem(listModel[index]) ;
                                                                       // cartItemPage.counter ;
                                                                        //    _counter ++ ;
                                                                        //  _counter += listModel[index].price_final! ;


                                                                      },
                                                                      child: Icon(Icons.add,
                                                                        color: Colors.grey,
                                                                      ),
                                                                    ),

                                                                     */
                                                                  ],
                                                                )
                                                              ],
                                                              title: Text(
                                                                "Name : ${listModel[index]
                                                                    .name
                                                                    .toString()
                                                                    .substring(
                                                                    0)} ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              ),
                                                              content: Column(
                                                                children: [
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                        5,
                                                                        vertical:
                                                                        2),
                                                                    child: Image
                                                                        .network(
                                                                        listModel[
                                                                        index]
                                                                            .avatar
                                                                            .toString(),
                                                                        fit: BoxFit
                                                                            .cover),
                                                                  ),
                                                                  ListTile(
                                                                    leading: Text(
                                                                        "Description :  ",
                                                                        style: TextStyle(

                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold)),
                                                                    subtitle: Text(
                                                                      " ${listModel[index]
                                                                          .description
                                                                          .toString()
                                                                          .substring(
                                                                          0)} ",
                                                                      style: TextStyle(

                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                    ),
                                                                  ),
                                                                  ListTile(
                                                                    leading: Text(
                                                                        "Price :  ",
                                                                        style: TextStyle(

                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold)),
                                                                    trailing: Text(
                                                                      " ${listModel[index]
                                                                          .price
                                                                          .toString()
                                                                          .substring(
                                                                          0)}  ${listModel[index]
                                                                          .currency
                                                                          .toString()} ",
                                                                      style: TextStyle(

                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                    ),
                                                                  ),
                                                                  ListTile(
                                                                    leading: Text(
                                                                        "discount :  ",
                                                                        style: TextStyle(

                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold)),
                                                                    trailing: Text(
                                                                      " ${listModel[index]
                                                                          .discount
                                                                          .toString()
                                                                          .substring(
                                                                          0)}  %",
                                                                      style: TextStyle(

                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                    ),
                                                                  ),
                                                                  ListTile(
                                                                    leading: Text(
                                                                        "Price Final :  ",
                                                                        style: TextStyle(

                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold)),
                                                                    trailing: Text(
                                                                      " ${listModel[index]
                                                                          .price_final_text
                                                                          .toString()
                                                                          .substring(
                                                                          0)} ",
                                                                      style: TextStyle(

                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                    ),
                                                                  ),
                                                                  ListTile(
                                                                    leading: Text(
                                                                      "the rest of the amount : ",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                    ),
                                                                    trailing: Text(
                                                                        " ${listModel[index]
                                                                            .in_stock
                                                                            .toString()
                                                                            .substring(
                                                                            0)}",
                                                                        style: TextStyle(

                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold)),
                                                                  ),
                                                                  ListTile(
                                                                    leading: Text(
                                                                        "category Id :  ",
                                                                        style: TextStyle(

                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold)),
                                                                    trailing: Text(
                                                                      " ${listModel[index]
                                                                          .categoryId
                                                                          .toString()
                                                                          .substring(
                                                                          0)} ",
                                                                      style: TextStyle(

                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  borderRadius: BorderRadius
                                                      .circular(18),
                                                  child: Icon(Icons.more_horiz,
                                                    color: Colors.purple,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),

                              );
                            },
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 190 / 305,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,

                            ),
                          ),*/


