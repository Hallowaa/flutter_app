import 'package:flutter_project/src/providers/movement/MovementProvider.dart';
import 'dart:io';
import 'dart:async';

import 'package:esense_flutter/esense.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ESenseMovementProvider extends MovementProvider {
  static const int fractionalDigits = 2;
  static const String _eSenseDeviceName = 'eSense-0390';

  List<double> _eSenseAcc = [0, 0, 0];
  List<double> _eSenseAccOffset = [0, 0, 0];

  List<double> _deviceAcc = [0, 0, 0];

  List<double> _deviceSpeed = [0, 0, 0];
  final double _damping = 0.7;

  ESenseManager eSenseManager = ESenseManager(_eSenseDeviceName);
  Duration sensorInterval = SensorInterval.normalInterval;
  bool _sampling = false;
  bool _connected = false;

  List<double> get speed => _deviceSpeed;

  ESenseMovementProvider();

  @override
  void connect() async{
    if (_connected) {
      return;
    }

    _listenToESense();

    await _connectToESense();

    _startListenToGyroSensorEvents();
  }

  @override
  void alternativeConnect() async {
    userAccelerometerEventStream(samplingPeriod: sensorInterval)
        .listen((UserAccelerometerEvent event) {
      _deviceAcc = [event.x, event.y, event.z];
      _deviceSpeed = [
        (_deviceSpeed[0] + _deviceAcc[0]) * _damping,
        (_deviceSpeed[1] + _deviceAcc[1]) * _damping,
        (_deviceSpeed[2] + _deviceAcc[2]) * _damping
      ];
      notifyListeners();
    });
  }

  @override
  List<double> getAcceleration() {
    return _sampling ? _eSenseAcc : _deviceAcc;
  }

  @override
  List<double> getAccelOffset() {
    return _eSenseAccOffset;
  }

  Future<void> _askForPermissions() async {
    if (!(await Permission.bluetoothScan.request().isGranted &&
        await Permission.bluetoothConnect.request().isGranted)) {
      print(
          'WARNING - no permission to use Bluetooth granted. Cannot access eSense device.');
    }
    // for some strange reason, Android requires permission to location for Bluetooth to work.....?
    if (Platform.isAndroid) {
      if (!(await Permission.locationWhenInUse.request().isGranted)) {
        print(
            'WARNING - no permission to access location granted. Cannot access eSense device.');
      }
    }
  }

  void _listenToESenseEvents() async {
    eSenseManager.eSenseEvents.listen((event) {
      print('ESENSE event: $event');
    });

    _getESenseProperties();
  }

  void _getESenseProperties() async {
    await eSenseManager.getAccelerometerOffset();
    Timer(const Duration(seconds: 2),
        () async => await eSenseManager.getSensorConfig());
  }

  Future<void> _listenToESense() async {
  await _askForPermissions();

  eSenseManager.connectionEvents.listen((event) {
    if (event.type == ConnectionType.connected) {
      _listenToESenseEvents();
    }});
  }

  Future<void> _calibrateAccelOffset() async {
    _eSenseAccOffset = _eSenseAcc;
  }

  StreamSubscription? subscription;
  void _startListenToGyroSensorEvents() async {
    await eSenseManager.setSamplingRate(10);

    // subscribe to sensor event from the eSense device
    subscription = eSenseManager.sensorEvents.listen((event) {
      if (event.accel != null) {
        _eSenseAcc = [event.accel![0], event.accel![1], event.accel![2]]
            .map((e) =>
        (e / 8192) *
            9.80665) // value divided by accel scale factor * g
            .toList();
      }
    });

    _sampling = true;
  }

  Future<void> _connectToESense() async {
    if (!_connected) {
      _connected = await eSenseManager.connect();
    }
  }

  Future<void> _disconnectFromESense() async {
    if (_connected) {
      _connected = await eSenseManager.disconnect();
    }
  }
}