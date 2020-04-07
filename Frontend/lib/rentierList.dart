import 'package:flutter/material.dart';
import 'package:nexus_app/landlord.dart';
import 'functionsAndData.dart';
import 'package:nexus_app/app.dart';

//page displaying all available properties in a relational database
//required to display only a small amount of information that nevertheless expresses the general sense for a property at a glance
//Maybe use tiles to display an image + price per month + an address

class RentierListPage extends StatefulWidget {
  @override
  _RentierListState createState() => _RentierListState();
}

class _RentierListState extends State<RentierListPage>{

  List<String> landList = ['Alphabetical','Number of Houses','Rating Highest','Rating Lowest'];
  String _land;

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: new AppBar(
        title: Text("Landlord List")),
        body: Column(
          children: <Widget>[
            SizedBox(height: 5,),
            Container(
              width: MediaQuery.of(context).size.width*0.92,
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                  isExpanded: true,
                  hint: Text('Sort landlords by....', textAlign: TextAlign.center,
                    style: TextStyle(color: themeYellow),),
                  value: _land,
                  items: landList.map((sortBy) {
                    return DropdownMenuItem(
                      child: new Text(sortBy),
                      value: sortBy,
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    int index = landList.indexOf(newValue);
                    toggleSort(index,1);
                    setState(() {
                      _land = newValue;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 5),
            Expanded(child: getRentierListViewBody(context))
          ],
        )
        );
  }
}

//Generates an instance of a card for a house
makeLandlordCard(BuildContext context, int index){
  int num = landlordList[index].houses.length;
  print(index);
  return Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(
      horizontal: 10.0,
      vertical: 6.0,
    ),
    child: Container(
      decoration: BoxDecoration(
        color: themeGrey,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(width: 1.0, color: themeYellow))),
                  child: Icon(Icons.person, color: Colors.white,size: 40.0),
                ),
                title: Text(
                  (landlordList[index].name),
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),

                subtitle: Row(
                  children: <Widget>[
                    getText(num)
                  ],
                ),
                trailing:
                    Icon(Icons.keyboard_arrow_right, color: themeYellow, size: 50.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LandlordProfile(landlordList[index].uniqueID)),
                  );
                        }
        ),
      ),
  );
}

//Function that gets all houses from database, creates card for each one
Widget getRentierListViewBody(BuildContext context){
  return Column(children: <Widget>[
    SizedBox(height: 10),
    Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: landlordList.length,
        itemBuilder: (BuildContext context, int index){
          return makeLandlordCard(context,index);
        },
      )
  ),
  ]
  );
}

Text getText(int num) {
  if (num == 1) {
    return Text("Has " + num.toString() + " known property");
  }
  else {
    return Text("Has " + num.toString() + " known properties");
  }
}