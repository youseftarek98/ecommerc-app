import 'package:flutter/material.dart';
import 'package:project_ecomerce/models/products.dart';
import 'cart.dart';
import 'search.dart';
import 'feeds.dart';
import 'user_info.dart';
import 'home.dart';

class BottomBarScreens extends StatefulWidget {
  const BottomBarScreens({Key? key}) : super(key: key);

  @override
  _BottomBarScreensState createState() => _BottomBarScreensState();
}

class _BottomBarScreensState extends State<BottomBarScreens> {
  ProductsModel productsModel =ProductsModel () ;
late List<Map<String , dynamic>> _pages ;
  int _selectedPagesIndex = 0 ;
void initState() {
  _pages =[
    { "page" : Home()},
    { "page" : Feeds()},
    { "page" : Search()},
    { "page" : Cart()},
    { "page" : UserInfo()}
  ] ;
}

void _selectedPage (int index){
  setState(() {
    _selectedPagesIndex = index ;
  });
}

  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPagesIndex]["page"],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight *0.98,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey ,
                  width: 0.5 ,
                )
              )
            ),
            child: BottomNavigationBar(
              onTap: _selectedPage,
              backgroundColor:  Theme.of(context).primaryColor,
              unselectedItemColor: Colors.black ,//Theme.of(context).textSelectionColor,
              selectedItemColor: Colors.purple,
              currentIndex: _selectedPagesIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                  label: "Home" ,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.rss_feed),
                  label: "Feeds" ,
                ),
                BottomNavigationBarItem(
                  activeIcon: null,
                  icon: Icon(null),
                  label: "Search" ,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag),
                  label: "Cart" ,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "User" ,
                ),
              ],

            ),
          ),
        ),
      ),

      floatingActionButtonLocation:
        FloatingActionButtonLocation.miniCenterDocked ,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(

          backgroundColor: Colors.purple,
          hoverElevation: 10,
          splashColor: Colors.grey,
          tooltip: "Search",
          child: Icon(Icons.search , color: Colors.white,),
          onPressed: () {
            showSearch(context: context, delegate: Data()) ;
          },
        ),
      ) ,


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
      child:  Container(
        child: FutureBuilder<List<ProductsModel >>(
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
                        Navigator.of(context).pushNamed("FeedProducts");
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
      ),

    );
  }

}

