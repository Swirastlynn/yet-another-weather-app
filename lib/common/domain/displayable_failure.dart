/// A failure with the title and message that could be easly displayed as a dialog or snackbar
class DisplayableFailure {
  DisplayableFailure({
    required this.title,
    required this.message,
  });

  DisplayableFailure.commonError([String? message])
      : title = "common Error", //appLocalizations.commonErrorTitle,
        message = message ??
            "common Error"; //appLocalizations.commonErrorMessage;

  final String title;
  final String message;
}

abstract class HasDisplayableFailure {
  DisplayableFailure displayableFailure();
}
