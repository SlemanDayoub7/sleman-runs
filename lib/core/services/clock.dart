/// Time source, injected so domain logic and tests never call
/// `DateTime.now()` directly.
typedef Clock = DateTime Function();

DateTime systemClock() => DateTime.now();
