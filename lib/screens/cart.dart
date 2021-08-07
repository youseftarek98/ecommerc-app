
import 'package:flutter/material.dart';
import 'package:project_ecomerce/helper/database_helper.dart';
import 'package:project_ecomerce/model_two/cart_item.dart';
import 'package:project_ecomerce/models/products.dart';
import 'package:provider/provider.dart';



class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  DatabaseHelper helper =DatabaseHelper() ;
  ProductsModel productsModel = ProductsModel() ;
  @override
  Widget build(BuildContext context) {

    return Consumer<CartItemPage>(
        builder: (context ,cartItem , child ){
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.purple,

                title: Center(child: Text("check out page   ${cartItem.totalPrice}")),
              ),

              body: cartItem.basketItems.length == 0 ?
              Center(
                  child: Text("No items in your cart")) :
             FutureBuilder(
               future: helper.grtAllUsers(),
                 builder: (context , AsyncSnapshot snapshot){
                if (snapshot.hasData){
                  return Center(child: CircularProgressIndicator(),) ;
                }else  {
                  return ListView.builder(
                      itemCount: cartItem.basketItems.length,
                      itemBuilder: (context , index){
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListTile(
                                title: Text(cartItem.basketItems[index].title.toString()),
                                subtitle: Text(cartItem.basketItems[index].price_final_text.toString()) ,
                                leading: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                    cartItem.basketItems[index].avatar.toString(),
                                  ),
                                ),
                                trailing: IconButton(
                                    onPressed: (){
                                      cartItem.remove(cartItem.basketItems[index]);
                                    },
                                    icon: Icon(Icons.delete)
                                ),
                              )

                            ],
                          ),
                        )
                        ;
                      }
                  ) ;
                }
                 }
             ) ,


          );
        });
  }
}




