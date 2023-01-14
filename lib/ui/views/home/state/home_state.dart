class HomeState {
  final DateTime dateChoisie;
  final List<String> horairesToday;
  final List<String> horaires;
  final String nextPrayer;
  final int countdown;

  HomeState(
      {required this.dateChoisie,
      required this.horaires,
      required this.horairesToday,
      required this.nextPrayer,
      required this.countdown});

  factory HomeState.initial() {
    return HomeState(
        dateChoisie: DateTime.now(),
        horaires: [],
        horairesToday: [],
        nextPrayer: "???",
        countdown: -1);
  }

  HomeState copyWith(
      {DateTime? dateChoisie,
      List<String>? horaires,
      List<String>? horairesToday,
      String? nextPrayer,
      int? countdown}) {
    return HomeState(
        dateChoisie: dateChoisie ?? this.dateChoisie,
        horaires: horaires ?? this.horaires,
        horairesToday: horairesToday ?? this.horairesToday,
        nextPrayer: nextPrayer ?? this.nextPrayer,
        countdown: countdown ?? this.countdown);
  }
}
