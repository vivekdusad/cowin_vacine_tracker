import 'package:cowin_vaccine_tracker/models/CoronaCaseCountry.dart';
import 'package:cowin_vaccine_tracker/web/server.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  MapsPage({Key key}) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage>
    with AutomaticKeepAliveClientMixin {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final Map<String, Marker> _markers = {};

  List<CoronaCaseCountry> cases;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ServerBase().fetchCases(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.error != null) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            this.cases = snapshot.data;

            return GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: const LatLng(30.5833, 114.26667),
                zoom: 5,
              ),
              markers: _markers.values.toSet(),
            );
          }
        });
  }

  @override
  bool get wantKeepAlive => true;
}
