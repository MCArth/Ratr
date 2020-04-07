import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'functionsAndData.dart';


// This file contains things for adding and modifying the database //

//add a new review to a house, should always be used in a context where house is guaranteed to exist or will break things 
void addNewReview(LatLng latlng, String reviewText, double rating) {
  Review review = new Review(rating: rating, review: reviewText);
  House house = getHouseFromLatLng(latlng);
  print(house.avgRating);
  house.addReview = review;
  print(house.avgRating);
  String json = jsonEncode(house);
  print(json);
}

void propertyToDatabase(House house){
  //If house already exists, either abort or direct them towards review creation page
  if(houseExists(house.latlng)){
    print("This house already exists!");
  }
  else{
    houseList.add(house);
    //json stuff goes here (dependant on getting houses to serialise)
  }
}