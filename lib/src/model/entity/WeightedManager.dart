import 'package:flutter_project/src/model/entity/Weighted.dart';

class WeightedManager {
    Weighted? roll(double nothingWeight, List<Weighted> weightedList) {

    double totalWeight = nothingWeight +
        weightedList.fold(0, (sum, item) => sum + item.weight);

    double randomValue = totalWeight * (DateTime.now().millisecondsSinceEpoch % 1000) / 1000;

    if (randomValue < nothingWeight) {
      return null;
    }

    double cumulativeWeight = nothingWeight;
    for (var weighted in weightedList) {
      cumulativeWeight += weighted.weight;
      if (randomValue < cumulativeWeight) {
        return weighted;
      }
    }

    throw Exception("Invalid weighted configuration");
  }
}