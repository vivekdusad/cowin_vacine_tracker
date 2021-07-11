import 'package:cowin_vaccine_tracker/models/pincode.dart';
import 'package:cowin_vaccine_tracker/ui/widgets/CustomModalSheet.dart';

import 'package:cowin_vaccine_tracker/web/server.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

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

  List<Centers> cases;
  Set<Marker>_markers= {};

  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (cases == null) {
      return;
    }

    setState(() {
      cases.forEach((element) {
        //final district = element.districtName;
        print(element.lat);
        print(element.long);
        final title = '${element.centerId}';
        final marker = Marker(
          markerId: MarkerId(title),
          position: LatLng(element.lat, element.long),
          onTap: (){
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("${element.stateName != null ? element.stateName : 'N/A'}-${element.pincode}",
                        style:GoogleFonts.roboto())
                    ],
                  );
                });
          }
          // infoWindow: InfoWindow(
          //   title:
          //       "${element.stateName != null ? element.stateName : 'N/A'}-${element.pincode}",
            // snippet: "C: $district",
          // ),
        );
        _markers.add(marker);
      });
    });
  }
  Position position;
  @override
  void initState(){
    //_fetchData();
    super.initState();
  }

  Future<List<Centers>> _fetchData() {
    return ServerBase().getbylatlong(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
        future: getLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.error != null) {
            return Center(
              child: Text('An error has occured'),
            );
          } else {
            // Position position = Geolocator
            //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
            position=snapshot.data;
            return FutureBuilder(
              future: _fetchData(),
              builder:(context,snapshot)
              {
                if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.error != null) {
                  return Center(
                    child: Text('An error has occured'),
                  );
                }
                else{
                  this.cases=snapshot.data;

                return GoogleMap(
                  myLocationEnabled: true,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(position.latitude,position.longitude),
                  zoom: 15,
                ),
                markers: _markers,
              );
              }
              }
            );
          }
        });
  }
}
Future<Position> getLocation() async { Position position = await Geolocator .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
print(position);
return position; }