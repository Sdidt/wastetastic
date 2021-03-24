import 'package:flutter/cupertino.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:flutter/material.dart';
import 'package:wastetastic/screens/CarParkScreen.dart';
import 'package:wastetastic/screens/FavouritesScreen.dart';
import 'package:wastetastic/screens/CatalogScreen.dart';
import 'package:wastetastic/screens/NearYouScreen.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';

class POI_DetialScreen extends StatefulWidget {
  static bool favChanged = false;
  static const String id = 'POI_detail_screen';
  @override
  _POI_DetialScreenState createState() => _POI_DetialScreenState();
}

class _POI_DetialScreenState extends State<POI_DetialScreen> {
  @override
  void initState() {
    POI_DetialScreen.favChanged = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final WastePOI POI = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.square(70),  //fromHeight(80.0),
          child:AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Colors.green.shade700,
                      Colors.teal.shade700,
                    ])
            ),
          ),
          title: Column(
            children:[
              SizedBox(height: 14),
              Row(
                children: [
                  SizedBox(width: 60),
                  Text('Wastetastic',
                      style: TextStyle(
                          fontSize: 30.0, fontFamily: "DancingScript")),
                ],
              ),
            ],
          ),
          centerTitle: true,
        ),
        ),
        body: Stack(
          children: [
            Container(
              child: Column(children: [
                header_card(
                  title: 'POI Info',
                ),
                Container(
                  child: Text('More details of the waste vendor:',
                      style: TextStyle(
                          fontSize: 23.0, fontFamily: 'DancingScript')),),
                SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Name:      \t',
                              style: TextStyle(
                                letterSpacing: 1,
                                height: 1.2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                POI.POI_name,

                                style: TextStyle(
                                  letterSpacing: 1,
                                  height: 1.2,
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Category: \t',
                              style: TextStyle(
                                letterSpacing: 1,
                                height: 1.2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                POI.wasteCategory
                                    .toString()
                                    .split('.')
                                    .last
                                    .replaceAll('_', ' '),
                                style: TextStyle(
                                  letterSpacing: 1,
                                  height: 1.2,
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'About:      \t',
                              style: TextStyle(
                                letterSpacing: 1,
                                height: 1.2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                POI.POI_description.trim(),
                                style: TextStyle(
                                  letterSpacing: 1,
                                  height: 1.2,
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Address:  \t',
                              style: TextStyle(
                                letterSpacing: 1,
                                height: 1.2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                POI.address.trim() +
                                    '. Singapore ' +
                                    POI.POI_postalcode.toString(),
                                style: TextStyle(
                                  letterSpacing: 1,
                                  height: 1.2,
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  child:
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          UserAccountMgr.editFav(POI);
                          POI_DetialScreen.favChanged =
                              !POI_DetialScreen.favChanged;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        primary: Colors.lime,

                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      label: Text('Favourite',
                          style: TextStyle(
                        fontSize: 20,
                        color: Colors.teal.shade900,
                        fontWeight: FontWeight.bold,)),
                      icon: Icon(
                        Icons.star,
                        color: UserAccountMgr.isFav(POI)
                            ? Colors.yellow
                            : Colors.white,
                      ),
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(18.0),
                      ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  child:
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          CarParkScreen.id,
                          arguments: POI,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        primary: Colors.lime,

                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      label: Text('NearBy CarPark', style: TextStyle(
                        fontSize: 20,
                        color: Colors.teal.shade900,
                        fontWeight: FontWeight.bold,)),
                      icon: Icon(Icons.directions_car_rounded),
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(18.0),
                      ),


                  ),
                SizedBox(
                  height: 50,
                ),
                ],

            )
          ],
        ),
      ),
    );
  }
}
