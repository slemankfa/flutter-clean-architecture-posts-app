import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmptyCashFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// Auth when login
// class wrongDataFailure extends Failure {
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }