/// Distance unit chosen by the user.
///
/// This is a preference, not a translation: an Arabic-speaking user in Cairo
/// still expects kilometres, and an English-speaking user in London may want
/// miles.
enum DistanceUnit {
  kilometers(suffix: 'km', metersPerUnit: 1000),
  miles(suffix: 'mi', metersPerUnit: 1609.344)
  ;

  const DistanceUnit({required this.suffix, required this.metersPerUnit});

  final String suffix;
  final double metersPerUnit;
}
