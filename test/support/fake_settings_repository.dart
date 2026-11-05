import 'package:sleman_runs/core/result/result.dart';
import 'package:sleman_runs/features/settings/domain/entities/app_settings.dart';
import 'package:sleman_runs/features/settings/domain/repositories/settings_repository.dart';

/// Non-persistent settings store for widget and golden tests.
class FakeSettingsRepository implements SettingsRepository {
  FakeSettingsRepository([this.settings = const AppSettings()]);

  AppSettings settings;

  @override
  Future<Result<AppSettings>> read() async => ok(settings);

  @override
  Future<Result<AppSettings>> write(AppSettings next) async {
    settings = next;
    return ok(settings);
  }
}
