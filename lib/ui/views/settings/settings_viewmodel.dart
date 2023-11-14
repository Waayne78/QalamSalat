import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home/state/settings_state.dart';

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier(ref);
});

class SettingsNotifier extends StateNotifier<SettingsState> {
  // ignore: unused_field
  final StateNotifierProviderRef<SettingsNotifier, SettingsState> _ref;

  SettingsNotifier(this._ref) : super(SettingsState.initial()) {}
}
