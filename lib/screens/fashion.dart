
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_ecomerce/model_two/cart_item.dart';
import 'package:project_ecomerce/model_two/favvorite_item.dart';
import 'package:project_ecomerce/models/products.dart';
import 'package:provider/provider.dart';

class Fashion extends StatefulWidget {
  const Fashion({Key? key}) : super(key: key);

  @override
  _FashionState createState() => _FashionState();
}

class _FashionState extends State<Fashion> {
  ProductsModel model = ProductsModel();

  void initState() {
    super.initState();
    //helper = DatabaseHelper() ;
    model;
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
                          child: ListView.builder(

                            itemCount: 4,
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
                                                listModel![index].avatar
                                                    .toString(),
                                                fit: BoxFit.fitWidth),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      padding: EdgeInsets.all( 5),
                                      margin: EdgeInsets.all( 5),
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
    /*
      Consumer <CartItemPage>(
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
                                                    listModel![0].avatar
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
                                                      " ${listModel[1]
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
                                                        "Quantity : ${listModel[1]
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
                                                                    favor.added(listModel[0]) ;
                                                                    favor.listItems() ;
                                                                    favor.checkIfProductInCarts(listModel[0]);
                                                                  }, icon: Icon(Icons.favorite_border)),
                                                                );
                                                              }),


                                                              SizedBox(
                                                                width: 7,
                                                              ),


                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  cartItemPage.checkIfProductInCart(listModel[0]);
                                                                  cartItemPage.listItem() ;
                                                                  cartItemPage.add(listModel[0]);
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
                                                          "Name : ${listModel[0]
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
                                                                  0]
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
                                                                " ${listModel[0]
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
                                                                " ${listModel[0]
                                                                    .price
                                                                    .toString()
                                                                    .substring(
                                                                    0)}  ${listModel[0]
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
                                                                " ${listModel[0]
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
                                                                " ${listModel[0]
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
                                                                  " ${listModel[0]
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
                                                                " ${listModel[0]
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
                                                    listModel[1].avatar
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
                                                    " ${listModel[1].title
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
                                                      " ${listModel[1]
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
                                                        "Quantity : ${listModel[1]
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
                                                                    favor.added(listModel[1]) ;
                                                                    favor.listItems() ;
                                                                    favor.checkIfProductInCarts(listModel[1]);
                                                                  }, icon: Icon(Icons.favorite_border)),
                                                                );
                                                              }),


                                                              SizedBox(
                                                                width: 7,
                                                              ),


                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  cartItemPage.checkIfProductInCart(listModel[1]);
                                                                  cartItemPage.listItem() ;
                                                                  cartItemPage.add(listModel[1]);
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
                                                          "Name : ${listModel[1]
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
                                                                  1]
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
                                                                " ${listModel[1]
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
                                                                " ${listModel[1]
                                                                    .price
                                                                    .toString()
                                                                    .substring(
                                                                    0)}  ${listModel[1]
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
                                                                " ${listModel[1]
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
                                                                " ${listModel[1]
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
                                                                  " ${listModel[1]
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
                                                                " ${listModel[1]
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
                                                    listModel[2].avatar
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
                                                    " ${listModel[2].title
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
                                                      " ${listModel[2]
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
                                                        "Quantity : ${listModel[2]
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

     */

    /*
    return Consumer <CartItemPage>(
        builder: (context, cartItemPage, child) {
      return Scaffold(
      body: Center(
        child: Container(
        //  width: MediaQuery.of(context).size.width * 1.0,
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
                //    height: 210,
                  //  width: MediaQuery.of(context).size.width * 0.90,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return  Container(
                          child:  Material(
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
                                                      favor.added(listModel![index]) ;
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
                                                    cartItemPage.checkIfProductInCart(listModel![index]);
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
                                            "Name : ${listModel![index]
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
                          /*
                          InkWell(
                            onTap: (){},
                            child: Column(
                              children: [
                                ListTile(
                                  subtitle: Text("${listModel![3].title.toString()}"),
                                  title: Image.network(
                                        listModel[3].avatar.toString(),
                                        fit: BoxFit.fill),


                                ) ,

                                ListTile(
                                  subtitle: Text("${listModel[4].title.toString()}"),
                                  title: Image.network(
                                      listModel[4].avatar.toString(),
                                      fit: BoxFit.fill),


                                ) ,


                              ],
                            ),
                          ),


                           */

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
  }
    ) ;


     */

  }
}
