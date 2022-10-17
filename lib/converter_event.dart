import 'main.dart';

abstract class ConverterEvent extends MyApp {
  const ConverterEvent();
  @override
  List<Object?> get props => [];
}

class OpenMyDocument extends ConverterEvent {
  OpenMyDocument();
}

class ConverterDocument extends ConverterEvent {
  ConverterDocument();
}

class DownloadDocument extends ConverterEvent {
  DownloadDocument();
}
