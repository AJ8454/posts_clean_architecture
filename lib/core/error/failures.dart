import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

// internet failures
class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

// server database failures
class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

// empty cache failures
class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}
