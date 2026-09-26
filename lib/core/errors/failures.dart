import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class AssetFailure extends Failure {
  const AssetFailure(super.message);
}

class ParseFailure extends Failure {
  const ParseFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class VideoFailure extends Failure {
  const VideoFailure(super.message);
}
