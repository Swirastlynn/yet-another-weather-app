/// A failure with the title and message that could be easly displayed as a dialog or snackbar
class DisplayableFailure {
  DisplayableFailure({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;
}

abstract class HasDisplayableFailure {
  DisplayableFailure displayableFailure();
}
