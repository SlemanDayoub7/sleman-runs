import 'package:sleman_runs/app/l10n/generated/app_localizations.dart';
import 'package:sleman_runs/core/error/failure.dart';

/// One user-facing sentence per failure code.
extension FailureMessages on AppLocalizations {
  String messageFor(FailureCode code) {
    return switch (code) {
      FailureCode.permission => errorPermission,
      FailureCode.locationUnavailable => errorLocationUnavailable,
      FailureCode.storage => errorStorage,
      FailureCode.validation => errorValidation,
      FailureCode.unknown => errorUnexpected,
    };
  }
}
