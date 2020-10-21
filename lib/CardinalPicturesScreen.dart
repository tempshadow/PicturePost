import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
// ignore: must_be_immutable
class CardinalPicturesScreen extends StatefulWidget {
  var pictureIds;
  String pictureSetTimestamp;

  CardinalPicturesScreen(this.pictureIds, this.pictureSetTimestamp);

  @override
  _State createState() => _State();


}

class _State extends State<CardinalPicturesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.green,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Center(
            child: Text(DateFormat.yMd().add_jm().format(
                DateTime.parse(widget.pictureSetTimestamp)),
                style: TextStyle(color: Colors.black)
            ),
          )
        ),
        body:
        ListView(
          children: <Widget>[
            if(widget.pictureIds[0] == 0)
            Container(
              color: Colors.black,
              height: 25,
              child: Center(child: Text("North", style: TextStyle(
                  color: Colors.white
              ),
              )
              ),
            )
            else
            Container(
              color: Colors.green,
              height: 25,
              child: Center(child: Text("North", style: TextStyle(
                  color: Colors.white
              ),
              )
              ),
            ),
            if(widget.pictureIds[0] == 0) Image(image: AssetImage(
                'assets/noImage.jpg'))
            else CachedNetworkImage(
              imageUrl: "https://picturepost.ou.edu/app/GetPicture?pictureId=" +
                  widget.pictureIds[0].toString(),
              placeholder: (context,url) => Center(
                  child: CircularProgressIndicator()),
              errorWidget: (context,url,error) => new Icon(Icons.error),
            ),
            if(widget.pictureIds[1] == 0) Container(
              color: Colors.black,
              height: 25,
              child: Center(child: Text("North East", style: TextStyle(
                  color: Colors.white
              ),
              )
              ),
            )
            else Container(
              color: Colors.green,
              height: 25,
              child: Center(child: Text("North East", style: TextStyle(
                  color: Colors.white
              ),
              )
              ),
            ),
            if(widget.pictureIds[1] == 0) Image(image: AssetImage(
                'assets/noImage.jpg'))
            else CachedNetworkImage(
              imageUrl: "https://picturepost.ou.edu/app/GetPicture?pictureId=" +
                  widget.pictureIds[1].toString(),
              placeholder: (context,url) => Center(
                  child: CircularProgressIndicator()),
              errorWidget: (context,url,error) => new Icon(Icons.error),
            ),
            if(widget.pictureIds[2] == 0) Container(
              color: Colors.black,
              height: 25,
              child: Center(child: Text("East", style: TextStyle(
                  color: Colors.white
              ),
              )
              ),
            )
            else Container(
              color: Colors.green,
              height: 25,
              child: Center(child: Text("East", style: TextStyle(
                  color: Colors.white
              ),
              )
              ),
            ),
            if(widget.pictureIds[2] == 0) Image(image: AssetImage(
                'assets/noImage.jpg'))
            else CachedNetworkImage(
              imageUrl: "https://picturepost.ou.edu/app/GetPicture?pictureId=" +
                  widget.pictureIds[2].toString(),
              placeholder: (context,url) => Center(
                  child: CircularProgressIndicator()),
              errorWidget: (context,url,error) => new Icon(Icons.error),
            ),
            if(widget.pictureIds[3] == 0) Container(
              color: Colors.black,
              height: 25,
              child: Center(child: Text("South East", style: TextStyle(
                  color: Colors.white
              ),
              )
              ),
            )else
              Container(
                  color: Colors.green,
                  height: 25,
                  child: Center(child: Text("South East", style: TextStyle(
                      color: Colors.white
                  ),
                  )
                  ),
              ),
            if(widget.pictureIds[3] == 0) Image(image: AssetImage(
                'assets/noImage.jpg'))
            else CachedNetworkImage(
              imageUrl: "https://picturepost.ou.edu/app/GetPicture?pictureId=" +
                  widget.pictureIds[3].toString(),
              placeholder: (context,url) => Center(
                  child: CircularProgressIndicator()),
              errorWidget: (context,url,error) => new Icon(Icons.error),
            ),
            if(widget.pictureIds[4] == 0) Container(
              color: Colors.black,
              height: 25,
              child: Center(child: Text("South", style: TextStyle(
                  color: Colors.white
              ),
              )
              ),
            )
            else Container(
              color: Colors.green,
              height: 25,
              child: Center(child: Text("South", style: TextStyle(
                  color: Colors.white
              ),
              )
              ),
            ),
            if(widget.pictureIds[4] == 0) Image(image: AssetImage(
                'assets/noImage.jpg'))
            else CachedNetworkImage(
              imageUrl: "https://picturepost.ou.edu/app/GetPicture?pictureId=" +
                  widget.pictureIds[4].toString(),
              placeholder: (context,url) => Center(
                  child: CircularProgressIndicator()),
              errorWidget: (context,url,error) => new Icon(Icons.error),
            ),
            if(widget.pictureIds[5] == 0) Container(
              color: Colors.black,
              height: 25,
              child: Center(child: Text("South West", style: TextStyle(
                  color: Colors.white
              ),
              )
              ),
            )
            else Container(
              color: Colors.green,
              height: 25,
              child: Center(child: Text("South West", style: TextStyle(
                  color: Colors.white
              ),
              )
              ),
            ),
            if(widget.pictureIds[5] == 0) Image(image: AssetImage(
                'assets/noImage.jpg'))
            else CachedNetworkImage(
              imageUrl: "https://picturepost.ou.edu/app/GetPicture?pictureId=" +
                  widget.pictureIds[5].toString(),
              placeholder: (context,url) => Center(
                  child: CircularProgressIndicator()),
              errorWidget: (context,url,error) => new Icon(Icons.error),
            ),
            if(widget.pictureIds[6] == 0) Container(
              color: Colors.black,
              height: 25,
              child: Center(child: Text("West", style: TextStyle(
                  color: Colors.white
              ),
              )
              ),
            )
            else Container(
              color: Colors.green,
              height: 25,
              child: Center(child: Text("West", style: TextStyle(
                  color: Colors.white
              ),
              )
              ),
            ),
            if(widget.pictureIds[6] == 0) Image(image: AssetImage(
                'assets/noImage.jpg'))
            else CachedNetworkImage(
              imageUrl: "https://picturepost.ou.edu/app/GetPicture?pictureId=" +
                  widget.pictureIds[6].toString(),
              placeholder: (context,url) => Center(
                  child: CircularProgressIndicator()),
              errorWidget: (context,url,error) => new Icon(Icons.error),
            ),
            if(widget.pictureIds[7] == 0) Container(
              color: Colors.black,
              height: 25,
              child: Center(child: Text("North West", style: TextStyle(
                  color: Colors.white
              ),
              )
              ),
            )
            else Container(
              color: Colors.green,
              height: 25,
              child: Center(child: Text("North West", style: TextStyle(
                  color: Colors.white
              ),
              )
              ),
            ),
            if(widget.pictureIds[7] == 0) Image(image: AssetImage(
                'assets/noImage.jpg'))
            else CachedNetworkImage(
              imageUrl: "https://picturepost.ou.edu/app/GetPicture?pictureId=" +
                  widget.pictureIds[7].toString(),
              placeholder: (context,url) => Center(
                  child: CircularProgressIndicator()),
              errorWidget: (context,url,error) => new Icon(Icons.error),
            ),
            if(widget.pictureIds[8] == 0) Container(
              color: Colors.black,
              height: 25,
              child: Center(child: Text("Up", style: TextStyle(
                  color: Colors.white
              ),
              )
              ),
            )
            else Container(
              color: Colors.green,
              height: 25,
              child: Center(child: Text("Up", style: TextStyle(
                  color: Colors.white
              ),
              )
              ),
            ),
            if(widget.pictureIds[8] == 0) Image(image: AssetImage(
                'assets/noImage.jpg'))
            else CachedNetworkImage(
              imageUrl: "https://picturepost.ou.edu/app/GetPicture?pictureId=" +
                  widget.pictureIds[8].toString(),
              placeholder: (context,url) => Center(
                  child: CircularProgressIndicator()),
              errorWidget: (context,url,error) => new Icon(Icons.error),
            ),
          ],
        )
    );
  }
}