import 'package:fluter_timeApp/screens/choose_location.dart';
import 'package:fluter_timeApp/services/world_time.dart';
import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  final List<String> listExample;
  Search(this.listExample);

  String selectedResult = "";
  List<String> recentList;
  String choosenCity;

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(child: buildSuggestions(context)),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList
        : suggestionList
            .addAll(listExample.where((e) => e.toLowerCase().contains(query)));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          onTap: () {
            choosenCity = suggestionList[index];
            Navigator.pop(context, choosenCity);
          },
        );
      },
    );
  }
}
