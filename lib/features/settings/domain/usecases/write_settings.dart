import 'package:sleman_runs/core/result/result.dart';
import 'package:sleman_runs/features/settings/domain/entities/app_settings.dart';
import 'package:sleman_runs/features/settings/domain/repositories/settings_repository.dart';

final class WriteSettings {
  const WriteSettings(this._repository);

  final SettingsRepository _repository;

  Future<Result<AppSettings>> call(AppSettings settings) =>
      _repository.write(settings);
}
