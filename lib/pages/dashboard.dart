import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:coffeeapps/pages/detail.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final kopi = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Detail(kopi: kopi),
                  ));
                },
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.network(
                          kopi['kopiLogo'],
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    kopi['kopiTitle'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    kopi['kopiType'] != null
                                        ? kopi['kopiType'][0]
                                        : '',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    '${kopi['coffeeName']} - ${kopi['kopi']}',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('https://fake-coffee-api.vercel.app/api'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['Kopi'];
    } else {
      throw Exception('Failed to load data');
    }
  }
}
