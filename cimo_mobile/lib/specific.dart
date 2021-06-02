import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class EstablishmentInfo extends StatefulWidget {
  String name;
  String lat;
  String long;
  String city;
  String branch;
  String area;
  int allowed;
  int available;
  int current;
  EstablishmentInfo({
    required this.name,
    required this.lat,
    required this.long,
    required this.city,
    required this.branch,
    required this.area,
    required this.allowed,
    required this.available,
    required this.current,
  });
  @override
  _EstablishmentInfoState createState() => _EstablishmentInfoState();
}

class _EstablishmentInfoState extends State<EstablishmentInfo> {
  Set<Marker> _markers = HashSet<Marker>();
  late GoogleMapController _mapController;
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

  @override
  Widget build(BuildContext context) {
    int available_count = widget.current - widget.allowed;
    print(available_count);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff86e3ce),
        elevation: 4,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Row(
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 400,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  double.parse(widget.lat),
                  double.parse(widget.long),
                ),
                zoom: 15,
              ),
              markers: _markers,
              zoomControlsEnabled: false,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          color: Color(0xff86e3ce),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Icon(
                          Icons.location_pin,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '@ ' +
                            widget.city +
                            ', ' +
                            widget.branch +
                            ', ' +
                            widget.area +
                            ' area',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          color: Color(0xff86e3ce),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Icon(
                          Icons.group,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Allowed : ' + '${widget.allowed}' + ' person',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          color: Color(0xff86e3ce),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Icon(
                          Icons.directions_run_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Available : ' + '${widget.allowed}' + ' person',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          color: Color(0xff86e3ce),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Icon(
                          Icons.family_restroom_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Current : ' + '${widget.current}' + ' person',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
