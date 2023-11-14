class LocationState {
  final bool isUsingGPS;

  LocationState({required this.isUsingGPS});

  LocationState copyWith({bool? isUsingGPS}) {
    return LocationState(
      isUsingGPS: isUsingGPS ?? this.isUsingGPS,
    );
  }
}
