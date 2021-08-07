import 'package:flutter/material.dart';
import 'package:project_ecomerce/model_two/favvorite_item.dart';

import 'package:provider/provider.dart';

class Feeds extends StatelessWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Favorite>(
        builder: (context ,favorite , child ){
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.purple,
                title: Center(child: Text("Favorite Page")),
              ),

              body: favorite.favorite.length == 0 ?
              Center(
                  child: Text("No items in your Favorite")) :
              ListView.builder(
                  itemCount: favorite.favorite.length,
                  itemBuilder: (context , index){
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListTile(
                            title: Text(favorite.favorite[index].title.toString()),
                            subtitle: Text(favorite.favorite[index].price_final_text.toString()) ,
                            leading: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                favorite.favorite[index].avatar.toString(),
                              ),
                            ),
                            trailing: IconButton(
                                onPressed: (){
                                  favorite.removeFavorite(favorite.favorite[index]);
                                },
                                icon: Icon(Icons.favorite_border)

                            ),
                          )

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
