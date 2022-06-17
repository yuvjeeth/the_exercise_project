import 'dart:async';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:the_exercise_project/global_data.dart';

class OutdoorExerciseScreen extends StatefulWidget {
  const OutdoorExerciseScreen({Key? key}) : super(key: key);

  @override
  State<OutdoorExerciseScreen> createState() => _OutdoorExerciseScreen();
}

class _OutdoorExerciseScreen extends State<OutdoorExerciseScreen> {
  LatLng currentLatLng = LatLng(0.0, 0.0);
  MapController mapController = MapController();
  CarouselController bottomBarController = CarouselController();
  late StreamSubscription<Position> positionStream;

  String chosenSport = "Walking";
  List<String> sportNames = ["Walking", "Running", "Cycling", "Swimming"];
  List<Icon> sportIcons = const [
    Icon(Icons.directions_walk_rounded),
    Icon(Icons.directions_walk_rounded),
    Icon(Icons.pedal_bike_rounded),
    Icon(Icons.water)
  ];

  bool isTracking = false;
  List<LatLng> sportPoints = [];
  List<Marker> routeMarkers = [];

  double distanceCovered = 0;
  String timeElapsedString = "00:00:00";
  StopWatchTimer timeKeeper = StopWatchTimer();

  LocationSettings gpsLocationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
  );

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    timeKeeper = StopWatchTimer(onChange: (value) {
      setState(() {
        timeElapsedString = StopWatchTimer.getDisplayTime(value);
      });
    });
  }

  @override
  void dispose() {
    timeKeeper.dispose();
    positionStream.cancel();
    super.dispose();
  }

  void test() {}

  void chooseSport(String sport) {
    setState(() {
      chosenSport = sport;
    });
  }

  void startSport(String sport) {
    bottomBarController.nextPage(
        duration: Duration(milliseconds: 700), curve: Curves.ease);
    gpsLocationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: sport == "Cycling" ? 25 : 10,
    );
    isTracking = true;
    timeKeeper.onExecute.add(StopWatchExecute.start);
  }

  void resumeSport() {
    isTracking = true;
    timeKeeper.onExecute.add(StopWatchExecute.start);
  }

  void pauseSport() {
    isTracking = false;
    timeKeeper.onExecute.add(StopWatchExecute.stop);
  }

  void finishSport(String sport) {
    bottomBarController.animateToPage(0,
        duration: Duration(milliseconds: 700), curve: Curves.ease);
    timeKeeper.onExecute.add(StopWatchExecute.reset);
  }

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.\nPlease go to settings to grant location permissions.');
    }
    positionStream =
        Geolocator.getPositionStream(locationSettings: gpsLocationSettings)
            .listen((Position? position) {
      if (position != null) {
        setState(() {
          currentLatLng.latitude = position.latitude;
          currentLatLng.longitude = position.longitude;
          if (isTracking) {
            distanceCovered += GeolocatorPlatform.instance.distanceBetween(
                    sportPoints.isEmpty
                        ? currentLatLng.latitude
                        : sportPoints.last.latitude,
                    sportPoints.isEmpty
                        ? currentLatLng.longitude
                        : sportPoints.last.longitude,
                    currentLatLng.latitude,
                    currentLatLng.longitude) /
                1000;
            sportPoints.add(LatLng(position.latitude, position.longitude));
          }
        });
      }
      log(position == null
          ? 'Unknown'
          : 'Auto Update ${position.latitude.toString()}, ${position.longitude.toString()}');
    });
    mapController.moveAndRotate(currentLatLng, 16, 0);
  }

  void makeRouteMarkers() {
    routeMarkers.clear();
    sportPoints.forEach(
      (element) {
        routeMarkers.add(Marker(
          point: element,
          builder: (context) => Container(
            child: Icon(
              Icons.circle,
              size: 5,
              shadows: [
                Shadow(offset: Offset.fromDirection(90, 3), blurRadius: 3)
              ],
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ));
      },
    );
  }

  void pauseWorkoutBottomSheet() {
    showModalBottomSheet<void>(
        isDismissible: false,
        context: context,
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Icon(
                          Icons.pause_circle_rounded,
                          size: 150,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        "$chosenSport Paused",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              resumeSport();
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(5),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.play_arrow_rounded,
                                  size: 30,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                ),
                                Text(
                                  "Resume $chosenSport",
                                  style: TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                finishSport(chosenSport);
                              },
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all<double>(5),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.done_rounded,
                                    size: 30,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                  ),
                                  Text(
                                    "Finish $chosenSport",
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
        });
  }

  Widget bottomBar() {
    return CarouselSlider(
      items: [chooseSportBottomBar(), sportMetricBottomBar()],
      carouselController: bottomBarController,
      options: CarouselOptions(
          height: 200,
          viewportFraction: 1,
          scrollPhysics: NeverScrollableScrollPhysics()),
    );
  }

  Widget chooseSportBottomBar() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: const Text(
                  "Choose an outdoor sport:",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DropdownButton(
                value: chosenSport,
                items: sportNames.map((String items) {
                  int index = sportNames.indexOf(items);
                  return DropdownMenuItem(
                    value: items,
                    child: Row(
                      children: [
                        sportIcons[index],
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                        ),
                        Text(
                          items,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  chooseSport(newValue!);
                },
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () => startSport(chosenSport),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(18.0),
                            bottomRight: Radius.circular(18.0)),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.play_arrow_rounded,
                        size: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                      ),
                      Text(
                        "Start",
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sportMetricBottomBar() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text("Time Elapsed"),
                          Text(
                            timeElapsedString.split(".")[0],
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      child: VerticalDivider(
                        width: 10,
                        thickness: 1,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text("Distance Covered"),
                          Text(
                            distanceCovered.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    pauseSport();
                    pauseWorkoutBottomSheet();
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(18.0),
                            bottomRight: Radius.circular(18.0)),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.pause_rounded,
                        size: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                      ),
                      Text(
                        "Pause",
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomBar(),
      extendBody: true,
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                minZoom: 10.0,
                maxZoom: 18,
                center: currentLatLng,
              ),
              layers: [
                TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c']),
                MarkerLayerOptions(markers: [
                  Marker(
                    point: currentLatLng,
                    builder: (context) => Container(
                      child: Icon(
                        Icons.circle,
                        shadows: [
                          Shadow(
                              offset: Offset.fromDirection(90, 3),
                              blurRadius: 3)
                        ],
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ]
                    //+ routeMarkers,
                    ),
              ],
            ),
          ),
          Align(
            alignment: Alignment(0.9, 0.3),
            child: FloatingActionButton(
              mini: true,
              onPressed: getCurrentLocation,
              child: Icon(Icons.my_location_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
