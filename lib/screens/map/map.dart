import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:value_client/core/config/index.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/widgets/index.dart';
// ignore: library_prefixes
import "package:google_maps_webservice/geocoding.dart" as GoogleMapsWebservice;

class MapScreen extends StatefulWidget {
  final Map<String, dynamic> address;

  const MapScreen({Key? key, required this.address}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> mapController = Completer();

  final Set<Marker> _markers = <Marker>{};
  late BitmapDescriptor customIcon;

  final Location location = Location();
  bool _serviceEnabled = false;
  late PermissionStatus _permissionGranted;
  bool _loading = true;
  final Map<String, dynamic>? _address = {"text": "", "lat": "", "lng": ""};
  late LocationData _currentPosition;
  LatLng _initialcameraposition =
      const LatLng(21.42385875366792, 39.82566893781161);
  CameraPosition? currentLocation;
  bool _error = false;
  String? _errorText;

  @override
  initState() {
    _setCustomIcon();
    super.initState();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.your_place),
          ),
          body: NetworkSensitive(
            child: _loading || _error
                ? Center(
                    child: _loading
                        ? const AppLoading()
                        : Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _errorText!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                  ),
                                ),
                                const SizedBox(height: 50),
                                AppButton(
                                  title: AppLocalizations.of(context)!
                                      .open_location_settings,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    AppSettings.openAppSettings();
                                  },
                                ),
                              ],
                            ),
                          ),
                  )
                : Stack(
                    children: [
                      GoogleMap(
                        // myLocationEnabled: true,
                        zoomControlsEnabled: false,
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: _initialcameraposition,
                          zoom: 15,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          mapController.complete(controller);
                        },
                        onTap: (latLng) {
                          getAddressFromLatLon(latLng);
                        },
                        onLongPress: (latLng) {
                          getAddressFromLatLon(latLng);
                        },
                        markers: _markers,
                      ),
                      Positioned(
                        bottom: 15,
                        right: 15,
                        left: 15,
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // color: AppColors.primaryL,
                            gradient: const LinearGradient(
                              // begin: Alignment.topRight,
                              // end: Alignment.bottomLeft,
                              // stops: [0.1, 0.5, 0.7, 0.9],
                              colors: [
                                Color(0xFF210753),
                                Color(0xFF3C398F),
                                Color(0xFF6A31D8),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              left: 15,
                              right: 15,
                              bottom: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  // color: AppColors.red,
                                  // alignment: Alignment.center,
                                  // width: 250,
                                  child: Text(
                                    _address!["text"],
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style:
                                        const TextStyle(color: AppColors.white),
                                  ),
                                ),
                                Transform.rotate(
                                  //<--- This changed
                                  angle: cubit.isRTL(context)
                                      ? 0
                                      : 180 * 3.14 / 180,
                                  child: const Icon(
                                    AppIcons.pin_with_large_head_variant,
                                    color: AppColors.white,
                                    size: 26,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 90,
                        right: 20,
                        // left: 15,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.check, size: 30),
                            color: AppColors.secondaryL,
                            onPressed: () {
                              Navigator.pop(context, _address);
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 90,
                        left: 20,
                        // left: 15,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.search, size: 25),
                            color: AppColors.gray,
                            onPressed: () async {
                              final result = await Navigator.of(context)
                                  .pushNamed(AppRoutes.mapSearchScreen);
                              setLocations(
                                  result
                                      as GoogleMapsWebservice.GeocodingResult,
                                  true);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Future<void> _setCustomIcon() async {
    await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(50, 50)),
            'assets/images/marker2.png')
        .then((icon) {
      debugPrint('finish icon ===== ');
      customIcon = icon;
    });
  }

  Future<void> _getLocation() async {
    await Future.delayed(const Duration(milliseconds: 750));
    debugPrint(widget.address.toString());
    debugPrint('================ --- =====  ---  ');
    if (widget.address['text'] != '') {
      final _latLng = LatLng(widget.address['lat'], widget.address['lng']);
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId(widget.address['text'].toString()),
          position: _latLng,
          icon: customIcon,
        ),
      );
      setState(() {
        _initialcameraposition = _latLng;
        _loading = false;
        _address!["text"] = widget.address['text'];
        _address!["lat"] = widget.address['lat'];
        _address!["lng"] = widget.address['lng'];
      });
    } else {
      try {
        _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          if (!_serviceEnabled) {
            Navigator.of(context).pop();
            return;
          }
        }

        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted == PermissionStatus.deniedForever) {
            Navigator.of(context).pop();
            AppSettings.openAppSettings();
          } else if (_permissionGranted != PermissionStatus.granted) {
            Navigator.of(context).pop();
            return;
          }
        }

        _currentPosition = await location.getLocation();
        _initialcameraposition =
            LatLng(_currentPosition.latitude!, _currentPosition.longitude!);
        final _latLng =
            LatLng(_currentPosition.latitude!, _currentPosition.longitude!);
        setState(() {
          _initialcameraposition = _latLng;
          _loading = false;
        });
        await getAddressFromLatLon(_latLng);
      } on PlatformException catch (err) {
        debugPrint('ERR: $err}', wrapWidth: 1024);
        setState(() {
          _errorText = err.toString();
          _error = true;
          _loading = false;
        });
      }
    }
  }

  Future<void> getAddressFromLatLon(LatLng _latLng) async {
    final geocoding = GoogleMapsWebservice.GoogleMapsGeocoding(
        apiKey: AppConfiguration.API_KEY);
    GoogleMapsWebservice.GeocodingResponse response =
        await geocoding.searchByLocation(
      GoogleMapsWebservice.Location(
          lat: _latLng.latitude, lng: _latLng.longitude),
      language: Localizations.localeOf(context).languageCode,
    );
    if (response.status == 'OK') {
      setLocations(response.results[0], false);
    }
  }

  Future<void> setLocations(
    GoogleMapsWebservice.GeocodingResult address,
    bool search,
  ) async {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId(address.toString()),
        position: LatLng(
          address.geometry.location.lat,
          address.geometry.location.lng,
        ),
        icon: customIcon,
      ),
    );
    if (search) {
      final CameraPosition loc = CameraPosition(
        target: LatLng(
          address.geometry.location.lat,
          address.geometry.location.lng,
        ),
        zoom: 15,
      );
      _goToMyCurrentLocation(loc);
      setState(() {
        _initialcameraposition = LatLng(
          address.geometry.location.lat,
          address.geometry.location.lng,
        );
        _loading = false;
        _address!["text"] = address.formattedAddress!;
        _address!["lat"] = address.geometry.location.lat;
        _address!["lng"] = address.geometry.location.lng;
      });
    } else {
      setState(() {
        _address!["text"] = address.formattedAddress!;
        _address!["lat"] = address.geometry.location.lat;
        _address!["lng"] = address.geometry.location.lng;
      });
    }
  }

  Future<void> _goToMyCurrentLocation(mylocation) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(mylocation));
  }
}
