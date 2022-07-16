import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class offlineFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class serverFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class emptyCashFailure extends Failure {
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