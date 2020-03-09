import 'package:http/http.dart' as http;

// Classes, getters, builders, etc. for accessing json go here for the time being //

//TODO modify basic house class and factory as per criteria established in deliverable 2 

//This is a basic house classfor display purposes, generally to be substantiated by json
class HouseBasic{
  int id;
  int lat;
  int long;
  int bedrooms;
  int houseNum;
  String street;

  HouseBasic({this.lat,this.long,this.bedrooms,this.houseNum,this.street});

}

Future<HouseBasic> fetchHouseBasic() async {
  final response = await http.get('https://us-central1-ridr-cc2ec.cloudfunctions.net/getHouses');

  if(response.statusCode == 200){
    //REturn house from json
  } else {
    throw Exception('Failed to load houses!');
  }
}