import 'package:flutter/foundation.dart';

abstract class MovementProvider extends ChangeNotifier {
  List<double> getAcceleration();
  void connect();
  void alternativeConnect();
}