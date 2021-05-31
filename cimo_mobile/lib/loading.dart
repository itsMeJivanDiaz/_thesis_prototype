import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingView extends StatefulWidget {
  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  void say() async {
    print('hello');
  }

  @override
  void initState() {
    super.initState();
    say();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff86e3ce),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage('assets/images/loading.png'),
            height: 270,
            width: 270,
          ),
          SafeArea(
            child: Container(
              color: Color(0xff86e3ce),
              child: Center(
                child: Text(
                  'CIMO',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SpinKitChasingDots(
            color: Colors.white,
            size: 40,
          ),
        ],
      ),
    );
  }
}
