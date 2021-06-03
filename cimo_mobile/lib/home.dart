import 'package:cimo_mobile/specific.dart';
import 'package:cimo_mobile/specific_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:cimo_mobile/jsonData.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  List data = [];
  HomeView({required this.data});
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List colors = [
    Color(0xfff79469),
    Color(0xff91e8bc),
    Color(0xff9cf5b1),
    Color(0xfff79469),
    Color(0xffcdd9fb),
    Color(0xfff79469),
    Color(0xfff79469),
    Color(0xffcdd9fb),
    Color(0xffcdd9fb),
    Color(0xfff79469),
    Color(0xff91e8bc),
    Color(0xff9cf5b1),
    Color(0xfff79469),
    Color(0xffcdd9fb),
    Color(0xfff79469),
    Color(0xfff79469),
    Color(0xffcdd9fb),
    Color(0xffcdd9fb),
  ];
  Random rand = new Random();

  int coloridx = 0;

  changeidx() {
    coloridx = rand.nextInt(8);
    return coloridx;
  }

  getfirstletter(String string) {
    String mystring = string;
    return '${mystring[0]}';
  }

  Future<void> _refresh() async {
    All_Establishment est_instance = All_Establishment();
    await est_instance.getData();
    setState(() {
      widget.data = est_instance.data;
    });
  }

  void getSpecific(String id) async {
    SpecificEstablishment spec_instance = SpecificEstablishment(ref_id: id);
    await spec_instance.getSpec();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EstablishmentInfo(
          id: id,
          name: spec_instance.data[0]['establishment-name'],
          lat: spec_instance.data[0]['latitude'],
          long: spec_instance.data[0]['longitude'],
          city: spec_instance.data[0]['city'],
          branch: spec_instance.data[0]['branch-street'],
          barangay: spec_instance.data[0]['barangay-area'],
          limit: spec_instance.data[0]['limited-capacity'],
          current: spec_instance.data[0]['current-crowd'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xff86e3ce),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xff86e3ce),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.store,
                color: Color(0xff86e3ce),
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Discover Establishments',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  color: Color(0xff616161),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
              child: Container(
                height: MediaQuery.of(context).size.height - 100,
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: widget.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                        child: Material(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          child: InkWell(
                            splashColor: colors[changeidx()],
                            onTap: () {
                              getSpecific(
                                widget.data[index]['establishment-ID'],
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                              height: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: colors[changeidx()],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        getfirstletter(
                                          widget.data[index]
                                                  ['establishment-name']
                                              .toString(),
                                        ),
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.data[index]
                                            ['establishment-name'],
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '@ ' +
                                            widget.data[index]
                                                ['branch-street'] +
                                            ', ' +
                                            widget.data[index]['city'],
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        widget.data[index]['barangay-area'] +
                                            ' Area',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
