import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'functionsAndData.dart';


// This file contains things for adding and modifying the database //

//add a new review to a house, should always be used in a context where house is guaranteed to exist or will break things 
void addNewHouseReview(LatLng latlng, String reviewText, double rating) {
  Review review = new Review(rating: rating, review: reviewText);
  House house = getHouseFromLatLng(latlng);
  house.addReview = review;
  String json = jsonEncode(house);
  print(json);
  http.get("https://us-central1-ridr-cc2ec.cloudfunctions.net/updateHouse?text=" + json);
}

void addNewLandlordReview(int id, String reviewText, double rating){
  Review review = new Review(rating: rating, review: reviewText);
  Landlord landlord = getRentierFromID(id);
  landlord.addReview = review;
  String json = jsonEncode(landlord);
  print(json);
  //http.get("https://us-central1-ridr-cc2ec.cloudfunctions.net/updateLandlord?text=" + json);
}

void propertyToDatabase(House house){
  //If house already exists, either abort or direct them towards review creation page
  if(houseExists(house.latlng)){
    print("This house already exists!");
  }
  else{
    houseList.add(house);
    String json = jsonEncode(house);
    print(json);
    http.get("https://us-central1-ridr-cc2ec.cloudfunctions.net/addHouse?text=" + json);
  }
}

void landlordToDatabase(Landlord landlord){
  //If house already exists, either abort or direct them towards review creation page
    landlordList.add(landlord);
    String json = jsonEncode(landlord);

    http.get("https://us-central1-ridr-cc2ec.cloudfunctions.net/addLandlord?text=" + json);
}
