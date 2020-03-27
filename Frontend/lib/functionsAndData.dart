import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geocoder/geocoder.dart';

// Classes, getters, builders, etc. for accessing json go here for the time being //
// CLASSES //



// Global lists storing data from database
List<House> houseList = [];
List<Landlord> landlordList = [];

class Landlord{
  String name;
  double avgRating;
  List<dynamic> houses;
  List<dynamic> reviews;

  Landlord({this.name,this.avgRating,this.houses,this.reviews});

  factory Landlord.fromJson(Map<String,dynamic> json){
    return Landlord(
      name: json["name"],
      reviews: json["reviews"],
      houses: json["houses"],
      avgRating: json["avgRating"].toDouble(),
    );
  }
}

//TODO add room attributes, create room class
class House{
  double avgRating;
  int bedrooms,bathrooms,houseNum,price;
  double lat,long;
  String postCode,street,landlord;
  LatLng latlng;
  List<dynamic> reviews;

  House({this.lat,this.long,this.avgRating,this.bedrooms,this.houseNum,this.street,this.postCode,this.price,this.latlng,this.bathrooms,this.landlord,this.reviews});

  factory House.fromJson(Map<String,dynamic> json){
    return House(
      lat: json["lat"],
      long: json["long"],
      avgRating: json["avgRating"].toDouble(),
      houseNum: json["houseNumber"],
      street: json["houseStreet"],
      bedrooms: json["roomInfo"]["numBedrooms"],
      postCode: json["postCode"],
      bathrooms: json["roomInfo"]["numBathrooms"],
      landlord: json["landlord"],
      price: json["pricePerAnnum"],
      reviews: json["reviews"],
      latlng: LatLng(json["lat"],json["long"])
    );
  }
}

class Review{
  double rating;
  String review;

  Review({this.rating, this.review});

  factory Review.fromJson(Map<String,dynamic> json){
    return Review(
      rating: json["rating"].toDouble(),
      review: json["review"]
    );
    
  }
}

// Retreives a list of houses from database
Future fetchHouses() async {
  //clears previous version of houseList
  houseList = [];
  final response = await http.get('https://us-central1-ridr-cc2ec.cloudfunctions.net/getHouses');

  if(response.statusCode == 200){
    //REturn house from json
    //final out = HouseBasic.fromJson(json.decode(response.body));
    var data = json.decode(response.body);
    for(Map i in data){
      houseList.add(House.fromJson(i));
    }
    for(House house in houseList){
      for(var j = 0; j < house.reviews.length; j++){
        house.reviews[j] = Review.fromJson(house.reviews[j]);
      }
    }
  } else {
    throw Exception('Failed to load houses! (Probably the server is down)');
  }
}

Future fetchLandlords() async {
  //Clears previously stored version of landlord list
  landlordList = [];
  final response = await http.get('https://us-central1-ridr-cc2ec.cloudfunctions.net/getLandlords');
  if(response.statusCode == 200){
    var data = json.decode(response.body);
    for(Map i in data){
      landlordList.add(Landlord.fromJson(i));
    }
    // Fixing json encoding stuff within landlord datastructure internal lists, this is NOT good practice but it works 
    for(Landlord landlord in landlordList){
      for(var j = 0; j < landlord.reviews.length; j++){
        landlord.reviews[j] = Review.fromJson(landlord.reviews[j]);
      }
      for(var k = 0; k < landlord.houses.length; k++){
        landlord.houses[k] = new LatLng(landlord.houses[k]["lat"],landlord.houses[k]["long"]);
      }
    }
  }
  else{
    throw Exception('Failed to load landlords! (Probably the server is down');
  }
}
 
// THE FUN ZONE //

// Takes an address of form house number + street
// Assumes location is Bath
// To acccess the value this returns, use the following syntax:
//
//   var result = getFromAddress("The address as string (e.g. 80 Third Avenue)");
//   result.then((latlng) => print(latlng));
//   where you replace print with whatever you want to do to the result 

Future<LatLng> getFromAddress(String address) async{
  var query = address + ", Bath";
  var addresses = await Geocoder.local.findAddressesFromQuery(query);
  var first = addresses.first;
  LatLng out = new LatLng(first.coordinates.latitude,first.coordinates.longitude);
  return out;
}


//Checks if a house with a given latLng is in database, returns true if already exists, else false

bool houseExists(LatLng latlng){
  for(House house in houseList){
    if(house.latlng == latlng){
      return true;
    }
  }
  return false;
}

void printAllHouses(){
  for(House house in houseList){
    print(house.houseNum.toString() + house.street);
  }
}