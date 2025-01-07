import 'package:flutter/foundation.dart';

abstract class MovementProvider extends ChangeNotifier {
  void connect();
  void alternativeConnect();
}