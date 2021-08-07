import 'package:flutter/material.dart';
import 'package:project_ecomerce/models/import.dart';





class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Center(
        child: Text("Search"),
      ),
    );
  }
}




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
              List filters = listModel!.where((element) => element.name!.toLowerCase().contains(query)).toList() ;
              return ListView.builder(
                itemCount: query == "" ? listModel.length.toInt() : filters.length.toInt(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      showResults(context) ;
                     // Navigator.of(context).pushNamed("menu");
                      query = query== "" ? listModel[index].toString()  : filters [index].toString();
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