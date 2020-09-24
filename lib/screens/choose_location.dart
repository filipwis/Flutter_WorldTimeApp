import 'dart:convert';
import 'package:fluter_timeApp/services/search.dart';
import 'package:fluter_timeApp/services/world_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = List();
  List<String> forSearching = List();

  Future<void> loadJsonData() async {
    String jsonText = await rootBundle.loadString('assets/data/locations.json');
    List<dynamic> loc = await json.decode(jsonText);
    for (int index = 0; index < loc.length; index++) {
      setState(() {
        locations.add(WorldTime(
            url: loc[index]['url'], location: loc[index]['location']));
        forSearching.add(loc[index]['location']);
      });
    }
  }

  @override
  void initState() {
    this.loadJsonData();
  }

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose a Location',
          style:
              TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlue[900],
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                dynamic result = await showSearch(
                    context: context, delegate: Search(forSearching));
                int index = locations
                    .indexWhere((element) => element.location == result);
                updateTime(index);
              })
        ],
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    updateTime(index);
                  },
                  leading: Icon(
                    Icons.flag,
                    color: Colors.lightBlue[900],
                  ),
                  title: Text(
                    locations[index].location,
                    style: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
