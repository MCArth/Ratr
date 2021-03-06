import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geocoder/geocoder.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nexus_app/mapStuff.dart';

// Classes, getters, builders, etc. for accessing json go here for the time being //
// CLASSES //

// Global lists storing data from database
List<House> houseList = [];
List<Landlord> landlordList = [];

class Landlord {
  String name;
  int uniqueID;
  double avgRating;
  List<dynamic> houses, reviews;

  Landlord(
      {this.name, this.avgRating, this.houses, this.reviews, this.uniqueID});

  // gets number of properties owned by a landlord
  int get numProperties {
    return houses.length;
  }

  factory Landlord.fromJson(Map<String, dynamic> json) {
    return Landlord(
      name: json["name"],
      reviews: json["reviews"],
      houses: json["houses"],
      avgRating: json["avgRating"].toDouble(),
      uniqueID: landlordList.length,
    );
  }

  set addReview(Review newRev){
    reviews.add(newRev);
    double total = 0;
    for (var a in reviews) {
      total += a.rating;
    }
    this.avgRating = total/(this.reviews.length);
  }

  List<Weirdlatlng> get latlngAsList{
    List<Weirdlatlng> weirdlatlngs = [];
    for(var i = 0; i < this.houses.length; i++){
      weirdlatlngs.add(Weirdlatlng(houses[i]));
    }
    return weirdlatlngs;
  }

  Map<String,dynamic> toJson() => {
    "name": this.name,
    "reviews": this.reviews,
    "houses": this.latlngAsList,
    "avgRating": this.avgRating,
  };
}



// Class for storing property information locally from JSON
@JsonSerializable()
class House {
  double avgRating = 0.0;
  int bedrooms, bathrooms, houseNum, price;
  double lat, long;
  String postCode, street;
  String landlord = "unknown";
  List<dynamic> reviews = [];
  RoomInfo roominfo;
  House(
      {this.lat,
      this.long,
      this.avgRating,
      this.bedrooms,
      this.houseNum,
      this.street,
      this.postCode,
      this.price,
      this.bathrooms,
      this.landlord,
      this.reviews});

  factory House.fromJson(Map<String, dynamic> json) {
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
    );
  }
  // adds a new review and recalculates review average
  set addReview(Review newRev){
    reviews.add(newRev);
    double total = 0;
    for (var a in reviews) {
      total += a.rating;
    }
    this.avgRating = total/(this.reviews.length);
  }

  //Get for lat and long as LatLng datatype for map compatability and key purposes
  LatLng get latlng {
    return LatLng(this.lat,this.long);
  }

  String get fullAddress {
    String address = (this.houseNum.toString() + " " + this.street);
    return address;
  }
  
  Map<String,dynamic> toJson() => {
    "lat": this.lat,
    "long": this.long,
    "avgRating": this.avgRating,
    "postCode": this.postCode,
    "pricePerAnnum": this.price,
    "houseNumber": this.houseNum,
    "houseStreet": this.street,
    "landlord": this.landlord,
    "reviews": this.reviews,
    "roomInfo": RoomInfo(this.bathrooms,this.bedrooms),
  };

}

// Class defintion for room info, primarily for ease of json parsin
class RoomInfo{
  int numBathrooms;
  int numBedrooms;
  RoomInfo(this.numBathrooms,this.numBedrooms);

  Map<String,dynamic> toJson() => {
    "numBathrooms": this.numBathrooms,
    "numBedrooms": this.numBedrooms,
  };
}

// Class definition for a Review, applicable to both landlords and properties
@JsonSerializable()
class Review {
  double rating;
  String review;

  Review({this.rating, this.review});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(rating: json["rating"].toDouble(), review: json["review"]);
  }

  Map<String,dynamic> toJson() => {
    "rating": this.rating,
    "review": this.review
  };
}
Future fetchAccounts() async {

}
Future addAccount() async {

}
// Retreives a list of houses from database
Future fetchHouses() async {
  //clears previous version of houseList
  houseList = [];
  final response = await http
      .get('https://us-central1-ridr-cc2ec.cloudfunctions.net/getHouses');

  if (response.statusCode == 200) {
    //REturn house from json
    var data = json.decode(response.body);
    for (Map i in data) {
      houseList.add(House.fromJson(i));
    }
    for (House house in houseList) {
      if(house.reviews != null)
        for (var j = 0; j < house.reviews.length; j++) {
        house.reviews[j] = Review.fromJson(house.reviews[j]);
      }
    }
    sortByPriceHL();
  } else {
    throw Exception('Failed to load houses! (Probably the server is down)');
  }
}

// Retreives a list of rentiers from database
Future fetchLandlords() async {
  //Clears previously stored version of landlord list
  landlordList = [];
  final response = await http
      .get('https://us-central1-ridr-cc2ec.cloudfunctions.net/getLandlords');
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    for (Map i in data) {
      landlordList.add(Landlord.fromJson(i));
    }
    // Fixing json encoding stuff within landlord datastructure internal lists, this is NOT good practice but it works
    for (Landlord landlord in landlordList) {
      for (var j = 0; j < landlord.reviews.length; j++) {
        landlord.reviews[j] = Review.fromJson(landlord.reviews[j]);
      }
      for (var k = 0; k < landlord.houses.length; k++) {
        landlord.houses[k] =
            new LatLng(landlord.houses[k]["lat"], landlord.houses[k]["long"]);
      }
    }
  } else {
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

Future<LatLng> getFromAddress(String address) async {
  var query = address + ", Bath";
  var addresses = await Geocoder.local.findAddressesFromQuery(query);
  var first = addresses.first;
  LatLng out =
      new LatLng(first.coordinates.latitude, first.coordinates.longitude);
  return out;
}

//Checks if a house with a given latLng is in database, returns true if already exists, else false
bool houseExists(LatLng latlng) {
  for (House house in houseList) {
    if (house.latlng == latlng) {
      return true;
    }
  }
  return false;
}

// Gets a landlord from list of landlords from name
// Will get first landlord if multiple names found
Landlord getRentierFromName(String name) {
  for (Landlord rentier in landlordList) {
    if (rentier.name == name) {
      return rentier;
    }
  }
  return null;
}

Landlord getRentierFromID(int id){
  for(Landlord rentier in landlordList){
    if(rentier.uniqueID == id){
      return rentier;
    }
  }
  print("you tried to get a landlord from an invalid id!!");
  return null;
}

// Gets a house from latlng, assuming exists. if it doesn't, return null
House getHouseFromLatLng(LatLng latlng) {
  for (House house in houseList) {
    if (house.latlng == latlng) {
      return house;
    }
  }
  print("house wasn't found with that latlng!!");
  return null;

}

void printAllHouses() {
  for (House house in houseList) {
    print(house.fullAddress);
  }
}

// Sorting //

// Sorting functions for built in list display purposes
sortByPriceLH() {
  houseList.sort((a, b) => a.price.compareTo(b.price));
}
sortByPriceHL() {
  houseList.sort((b, a) => a.price.compareTo(b.price));
}
sortByRatingLH(int whichList) {
  if (whichList == 0) {
    houseList.sort((a, b) => a.avgRating.compareTo(b.avgRating));
  }
  else {
    landlordList.sort((a, b) => a.avgRating.compareTo(b.avgRating));
  }
}
sortByRatingHL(int whichList) {
  if (whichList == 0) {
    houseList.sort((b, a) => a.avgRating.compareTo(b.avgRating));
  }
  //Landlord
  else if (whichList == 1) {
    landlordList.sort((b, a) => a.avgRating.compareTo(b.avgRating));
  }
}
sortByBedrooms() {
  houseList.sort((a, b) => a.bedrooms.compareTo(b.bedrooms));
}
sortAlpha() {
  landlordList.sort((a,b) => a.name.compareTo(b.name));
}
sortNumHouse() {
  landlordList.sort((a,b) => a.houses.length.compareTo(b.houses.length));
}

// Sorts housing list based on index, corresponding to a button within ToggleButtons in  list.dart
toggleSort(int index, int whichList) {
  //whichList 0 for prop and 1 for landlord
  if (whichList == 0) {
    if (index == 0) {
      sortByPriceHL();
    } else if (index == 1) {
      sortByPriceLH();
    } else if (index == 2) {
      sortByRatingHL(0);
    } else if (index == 3) {
      sortByRatingLH(0);
    } else if (index == 4) {
      sortByBedrooms();
    }
  }
  else {
    if (index == 0) {
      sortAlpha();
    } else if (index == 1) {
      sortNumHouse();
    } else if (index == 2) {
      sortByRatingHL(1);
    } else if (index == 3) {
      sortByRatingLH(1);
    }
  }
}

void filter() {}


class Weirdlatlng{
  double lat;
  double long;
  Weirdlatlng(LatLng latlng){
    this.lat = latlng.latitude;
    this.long = latlng.longitude;
  }

  Map<String,dynamic> toJson() => {
    "lat": num.parse(this.lat.toStringAsFixed(8)),
    "long": num.parse(this.long.toStringAsFixed(8)),
  };
}
