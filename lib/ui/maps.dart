import 'package:cowin_vaccine_tracker/models/pincode.dart';

import 'package:cowin_vaccine_tracker/web/server.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'basegooglemap.dart';

class MapsPage implements BaseGoogleMap {
  MapsPage();

  StatefulWidget getWidget() {
    return MobileMapsPage();
  }
}

BaseGoogleMap getGoogleMap() => MapsPage();

class MobileMapsPage extends StatefulWidget {
  MobileMapsPage({Key key}) : super(key: key);

  @override
  _MapsPage createState() => _MapsPage();
}

class _MapsPage extends State<MobileMapsPage>
    with AutomaticKeepAliveClientMixin<MobileMapsPage> {
  @override
  bool get wantKeepAlive => true;

  Future<List<Centers>> _allCasesFuture;
  List<Centers> cases;
  final Map<String, Marker> _markers = {};

  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (cases == null) {
      return;
    }

    setState(() {
      _markers.clear();
      cases.forEach((element) {
        
        final district = element.districtName;
        final title = '${element.centerId}';
        final marker = Marker(
          markerId: MarkerId(title),
          position: LatLng(element.lat, element.long),
          infoWindow: InfoWindow(
            title:
                "${element.stateName != null ? element.stateName : 'N/A'}-${element.pincode}",
            snippet: "C: $district",
          ),
        );
        _markers[title] = marker;
      });
    });
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  _fetchData() {
    _allCasesFuture =
        ServerBase().getSessionByDistrict("512", DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
        future: _allCasesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.error != null) {
            return Center(
              child: Text('An error has occured'),
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
}
