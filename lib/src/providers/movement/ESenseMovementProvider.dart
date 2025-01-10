import 'dart:math';

import 'dart:io';
import 'dart:async';

import 'package:esense_flutter/esense.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ESenseMovementProvider extends ChangeNotifier{
  static const int fractionalDigits = 2;
  static const String _eSenseDeviceName = 'eSense-0390';

  List<double> _eSenseAcc = [0, 0, 0];
  List<double> _eSenseAccOffset = [0, 0, 0];
  List<double> _eSenseSpeed = [0, 0, 0];
  double _eSenseSpeedMagnitude = 0;
  final double _eSenseDamping = 0.5;

  List<double> _deviceAcc = [0, 0, 0];
  List<double> _deviceSpeed = [0, 0, 0];
  double _deviceSpeedMagnitude = 0;
  final double _deviceDamping = 0.85;

  ESenseManager eSenseManager = ESenseManager(_eSenseDeviceName);
  Duration sensorInterval = SensorInterval.normalInterval;
  bool _connected = false;

  bool _useDeviceSensors = true;
  bool _useEsenseSensors = false;

  bool get useDeviceSensors => _useDeviceSensors;
  bool get useEsenseSensors => _useEsenseSensors;
  StreamSubscription? _deviceSubscription;
  int _ticks = 50;

  double get speedMagnitude => _useDeviceSensors ? _deviceSpeedMagnitude : _eSenseSpeedMagnitude;

  set useDeviceSensors(bool value) {
    _useDeviceSensors = value;

    if (value == true) {
      alternativeConnect();
      _useEsenseSensors = false;
    } else {
      _deviceSubscription?.cancel();
    }
    notifyListeners();
  }

  set useEsenseSensors(bool value) {
    _useEsenseSensors = value;

    if (value == true) {
      connect();
      _useDeviceSensors = false;
    } else {
      _disconnectFromESense();
    }
    notifyListeners();
  }

  ESenseMovementProvider() {
    alternativeConnect();
  }

  void connect() async {
    if (_connected) {
      return;
    }

    await _askForPermissions();

    _listenToESense();

    await _connectToESense();
  }

  Future<void> _listenToESense() async {
    eSenseManager.connectionEvents.listen((event) {
        _connected = false;
        switch (event.type) {
          case ConnectionType.connected:
            _connected = true;
            _startListenToGyroSensorEvents();
            break;
          case ConnectionType.disconnected:
            _disconnectFromESense();
            useDeviceSensors = true;
            break;
          default:
            break;
        }
    });
  }

  void alternativeConnect() async {
    _deviceSubscription?.cancel();
    _deviceSubscription =
        userAccelerometerEventStream(samplingPeriod: sensorInterval)
            .listen((UserAccelerometerEvent event) {
      _deviceAcc = [event.x, event.y, event.z];
      _deviceSpeed = [
        (_deviceSpeed[0] + _deviceAcc[0]) * _deviceDamping,
        (_deviceSpeed[1] + _deviceAcc[1]) * _deviceDamping,
        (_deviceSpeed[2] + _deviceAcc[2]) * _deviceDamping
      ];
      _deviceSpeedMagnitude = sqrt(pow(_deviceSpeed[0], 2) +
          pow(_deviceSpeed[1], 2) +
          pow(_deviceSpeed[2], 2));
      notifyListeners();
    });
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

  Future<void> _calibrateAccelOffset() async {
    _eSenseAccOffset = _eSenseAcc;
  }

  StreamSubscription? subscription;
  void _startListenToGyroSensorEvents() async {
    subscription?.cancel();
    subscription = eSenseManager.sensorEvents.listen((event) {
      _ticks++;
      if (event.accel != null) {
        _eSenseAcc = [event.accel![0], event.accel![1], event.accel![2]]
            .map((e) => (e / 8192) * 9.80665).toList();

        if (_ticks >= 50) {
          _calibrateAccelOffset();
          _ticks = 0;
        }

        _eSenseSpeed = [
          (_eSenseSpeed[0] + _eSenseAcc[0] - _eSenseAccOffset[0]) * _eSenseDamping,
          (_eSenseSpeed[1] + _eSenseAcc[1] - _eSenseAccOffset[1]) * _eSenseDamping,
          (_eSenseSpeed[2] + _eSenseAcc[2] - _eSenseAccOffset[2]) * _eSenseDamping
        ];
        _eSenseSpeedMagnitude = sqrt(pow(_eSenseSpeed[0], 2) +
            pow(_eSenseSpeed[1], 2) +
            pow(_eSenseSpeed[2], 2));
        notifyListeners();
      }
      _calibrateAccelOffset();
    });
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
