import 'package:sleman_runs/core/result/result.dart';
import 'package:sleman_runs/features/settings/domain/entities/app_settings.dart';

/// Persistence port for user preferences.
///
/// The implementation is allowed to change (SharedPreferences today, a synced
/// profile later) without touching the domain or presentation layers.
abstract interface class SettingsRepository {
  Future<Result<AppSettings>> read();

  Future<Result<AppSettings>> write(AppSettings settings);
}
