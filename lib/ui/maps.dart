import 'package:cowin_vaccine_tracker/main.dart';
import 'package:cowin_vaccine_tracker/state_managers/bloc/pincode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  MapsPage({Key key}) : super(key: key);
  

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage>
    with AutomaticKeepAliveClientMixin {
  GoogleMapController mapController;
  final Set<Marker> _markers = {};
  final LatLng center = const LatLng(45.521563, -122.677433);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        var pincodebloc = PincodeBloc(server: watch(serverprovider));
        pincodebloc.add(SessionRequestedByPin("302015", DateTime.now()));
        return BlocProvider(
            create: (context) => pincodebloc,
            child: BlocBuilder<PincodeBloc, PincodeState>(
              builder: (context, state) {
                if (state is SessionLoading) {
                  return CircularProgressIndicator();
                }
                if (state is SessionResultByPinCode) {
                  
                  void _onMapCreated(GoogleMapController controller) {
                    mapController = controller;
                    print("length" + (state.centers[0].long.toString()));
                  
                  state.centers.forEach((element) {
                    Marker(
                        markerId: MarkerId(element.name),
                        position: LatLng(element.lat, element.long));
                  });
                  }

                  return GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: center,
                      zoom: 5,
                    ),
                    mapType: MapType.normal,
                    markers: _markers,
                  );
                }
                if (state is SessionErrorOccured) {}

                return Container();
              },
            ));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
