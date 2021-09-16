
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ecomerce/consts/col_ors.dart';
import 'package:project_ecomerce/consts/global.dart';
import 'package:project_ecomerce/consts/pyment.dart';
import 'package:project_ecomerce/helper/cart_empty.dart';
import 'package:project_ecomerce/helper/database_helper.dart';
import 'package:project_ecomerce/model_two/cart_item.dart';
import 'package:project_ecomerce/models/products.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:uuid/uuid.dart';


class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  DatabaseHelper helper = DatabaseHelper();

  ProductsModel productsModel = ProductsModel();
  GlobalMethods globalMethods = GlobalMethods();


  @override
  void initState() {
    productsModel ;
    super.initState();
    StripeServices.init();
  }
  var response;
  Future<void> payWithCard({required int amount})async{

    /*
    ProgressDialog pd = ProgressDialog(context: context);
   await pd.show(
      max: 100,
      msg: 'Please wait...',
      progressType: ProgressType.valuable,
    );

     */

    response = await StripeServices.payNowHandler(currency: 'USD',
        amount: amount.toString() );
    print('response ====================: ${response.success}');
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration: Duration(milliseconds: response.success == true ? 1200 : 3000),
    ));
    /*
   await pd.isOpen();
    print('response : ${response.success}');
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration: Duration(milliseconds: response.success == true ? 1200 : 3000),
    ));

     */
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<CartItemPage>(builder: (context, cartItem, child) {
      return Scaffold(
        bottomSheet: checkoutSection(context, cartItem.totalPrice.toDouble()),
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text('Cart (${cartItem.listItem()!.length})'),
          actions: [
            IconButton(
              onPressed: () {
                globalMethods.showDialogg(
                    'Clear cart!',
                    'Your cart will be cleared!',
                        () => cartItem.clearCart(productsModel),
                    context);
                // cartProvider.clearCart();
              },
              icon: Icon(Icons.delete),
            )
          ],
        ),
        body: cartItem.listItem()!.length == 0
            ? Center(
            child: SingleChildScrollView(
                child: CartEmpty()) //Text("No items in your cart")
        )
            : FutureBuilder(
            future: helper.grtAllUsers(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Stack(
                  children: [
                    ListView.builder(
                        itemCount: cartItem.listItem()!.length ,//basketItems.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListTile(
                                title: Text(cartItem.listItem()![index].title.toString()),
                                leading: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                    cartItem.listItem()![index].avatar
                                        .toString(),
                                  ),
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      cartItem.remove(cartItem.listItem()![index]);
                                    },
                                    icon: Icon(Icons.delete)),
                              ),
                              ListTile(

                               // title: Text("${cartItem.counter.toString()}"),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Text(
                                    cartItem.listItem()![index].price_final_text
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                          leading:IconButton(
                                    onPressed: () {

                                      cartItem.listItem ();
                                      //cartItem.totalItems() ;
                                      // cartItem.getTotalPrice();
                                      // cartItem.add(productsModel);
                                      cartItem.add(cartItem.listItem()![index]);
                                      //cartItem.getTotalPrice();
                                      cartItem.getCountByItem(productsModel) ;
                                      //cartItem.counter;
                                    },
                                    icon: Icon(Icons.add)),

                                trailing: IconButton(
                                    onPressed: () {
                                      //cartItem.remove(productsModel);
                                      //cartItem.counter;
                                      cartItem.remove(cartItem.listItem()![index]);
                                    },
                                    icon: Icon(Icons.remove)),
                              ),

                            ],
                          );
                        }) ,

                  ],
                );
              }
            }),
      );
    });
  }


  Widget checkoutSection(BuildContext ctx, double subtotal) {
    final cartProvider = Provider.of<CartItemPage>(context);
    var uuid = Uuid();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            /// mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(colors: [
                      ColorsConsts.gradiendLStart,
                      ColorsConsts.gradiendLEnd,
                    ], stops: [
                      0.0,
                      0.7
                    ]),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () async {

                          double amountInCents = subtotal * 1000;
                          int intengerAmount = (amountInCents / 10).ceil();
                          await payWithCard(amount: intengerAmount);

                          cartProvider.clearCart(productsModel);
                      },
                      splashColor: Theme.of(ctx).splashColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Checkout',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(ctx).textSelectionColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Text(
                'Total: \t',
                style: TextStyle(
                    color: Theme.of(ctx).textSelectionColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'EG  ${subtotal.toStringAsFixed(2)}',
                //textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }

}


