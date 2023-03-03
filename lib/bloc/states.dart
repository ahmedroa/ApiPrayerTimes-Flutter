abstract class AlahdanStates {}

class AlahadnInitialState extends AlahdanStates {}

class AladanPrayerTimeLoadingState extends AlahdanStates {}

class AladanPrayerTimeSuccessState extends AlahdanStates {}

class AppCheanModeState extends AlahdanStates {}

class AladanPrayerTimeErrorState extends AlahdanStates {
  final String error;

  AladanPrayerTimeErrorState(this.error);
}

// chang city
class AlahdanChangeCityState extends AlahdanStates {}
