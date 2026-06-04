const String landingStorageKey = 'dr_cleaner_landing';

String? Function()? _landingReader;

void registerLandingReader(String? Function() reader) {
  _landingReader = reader;
}

String? readLandingFromStorage() => _landingReader?.call();
