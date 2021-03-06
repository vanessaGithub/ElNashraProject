import 'package:elnashra_flutter_project/MyAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'news.dart';
import 'dart:convert';
import 'dart:async';
import 'package:share/share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_widget/search_widget.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<News> newsAll = new List();


//  List allTitles = [
//    "أنور قرقاش: قوة الرياض والقاهرة ضرورية لكل العرب",
//    "التحكم المروري: جريح نتيجة تصادم مركبة بدراجة نارية بمحلة الاوزاعي",
//    "قائد الجيش التقى حنكش وبحث مع سفير بريطانيا بعلاقات التعاون بين جيشي البلدين"
//  ];

  List allTitles = [];
  List allImages = [];
  List allContents = [];
  static String elnashraStr = 'ElNashra';

  List<News> newsList = [];
  List<News> filteredNewsList = List();
  News newsObj;
  String newsTitle = "", newsImage = "", newsContent = "", newsDate = "";

  GlobalKey<RefreshIndicatorState> refreshKey;

  Icon searchIcon = Icon(Icons.search);

  Icon searchIconMutate = Icon(Icons.search);

  Widget searchTxt = Text(
    elnashraStr,
  style: TextStyle(
    color: Colors.blueAccent,
  ),
  );

  Widget searchTxtMutate;

  @override
  void initState() {
    super.initState();
    getNews();
  }





  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SafeArea(
        child: Scaffold(
//          appBar: MyAppBar(
//              title:'ElNashra'
//          ),
////
          appBar: AppBar(
            iconTheme: new IconThemeData(color: Colors.blueAccent),
            centerTitle: true,
            actions: <Widget>[
//              IconButton(
//                icon: Icon(
//                  Icons.menu,
//                  color: Colors.blueAccent,
//                ),
//                onPressed: () {
//                  // do something
//                  toggleDrawer();
//                },
//              ),

            ],

            leading:
            IconButton(
              icon:
              searchIcon,
              onPressed: (){
                setState(() {
                  if(this.searchIcon.icon == Icons.search){
                    this.searchIcon = Icon(Icons.cancel);
                    this.searchTxt = TextField(
                      autofocus: true,
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Some Text Here'),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      onChanged: (string) {
                        setState(() {
                          filteredNewsList = newsList.where( (u) =>
                          (u.newsTitle.toLowerCase().contains(string.toLowerCase()) ||
                              u.newsDesc.toLowerCase().contains(string.toLowerCase()) ||
                              u.newsDate.toLowerCase().contains(string.toLowerCase())))
                              .toList();
                        });
                      },
                    );
                  } else {
                    setState(() {filteredNewsList = newsList;});
                    this.searchIcon = Icon(Icons.search);
                    this.searchTxt = Text(
                      elnashraStr,
                      style: TextStyle(
                        color: Colors.blueAccent,
                      ),
                    );;
                  }
                });
              },
            ),

            title: searchTxt,
            backgroundColor: Colors.grey[100],
          ),

          endDrawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Drawer Header'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('Item 1'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Item 2'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),

          body:  RefreshIndicator(
            key: refreshKey,
            onRefresh: getNews,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Stack(children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image(
                                    height: 200,
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://files.elnashra.com/elnashra/imagine/pictures_730_400/4761937_1576596487.jpg'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                " تُسمّينه يسوع(لو1: 31) ",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ])
                      ],
                    ),
                    SizedBox(height: 20),
//                SearchWidget(
//                  dataList: newsList,
//                  hideSearchBoxWhenItemSelected: false,
//                  listContainerHeight: MediaQuery.of(context).size.height/4,
//                  queryBuilder: (query, newsList) {
//                    return newsList
//                        .where((item) => item.username
//                    .toLoweCase()
//                    .contains(query.toLowerCase()))
//                        .toList();
//                  },
//
//                ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredNewsList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10,0,10,0),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, '/newsdetails', arguments: {
                                'image' : newsList[index].newsImage,
                                'title' : newsList[index].newsTitle,
                                'details': newsList[index].newsDesc,
                                'date' : newsList[index].newsDate,
                              });
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusDirectional.circular(3)),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 5, 5, 10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                              filteredNewsList[index].newsTitle,
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                decoration: TextDecoration.none,
                                                fontSize: 15,
                                              )
                                          ),

                                          Row(
                                            textDirection: TextDirection.rtl,
                                            children: <Widget>[
                                              Text(
                                                  filteredNewsList[index].newsDate,
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                    decoration: TextDecoration.none,
                                                    fontSize: 13,
                                                  )
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.share),
                                                iconSize: 13,
                                                onPressed: (){
                                                  Share.share('check out my website https://example.com');
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      flex: 2,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadiusDirectional.circular(3)),
                                        clipBehavior: Clip.antiAlias,
                                        child: Image.network(
                                          newsList[index].newsImage,
                                          fit: BoxFit.fill,
                                          height: 65,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
          ),
          ),
        // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
  }



  Future<void> getNews() async {

    refreshKey = GlobalKey<RefreshIndicatorState>();

    newsList = [];

    var url =
        'https://raw.githubusercontent.com/vanessaGithub/elnashraflutter/master/elnashranews.json';
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List newsJson = json.decode(response.body);

      if(newsJson!=null) {
        for (int i = 0; i < newsJson.length; i++) {
          newsTitle = newsJson[i]['title'];
          newsImage = newsJson[i]['image'];
          newsContent = newsJson[i]['content'];
          newsDate = newsJson[i]['date'];

          newsObj = News(newsTitle: newsTitle, newsImage: newsImage, newsDesc: newsContent, newsDate: newsDate);

          allTitles.add(newsJson[i]['title']);
          allImages.add(newsJson[i]['image']);
          allContents.add(newsJson[i]['content']);

          newsList.add(newsObj);
        }
      }

      setState(() {
        filteredNewsList = newsList;
      });

      print('map json' + newsJson.toString());
    }
  }

}
