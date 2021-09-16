

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_ecomerce/model_two/cart_item.dart';
import 'package:project_ecomerce/model_two/favvorite_item.dart';
import 'package:project_ecomerce/models/import.dart';
import 'package:provider/provider.dart';

class Baby extends StatefulWidget {
  const Baby({Key? key}) : super(key: key);

  @override
  _BabyState createState() => _BabyState();
}

class _BabyState extends State<Baby> {
  ProductsModel model = ProductsModel();

  void initState() {
    super.initState();
    //helper = DatabaseHelper() ;
    model;
  }
  @override
  Widget build(BuildContext context) {
    return  Consumer <CartItemPage>(
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
                          child: ListView.builder(
                            itemCount: 1 ,
                            itemBuilder: (context, index) {
                              return Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Column(
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
                                                    listModel![6].avatar
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
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  SizedBox(height: 4,),
                                                  Text(
                                                    " ${listModel[6].title
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
                                                      " ${listModel[6]
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
                                                        "Quantity : ${listModel[6]
                                                            .in_stock.toString()
                                                            .substring(0)}  ",
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            color: Colors.transparent,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 15),
                                                      ),

                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ) ,
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
                                                                    favor.added(listModel[6]) ;
                                                                    favor.listItems() ;
                                                                    favor.checkIfProductInCarts(listModel[6]);
                                                                  }, icon: Icon(Icons.favorite_border)),
                                                                );
                                                              }),


                                                              SizedBox(
                                                                width: 7,
                                                              ),


                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  cartItemPage.checkIfProductInCart(listModel[6]);
                                                                  cartItemPage.listItem() ;
                                                                  cartItemPage.add(listModel[6]);
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
                                                                        ///cartItemPage.listItem() ;
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
                                                          "Name : ${listModel[6]
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
                                                                  6]
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
                                                                " ${listModel[6]
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
                                                                " ${listModel[6]
                                                                    .price
                                                                    .toString()
                                                                    .substring(
                                                                    0)}  ${listModel[6]
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
                                                                " ${listModel[6]
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
                                                                " ${listModel[6]
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
                                                                  " ${listModel[6]
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
                                                                " ${listModel[6]
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
                                    ),
                                    Divider(thickness: 5,) ,
                                    Column(
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
                                                    listModel[7].avatar
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
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  SizedBox(height: 4,),
                                                  Text(
                                                    " ${listModel[7].title
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
                                                      " ${listModel[7]
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
                                                        "Quantity : ${listModel[7]
                                                            .in_stock.toString()
                                                            .substring(0)}  ",
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            color: Colors.transparent,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 15),
                                                      ),

                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ) ,
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
                                                                    favor.added(listModel[7]) ;
                                                                    favor.listItems() ;
                                                                    favor.checkIfProductInCarts(listModel[7]);
                                                                  }, icon: Icon(Icons.favorite_border)),
                                                                );
                                                              }),


                                                              SizedBox(
                                                                width: 7,
                                                              ),


                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  cartItemPage.checkIfProductInCart(listModel[7]);
                                                                  cartItemPage.listItem() ;
                                                                  cartItemPage.add(listModel[7]);
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
                                                                        ///cartItemPage.listItem() ;
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
                                                          "Name : ${listModel[7]
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
                                                                  7]
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
                                                                " ${listModel[7]
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
                                                                " ${listModel[7]
                                                                    .price
                                                                    .toString()
                                                                    .substring(
                                                                    0)}  ${listModel[7]
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
                                                                " ${listModel[7]
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
                                                                " ${listModel[7]
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
                                                                  " ${listModel[7]
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
                                                                " ${listModel[7]
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
                                    ),

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
