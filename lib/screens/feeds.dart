import 'package:flutter/material.dart';
import 'package:project_ecomerce/consts/global.dart';
import 'package:project_ecomerce/model_two/cart_item.dart';
import 'package:project_ecomerce/model_two/favvorite_item.dart';
import 'package:project_ecomerce/models/products.dart';

import 'package:provider/provider.dart';

class Feeds extends StatefulWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  ProductsModel productsModel = ProductsModel();
  GlobalMethods globalMethods = GlobalMethods();
  @override
  Widget build(BuildContext context) {
    return Consumer<Favorite>(
        builder: (context ,favorite , child ){
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).backgroundColor,
                title: Text('Favorites (${favorite.listItems()!.length})'),
                actions: [
                  IconButton(
                    onPressed: () {
                      globalMethods.showDialogg(
                          'Clear Favorite!',
                          'Your favorites will be cleared!',
                              () => favorite.clearCarts(productsModel),
                          context);
                      // cartProvider.clearCart();
                    },
                    icon: Icon(Icons.delete),
                  )
                ],
              ),
            /*
              appBar: AppBar(
                backgroundColor: Colors.purple,
                title: Center(child: Text("Favorite Page")),
              ),


             */
              body: favorite.listItems()!.length == 0 ?
              Center(
                  child: Text("No items in your Favorite")) :
              ListView.builder(
                  itemCount: favorite.listItems()!.length,
                  itemBuilder: (context , index){
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListTile(
                            title: Text(favorite.listItems()![index].title.toString()),
                            leading: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                favorite.listItems()![index].avatar
                                    .toString(),
                              ),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  favorite.remove(favorite.listItems()![index]);
                                },
                                icon: Icon(Icons.delete)),
                            subtitle: Container(
                              child: Text("${favorite.listItems()![index].price_final_text.toString()}"),
                            ),
                          ),

                        ],
                      ),
                    )
                    ;
                  }
              )


          );
        });
  }
}
