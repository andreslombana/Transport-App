import 'package:equatable/equatable.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/domain/models/DriverPosition.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/BlocFormItem.dart';

class DriverClientRequestsState extends Equatable {
  final Resource<List<ClientRequestResponse>>? response;
  final Resource<bool>? responseCreateDriverTripRequest;
  final int? idDriver;
  final Resource<DriverPosition>? responseDriverPosition;
  final BlocFormItem fareOffered;

  const DriverClientRequestsState({
    this.response,
    this.responseCreateDriverTripRequest,
    this.idDriver,
    this.responseDriverPosition,
    this.fareOffered = const BlocFormItem(value: ''),
  });

  DriverClientRequestsState copyWith({
    Resource<List<ClientRequestResponse>>? response,
    Resource<bool>? responseCreateDriverTripRequest,
    int? idDriver,
    Resource<DriverPosition>? responseDriverPosition,
    BlocFormItem? fareOffered,
  }) {
    return DriverClientRequestsState(
      response: response ?? this.response,
      responseCreateDriverTripRequest: responseCreateDriverTripRequest ?? this.responseCreateDriverTripRequest,
      idDriver: idDriver ?? this.idDriver,
      responseDriverPosition: responseDriverPosition ?? this.responseDriverPosition,
      fareOffered: fareOffered ?? this.fareOffered,
    );
  }

  @override
  List<Object?> get props => [
        response,
        responseCreateDriverTripRequest,
        idDriver,
        responseDriverPosition,
        fareOffered,
      ];
}