import 'package:flutter/material.dart';

import 'google_map_stub.dart';

// ignore: uri_does_not_exist

abstract class BaseGoogleMap {
  StatefulWidget getWidget();

  factory BaseGoogleMap() => getGoogleMap();
}
