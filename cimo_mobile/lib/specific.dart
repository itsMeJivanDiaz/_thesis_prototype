import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cimo_mobile/specific_json.dart';

// ignore: must_be_immutable
class EstablishmentInfo extends StatefulWidget {
  String id;
  String name;
  String lat;
  String long;
  String city;
  String branch;
  String barangay;
  int limit;
  int current;
  EstablishmentInfo({
    required this.id,
    required this.name,
    required this.lat,
    required this.long,
    required this.city,
    required this.branch,
    required this.barangay,
    required this.limit,
    required this.current,
  });
  @override
  _EstablishmentInfoState createState() => _EstablishmentInfoState();
}

class _EstablishmentInfoState extends State<EstablishmentInfo> {
  Set<Marker> _markers = HashSet<Marker>();
  // ignore: unused_field
  late GoogleMapController _mapController;
  bool isLoad = false;

  void updateData(String id) async {
    SpecificEstablishment spec_instance = SpecificEstablishment(ref_id: id);
    await spec_instance.getSpec();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoad = true;
        widget.limit = spec_instance.data[0]['limited-capacity'];
        widget.current = spec_instance.data[0]['current-crowd'];
      });
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("0"),
          position: LatLng(
            double.parse(widget.lat),
            double.parse(widget.long),
          ),
        ),
      );
    });
  }

  void setIsLoad() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoad = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setIsLoad();
  }

  @override
  Widget build(BuildContext context) {
    return isLoad == false ? buildLoader() : buildDisplay();
  }

  Widget buildLoader() {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: SpinKitRing(
            color: Color(0xff86e3ce),
            size: 45,
            lineWidth: 7,
          ),
        ),
      ),
    );
  }

  Widget buildDisplay() {
    int available = widget.limit - widget.current;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff86e3ce),
        elevation: 4,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.store,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              widget.name,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height / 2,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  double.parse(widget.lat),
                  double.parse(widget.long),
                ),
                zoom: 18,
              ),
              markers: _markers,
              zoomControlsEnabled: false,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Color(0xff86e3ce),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 1,
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.location_pin,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          '@ ' +
                              widget.city +
                              ', ' +
                              widget.branch +
                              ', ' +
                              widget.barangay +
                              ' Area',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            color: Color(0xff808080),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Color(0xff86e3ce),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 1,
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.group,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Allowed Entries : ' + '${widget.limit}',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            color: Color(0xff808080),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Color(0xff86e3ce),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 1,
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.directions_run_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Available Entries : ' + '${available}',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            color: Color(0xff808080),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Color(0xff86e3ce),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 1,
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.family_restroom_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Current Entries : ' + '${widget.current}',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            color: Color(0xff808080),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          updateData(widget.id);
          setState(() {
            isLoad = false;
          });
        },
        backgroundColor: Color(0xfff79469),
        elevation: 2,
        child: Icon(
          Icons.refresh_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
