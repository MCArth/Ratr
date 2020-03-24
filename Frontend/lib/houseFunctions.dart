import 'package:http/http.dart' as http;
import 'dart:convert';

// Classes, getters, builders, etc. for accessing json go here for the time being //

//TODO modify basic house class and factory as per criteria established in deliverable 2 

//This is a basic house classfor display purposes, generally to be substantiated by json

List<House> houseList = [];

class House{
  int id;
  int avgRating;
  int bedrooms;
  int houseNum;
  double lat;
  double long;
  String postCode;
  String street;

  House({this.lat,this.long,this.avgRating,this.bedrooms,this.houseNum,this.street,this.postCode});

  factory House.fromJson(Map<String,dynamic> json){
    return House(
      lat: json["lat"],
      long: json["long"],
      avgRating: json["avgRating"],
      houseNum: json["houseNumber"],
      street: json["houseStreet"],
      bedrooms: json["roomInfo"]["numBedrooms"],
      postCode: json["postCode"],
    );
  }
}

// Retreives a list of houses from database
Future fetchHouses() async {
  houseList = [];
  final response = await http.get('https://us-central1-ridr-cc2ec.cloudfunctions.net/getHouses');

  if(response.statusCode == 200){
    //REturn house from json
    //final out = HouseBasic.fromJson(json.decode(response.body));
    var data = json.decode(response.body);
    print(data);
    for(Map i in data){
      houseList.add(House.fromJson(i));
    }
    print("length is");
    print(houseList.length);
    print(houseList[0].bedrooms);
    return(houseList);
  } else {
    throw Exception('Failed to load houses!');
  }
}