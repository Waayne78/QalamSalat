import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../home/state/location_state.dart';

class LocationViewModel extends StateNotifier<LocationState> {
  LocationViewModel() : super(LocationState(isUsingGPS: true));

  void setLocationChoice(bool isUsingGPS) {
    state = state.copyWith(isUsingGPS: isUsingGPS);
  }
}

final locationProvider =
    StateNotifierProvider<LocationViewModel, LocationState>((ref) {
  return LocationViewModel();
});
