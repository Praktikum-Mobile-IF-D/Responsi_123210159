import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:coffeeapps/service/apiclient.dart';
import 'package:coffeeapps/service/globals.dart';
import 'package:coffeeapps/response/kopi.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class Detail extends StatefulWidget {
  Detail({super.key, required this.kopi});

  final JenisKopi kopi;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool isThere = false;

  @override
  void initState() {
    super.initState();
    fetchBookmark();
  }

  void fetchBookmark() async {
    var kopi = await ApiClient.findKopiById(widget.kopi.id!);
    setState(() {
      isThere = kopi != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (isThere) {
            await ApiClient.removeFavorite(widget.kopi.id!);
            showSuccess(context, 'Successfully removed from favorites');
            setState(() {
              isThere = false;
            });
          } else {
            await ApiClient.addFavorite(widget.kopi);
            showSuccess(context, 'Successfully added to favorites');
            setState(() {
              isThere = true;
            });
          }
        },
        child: Icon(isThere ? Icons.bookmark_remove : Icons.bookmark_add),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: bgBlue,
        title: Text(
          widget.kopi.name!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            height: 200,
            width: double.infinity,
            child: Image.network(
              widget.kopi.imageUrl!,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Text(widget.kopi.name!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(widget.kopi.region!),
          SizedBox(height: 10),
          Text(widget.kopi.description!),
          HtmlWidget(widget.kopi.description!)
        ],
      ),
    );
  }
}
