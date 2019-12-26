class News {

  String newsTitle, newsDesc, newsImage, newsDate;

  News({this.newsTitle, this.newsDesc ,this.newsImage, this.newsDate});

  News.fromJson(Map<String, dynamic> json){
    newsTitle = json['name'];
    newsDesc = json['email'];
  }

}