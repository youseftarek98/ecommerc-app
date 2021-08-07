

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:project_ecomerce/models/categories.dart';

class ScreensCategories extends StatefulWidget {
  const ScreensCategories({Key? key}) : super(key: key);

  @override
  _ScreensCategoriesState createState() => _ScreensCategoriesState();
}

class _ScreensCategoriesState extends State<ScreensCategories> {
  ModelCategories categories = ModelCategories();

  @override
  void initState() {
    super.initState();
    categories;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<ModelCategories>>(
          future: categories.getData(),
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
              List<ModelCategories>? listModel = snap.data;
              return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 1),
                height: 150,
                width: 150 ,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1 ,
                    childAspectRatio: 190 / 300 ,
                    crossAxisSpacing: 10 ,
                    mainAxisSpacing: 10 ,
                  ),
                  itemCount: listModel!.length ,
                  itemBuilder: (context , index){
                    return  Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      listModel[index].avatar.toString(),
                                  ),
                                fit: BoxFit.cover
                              )
                            
                          ),

                        ),
                        Positioned(
                          bottom: 0,
                            left: 10,
                            right: 10,
                            child: Center(
                              child: Container(
                               // margin: EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 16),
                               padding: EdgeInsets.only(left: 20 , right:  20 , top: 2.5 , bottom:  2.5),
                               color: Colors.grey , //Theme.of(context).backgroundColor,
                                child: Text(
                                    listModel[index].name.toString() ,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500 ,
                                  fontSize: 22 ,
                                  color: Colors.black//Theme.of(context).backgroundColor,
                                ),
                                ),
                              ),
                            )
                        )
                      ],
                    ) ;
                  },
                )  ,
              );
            } else {
              return Center(
                child: Text("No Data Found"),
              );
            }
          }
          ),
    );
  }
}


/*
class Data extends SearchDelegate{
  ProductsModel model = ProductsModel();
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query = "" ;
      }, icon: Icon(Icons.close))
    ] ;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, null);
    }, icon: Icon(Icons.arrow_back , color: Colors.black,)) ;
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("$query") ;
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    return Center(
      child:  FutureBuilder<List<ProductsModel >>(
            future: model.getProducts(),
            builder: (context, snap) {
              if (snap.connectionState != ConnectionState.done) {
                return Container(
                  height: double.infinity,
                  width: 400,
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
                List filters = listModel!.where((element) => element.name!.toLowerCase().startsWith(query)).toList() ;
                return ListView.builder(
                  itemCount: query == "" ? listModel.length.toInt() : filters.length.toInt(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed("menu");
                        query = query== "" ? listModel[index]  : filters [index];
                        showResults(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: query == "" ? Container(
                          child: Card(
                            color: Colors.orange[100],
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(30)),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                      listModel[index].name.toString()),
                                  subtitle: Text(
                                      "Number : ${listModel[index].id}"),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        listModel[index]
                                            .avatar.toString()),
                                    radius: 50,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ) :Container(
                          child: Card(
                            color: Colors.orange[100],
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(30)),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                      filters[index].name.toString()),
                                  subtitle: Text(
                                      "Number : ${filters[index].id}"),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        filters[index]
                                            .avatar.toString()),
                                    radius: 50,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text("No Data Found"),
                );
              }
            }),

    );
  }

}


 */